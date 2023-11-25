import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/profile/profile_iterator_manager.dart';
import 'package:pihka_frontend/data/profile/profile_list/online_iterator.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:pihka_frontend/logic/profile/profile_filtering_settings/profile_filtering_settings.dart';
import 'package:pihka_frontend/logic/profile/view_profiles/view_profiles.dart';
import 'package:pihka_frontend/ui/normal/chat/conversation_page.dart';
import 'package:pihka_frontend/ui/normal/chat/debug_page.dart';
import 'package:pihka_frontend/ui/normal/profiles/filter_profiles.dart';
import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:pihka_frontend/ui/utils.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pihka_frontend/ui/utils/image_page.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';

var log = Logger("ProfileView");

class ProfileView extends BottomNavigationView {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();

  @override
  String title(BuildContext context) {
    return AppLocalizations.of(context).pageProfileGridTitle;
  }

  @override
  List<Widget>? actions(BuildContext context) {
    return [
      IconButton(
        icon: BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
          builder: (context, state) {
            if (state == ProfileFilteringSettingsData()) {
              return const Icon(Icons.filter_alt_outlined);
            } else {
              return const Icon(Icons.filter_alt_rounded);
            }
          },
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const ProfileFilteringSettingsPage()));
        },
      ),
      IconButton(
        icon: const Icon(Icons.chat_bubble_outline_rounded),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute<void>(builder: (_) => ChatViewDebuggerPage(AccountId(accountId: ""))));
        },
      ),
      IconButton(
        icon: const Icon(Icons.chat_bubble_rounded),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute<void>(builder: (_) => ChatViewDebuggerPage(AccountId(accountId: ""), initialMsgCount: 5)));
        },
      ),
    ];
  }
}

typedef ProfileViewEntry = (ProfileEntry profile, File img, int heroNumber);

class _ProfileViewState extends State<ProfileView> {
  PagingController<int, ProfileViewEntry>? _pagingController =
    PagingController(firstPageKey: 0);
  int _heroUniqueIdCounter = 0;
  StreamSubscription<ProfileChange>? _profileChangesSubscription;
  ProfileFilteringSettingsData currentFilteringSettings = ProfileFilteringSettingsData();

  @override
  void initState() {
    super.initState();
    _heroUniqueIdCounter = 0;
    _pagingController?.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = ProfileRepository.getInstance().profileChanges.listen((event) {
        handleProfileChange(event);
    });
  }

  void handleProfileChange(ProfileChange event) {
    switch (event) {
      case ProfileNowPrivate(): {
        // Remove profile if it was made private
        removeAccountIdFromList(event.profile);
      }
      case ProfileBlocked():
        removeAccountIdFromList(event.profile);
      case ProfileFavoriteStatusChange(): {
        // Remove profile if favorites filter is enabled and favorite status is changed to false
        final controller = _pagingController;
        if (controller != null && event.isFavorite == false && currentFilteringSettings.showOnlyFavorites) {
          setState(() {
            controller.itemList?.removeWhere((item) => item.$1.uuid == event.profile.accountId);
          });
        }
      }
      case ProfileUnblocked() ||
        ConversationChanged() ||
        MatchesChanged() ||
        LikesChanged(): {}
    }
  }

  void removeAccountIdFromList(AccountId accountId) {
    final controller = _pagingController;
    if (controller != null) {
      setState(() {
        controller.itemList?.removeWhere((item) => item.$1.uuid == accountId.accountId);
      });
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    if (pageKey == 0) {
      ProfileRepository.getInstance().resetIteratorToBeginning();
    }

    final profileList = await ProfileRepository.getInstance().nextList();

    // Get images here instead of FutureBuilder because there was some weird
    // Hero tag error even if the builder index is in the tag.
    // Not sure does this image loading change affect the issue.
    // The PagedChildBuilderDelegate seems to run the builder twice for some
    // reason for the initial page.
    final newList = List<ProfileViewEntry>.empty(growable: true);
    for (final profile in profileList) {
      final accountId = AccountId(accountId: profile.uuid);
      final contentId = ContentId(contentId: profile.imageUuid);
      final file = await ImageCacheData.getInstance().getImage(accountId, contentId);
      if (file == null) {
        log.warning("Skipping one profile because image loading failed");
        continue;
      }
      newList.add((profile, file, _heroUniqueIdCounter));
      _heroUniqueIdCounter++;
    }

    if (profileList.isEmpty) {
      _pagingController?.appendLastPage([]);
    } else {
      _pagingController?.appendPage(newList, pageKey + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await ProfileRepository.getInstance().refreshProfileIterator();
        // This might be disposed after resetProfileIterator completes.
        _pagingController?.refresh();
      },
      child: BlocListener<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
        listener: (context, data) {
          // Filtering settings changed
          currentFilteringSettings = data;
          setState(() {
            _pagingController?.refresh();
          });
        },
        child: grid(context),
      ),
    );
  }

  Widget grid(BuildContext context) {
    return PagedGridView(
      pagingController: _pagingController!,
      builderDelegate: PagedChildBuilderDelegate<ProfileViewEntry>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          final accountId = AccountId(accountId: item.$1.uuid);
          final heroTag = (accountId, item.$3);
          return GestureDetector(
            onTap: () {
              openProfileView(context, accountId, item.$1, item.$2, heroTag);
            },
            child: Hero(
              tag: heroTag,
              child: Image.file(item.$2)
            )
          );
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
    );
  }

  @override
  void dispose() {
    _pagingController?.dispose();
    _pagingController = null;
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = null;
    super.dispose();
  }
}
