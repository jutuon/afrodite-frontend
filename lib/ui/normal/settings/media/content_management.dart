

import 'package:app/data/login_repository.dart';
import 'package:app/logic/media/content.dart';
import 'package:app/logic/media/select_content.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/media/content.dart';
import 'package:app/model/freezed/logic/media/select_content.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/utils/time.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui/normal/settings/media/select_content.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/view_image_screen.dart';
import 'package:app/utils/api.dart';
import 'package:utils/utils.dart';

class ContentManagementScreenOpener extends StatelessWidget {
  const ContentManagementScreenOpener({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentManagementScreen(
      selectContentBloc: context.read<SelectContentBloc>()
    );
  }
}

class ContentManagementScreen extends StatefulWidget {
  final SelectContentBloc selectContentBloc;
  const ContentManagementScreen({
    required this.selectContentBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<ContentManagementScreen> createState() => _ContentManagementScreenState();
}

class _ContentManagementScreenState extends State<ContentManagementScreen> {

  @override
  void initState() {
    super.initState();
    widget.selectContentBloc.add(ReloadAvailableContent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.content_management_screen_title),
      ),
      body: BlocBuilder<ContentBloc, ContentData>(
        builder: (context, contentState) {
          final securityContent = contentState.currentSecurityContent;
          return BlocBuilder<MyProfileBloc, MyProfileData>(
            builder: (context, myProfileState) {
              final myProfile = myProfileState.profile;
              return BlocBuilder<SelectContentBloc, SelectContentData>(
                builder: (context, state) {
                  final content = state.accountContent;
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (content == null || securityContent == null || myProfile == null) {
                    return Center(child: Text(context.strings.generic_error));
                  } else {
                    return selectContentPage(
                      context,
                      LoginRepository.getInstance().repositories.accountId,
                      content,
                      securityContent,
                      myProfile,
                    );
                  }
                }
              );
            }
          );
        }
      )
    );
  }

  Widget selectContentPage(
    BuildContext context,
    AccountId accountId,
    AccountContent content,
    ContentId securityContent,
    MyProfileEntry myProfile,
  ) {
    final List<Widget> listWidgets = [];

    listWidgets.addAll(
      content.data.reversed.map((e) => buildAvailableImg(
        context,
        accountId,
        e,
        content.unusedContentWaitSeconds,
        securityContent,
        myProfile,
      ))
    );

    final listView = ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: listWidgets,
    );

    final List<Widget> widgets = [];

    widgets.add(Padding(
      padding: const EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
      child: Text(context.strings.select_content_content_count(content.data.length.toString(), content.maxContentCount.toString())),
    ));

    widgets.add(listView);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      ),
    );
  }
}

Widget buildAvailableImg(
  BuildContext context,
  AccountId accountId,
  ContentInfoDetailed content,
  int unusedContentWaitSeconds,
  ContentId securityContent,
  MyProfileEntry myProfile,
) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 4.0,
      bottom: 4.0,
      left: COMMON_SCREEN_EDGE_PADDING,
      right: COMMON_SCREEN_EDGE_PADDING
    ),
    child: Row(
      children: [
        SizedBox(
          width: SELECT_CONTENT_IMAGE_WIDTH,
          height: SELECT_CONTENT_IMAGE_HEIGHT,
          child: Material(
            child: InkWell(
              onTap: () {
                MyNavigator.push(
                  context,
                  MaterialPage<void>(
                    child: ViewImageScreen(ViewImageAccountContent(accountId, content.cid))
                  )
                );
              },
              child: accountImgWidgetInk(accountId, content.cid),
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
        Expanded(
          child: Center(
            child: _statusInfo(
              context,
              accountId,
              content,
              unusedContentWaitSeconds,
              securityContent,
              myProfile,
            ),
          )
        )
      ],
    ),
  );
}


Widget _statusInfo(
  BuildContext context,
  AccountId accountId,
  ContentInfoDetailed content,
  int unusedContentWaitSeconds,
  ContentId securityContent,
  MyProfileEntry myProfile,
) {
  final String moderationState = switch (content.state) {
    ContentModerationState.inSlot => "",
    ContentModerationState.waitingBotOrHumanModeration => context.strings.moderation_state_waiting_bot_or_human_moderation,
    ContentModerationState.waitingHumanModeration => context.strings.moderation_state_waiting_human_moderation,
    ContentModerationState.acceptedByBot ||
    ContentModerationState.acceptedByHuman => context.strings.moderation_state_accepted,
    ContentModerationState.rejectedByBot => context.strings.moderation_state_rejected_by_bot,
    ContentModerationState.rejectedByHuman => context.strings.moderation_state_rejected_by_human,
    _ => "",
  };

  final List<String> stateTexts = [];
  if (moderationState.isNotEmpty) {
    stateTexts.add(moderationState);
  }

  Widget deleteButton;
  final usageStart = content.usageStartTime;
  final usageEnd = content.usageEndTime;
  if (usageStart != null) {
    if (content.cid == securityContent) {
      stateTexts.add(context.strings.content_management_screen_content_security_content);
    }
    for (final (i, c) in myProfile.content.indexed) {
      if (content.cid == c.id) {
        final contentNumber = i + 1;
        stateTexts.add(context.strings.content_management_screen_content_profile_content(contentNumber.toString()));
      }
    }
    deleteButton = const SizedBox.shrink();
  } else if (usageEnd != null) {
    final currentTime = UtcDateTime.now();
    final deletionAllowed = UnixTime(ut: usageEnd.ut + unusedContentWaitSeconds).toUtcDateTime();
    if (currentTime.difference(deletionAllowed).inSeconds >= 0) {
      deleteButton = _createDeleteButton(context, accountId, content.cid);
    } else {
      final timeString = fullTimeString(deletionAllowed);
      stateTexts.add(context.strings.content_management_screen_content_deletion_allowed_wait_time(timeString));
      deleteButton = const SizedBox.shrink();
    }
  } else {
    deleteButton = _createDeleteButton(context, accountId, content.cid);
  }

  final String totalText = stateTexts.join(", ");

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      if (totalText.isNotEmpty) Text(totalText, textAlign: TextAlign.center),
      if (totalText.isNotEmpty) const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
      deleteButton,
    ],
  );
}

Widget _createDeleteButton(BuildContext context, AccountId accountId, ContentId content) {
  return ElevatedButton(
    child: Text(context.strings.generic_delete),
    onPressed: () async {
      final bloc = context.read<SelectContentBloc>();
      final result = await _confirmDialogForImage(context, accountId, content);
      if (result == true && !bloc.isClosed) {
        bloc.add(DeleteContent(accountId, content));
      }
    },
  );
}


Future<bool?> _confirmDialogForImage(BuildContext context, AccountId account, ContentId content) async {
  Widget img = InkWell(
    onTap: () {
      MyNavigator.push(
        context,
        MaterialPage<void>(
          child: ViewImageScreen(ViewImageAccountContent(account, content))
        )
      );
    },
    // Width seems to prevent the dialog from expanding horizontaly
    child: accountImgWidget(account, content, height: 200, width: 150),
  );

  Widget dialog = AlertDialog(
    title: Text(context.strings.generic_delete_question),
    content: img,
    actions: [
      TextButton(
        onPressed: () {
          MyNavigator.pop(context, false);
        },
        child: Text(context.strings.generic_cancel),
      ),
      TextButton(
        onPressed: () {
          MyNavigator.pop(context, true);
        },
        child: Text(context.strings.generic_continue),
      ),
    ],
  );

  final pageKey = PageKey();
  return await MyNavigator.showDialog<bool?>(
    context: context,
    builder: (context) => dialog,
    pageKey: pageKey,
  );
}