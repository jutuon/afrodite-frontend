

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_payload.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/bottom_navigation_state.dart';
import 'package:pihka_frontend/logic/app/like_grid_instance_manager.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/app/notification_payload_handler.dart';
import 'package:pihka_frontend/logic/media/current_moderation_request.dart';
import 'package:pihka_frontend/model/freezed/logic/main/notification_payload_handler.dart';
import 'package:pihka_frontend/ui/normal/chat/conversation_page.dart';
import 'package:pihka_frontend/ui/normal/likes.dart';
import 'package:pihka_frontend/ui/normal/settings/media/current_moderation_request.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';
import 'package:pihka_frontend/utils/result.dart';

final log = Logger("NotificationPayloadHandler");

class NotificationPayloadHandler extends StatefulWidget {
  const NotificationPayloadHandler({super.key});

  @override
  State<NotificationPayloadHandler> createState() => _NotificationPayloadHandlerState();
}

class _NotificationPayloadHandlerState extends State<NotificationPayloadHandler> {
  NotificationPayload? appLaunchPayload;

  @override
  void initState() {
    super.initState();
    appLaunchPayload = NotificationManager.getInstance().getAndRemoveAppLaunchNotificationPayload();
  }

  @override
  Widget build(BuildContext context) {
    final launchPayload = appLaunchPayload;
    if (launchPayload != null) {
      appLaunchPayload = null;
      log.info("Handling app launch notification payload");
      createHandlePayloadCallback(context, showError: true)(launchPayload);
    }

    return BlocBuilder<NotificationPayloadHandlerBloc, NotificationPayloadHandlerData>(
      buildWhen: (previous, current) => previous.toBeHandled != current.toBeHandled,
      builder: (context, state) {
        final payload = state.toBeHandled.firstOrNull;
        if (payload != null) {
          context.read<NotificationPayloadHandlerBloc>().add(
            HandleFirstPayload(createHandlePayloadCallback(context, showError: true)),
          );
        }

        return const SizedBox.shrink();
      }
    );
  }

  Future<void> Function(NotificationPayload) createHandlePayloadCallback(BuildContext context, {required bool showError}) {
    final navigatorStateBloc = context.read<NavigatorStateBloc>();
    final bottomNavigatorStateBloc = context.read<BottomNavigationStateBloc>();
    final likeGridInstanceBloc = context.read<LikeGridInstanceManagerBloc>();
    final currentModerationRequestBloc = context.read<CurrentModerationRequestBloc>();

    return (payload) async {
      await handlePayload(
        payload,
        navigatorStateBloc,
        bottomNavigatorStateBloc,
        likeGridInstanceBloc,
        currentModerationRequestBloc,
        showError: showError,
      );
    };
  }
}

Future<void> handlePayload(
  NotificationPayload payload,
  NavigatorStateBloc navigatorStateBloc,
  BottomNavigationStateBloc bottomNavigationStateBloc,
  LikeGridInstanceManagerBloc likeGridInstanceManagerBloc,
  CurrentModerationRequestBloc currentModerationRequestBloc,
  {required bool showError}
) async {
  final db = DatabaseManager.getInstance();

  final notificationSessionId = await db.commonStreamSingle((db) => db.watchNotificationSessionId());
  if (notificationSessionId?.id != payload.sessionId.id) {
    log.warning("Notification payload session ID does not match current session ID");
    if (showError) {
      showSnackBar(R.strings.notification_session_expired_error);
    }
    return;
  }

  switch (payload) {
    case NavigateToConversation():
      final profile = await db.profileData((db) => db.getProfileEntryUsingLocalId(payload.profileLocalDbId)).ok();
      if (profile != null) {
        await openConversationScreenNoBuildContext(
          navigatorStateBloc,
          profile,
        );
      }
    case NavigateToLikes():
      if (navigatorStateBloc.state.pages.length == 1) {
        bottomNavigationStateBloc.add(ChangeScreen(BottomNavigationScreenId.likes));
      } else {
        await openLikesScreenNoBuildContext(navigatorStateBloc, likeGridInstanceManagerBloc);
      }
    case NavigateToModerationRequestStatus():
      await navigatorStateBloc.push(
        MaterialPage<void>(
          child: CurrentModerationRequestScreen(
            currentModerationRequestBloc: currentModerationRequestBloc,
          ),
        ),
      );
  }
}

// TODO: Thinking about the server side iterator for likes:
//
// If there is no reset iterator command in server API,
// then the next page API should have the iterator
// origin point as a parameter? Perhaps AccountId could be used for that?
// Actually that is not possible as for example that specific AccountId can be
// removed from likes. Perhaps use timestamp instead? Then the likeing time
// is exposed from API. Autoincrementing like ID perhaps could be used if
// those are unique.

// TODO: Notification settings. On Android 8 or later system notification
// settings should be opened.
