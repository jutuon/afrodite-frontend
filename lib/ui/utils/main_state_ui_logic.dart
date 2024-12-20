


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/account/account_details.dart';
import 'package:app/logic/account/initial_setup.dart';
import 'package:app/logic/account/news/news_count.dart';
import 'package:app/logic/app/bottom_navigation_state.dart';
import 'package:app/logic/app/main_state.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/app/notification_payload_handler.dart';
import 'package:app/logic/app/notification_permission.dart';
import 'package:app/logic/app/notification_settings.dart';
import 'package:app/logic/chat/conversation_list_bloc.dart';
import 'package:app/logic/chat/new_received_likes_available_bloc.dart';
import 'package:app/logic/chat/unread_conversations_bloc.dart';
import 'package:app/logic/media/content.dart';
import 'package:app/logic/media/initial_content_moderation.dart';
import 'package:app/logic/media/image_processing.dart';
import 'package:app/logic/media/new_moderation_request.dart';
import 'package:app/logic/media/profile_pictures.dart';
import 'package:app/logic/media/select_content.dart';
import 'package:app/logic/profile/attributes.dart';
import 'package:app/logic/profile/edit_my_profile.dart';
import 'package:app/logic/profile/edit_profile_filtering_settings.dart';
import 'package:app/logic/profile/location.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/logic/profile/profile_filtering_settings.dart';
import 'package:app/logic/settings/blocked_profiles.dart';
import 'package:app/logic/settings/edit_search_settings.dart';
import 'package:app/logic/settings/privacy_settings.dart';
import 'package:app/logic/settings/search_settings.dart';
import 'package:app/logic/settings/user_interface.dart';
import 'package:app/ui/account_banned.dart';
import 'package:app/ui/demo_account.dart';
import 'package:app/ui/initial_setup.dart';
import 'package:app/ui/login_new.dart';
import 'package:app/ui/normal.dart';
import 'package:app/ui/pending_deletion.dart';
import 'package:app/ui/unsupported_client.dart';
import 'package:app/ui/utils/notification_payload_handler.dart';

final log = Logger("MainStateUiLogic");

class MainStateUiLogic extends StatelessWidget {
  final Widget child;
  const MainStateUiLogic({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainStateBloc, MainState>(
      listener: (context, state) {
        final screen = switch (state) {
          MainState.loginRequired => const LoginScreen(),
          MainState.demoAccount => const DemoAccountScreen(),
          MainState.initialSetup => const InitialSetupScreen(),
          MainState.initialSetupComplete => const NormalStateScreen(),
          MainState.accountBanned => const AccountBannedScreen(),
          MainState.pendingRemoval => const PendingDeletionPage(),
          MainState.unsupportedClientVersion => const UnsupportedClientScreen(),
          MainState.splashScreen => null,
        };

        if (screen == null) {
          return;
        }

        var appLaunchPayloadNullable = NotificationManager.getInstance().getAndRemoveAppLaunchNotificationPayload();
        if (state != MainState.initialSetupComplete) {
          // Clear the app launch notification payload if it exists as
          // it should be handled only when state is
          // MainState.initialSetupComplete.
          appLaunchPayloadNullable = null;
          BottomNavigationStateBlocInstance.getInstance()
            .bloc
            .add(ChangeScreen(BottomNavigationScreenId.profiles, resetIsScrolledValues: true));
        }
        final appLaunchPayload = appLaunchPayloadNullable;
        final accountBackgroundDb = LoginRepository.getInstance().repositoriesOrNull?.accountBackgroundDb;
        final accountDb = LoginRepository.getInstance().repositoriesOrNull?.accountDb;

        final rootPage = NewPageDetails(
          MaterialPage<void>(child: screen),
        );

        if (appLaunchPayload != null && accountBackgroundDb != null && accountDb != null) {
          log.info("Handling app launch notification payload");
          createHandlePayloadCallback(
            context,
            accountBackgroundDb,
            accountDb,
            showError: false,
            navigateToAction: (bloc, page) {
              final pages = [rootPage];
              if (page != null) {
                pages.add(page);
              }
              bloc.replaceAllWith(
                pages,
                disableAnimation: true,
              );
            },
          )(appLaunchPayload);
        } else {
          MyNavigator.replaceAllWith(
            context,
            [rootPage],
          );
        }
      },
      child: stateSpecificBlocProvider(),
    );
  }

  Widget stateSpecificBlocProvider() {
    return BlocBuilder<MainStateBloc, MainState>(
      builder: (context, data) {
        final blocProvider = switch (data) {
          MainState.initialSetup => MultiBlocProvider(
            providers: [
              // Init AccountBloc so that the initial setup UI does not change from
              // text field to only text when sign in with login is used.
              BlocProvider(create: (_) => AccountBloc(), lazy: false),
              BlocProvider(create: (_) => InitialSetupBloc()),
              BlocProvider(create: (_) => SecuritySelfieImageProcessingBloc()),
              BlocProvider(create: (_) => ProfilePicturesImageProcessingBloc()),
              BlocProvider(create: (_) => ProfileAttributesBloc()),
              BlocProvider(create: (_) => ContentBloc()),
              BlocProvider(create: (_) => SelectContentBloc()),
              BlocProvider(create: (_) => ProfilePicturesBloc()),
            ],
            child: child,
          ),
          MainState.initialSetupComplete => MultiBlocProvider(
            providers: [
              // General
              BlocProvider(create: (_) => ProfilePicturesImageProcessingBloc()),
              BlocProvider(create: (_) => SecuritySelfieImageProcessingBloc()),
              BlocProvider(create: (_) => NotificationPermissionBloc()),
              BlocProvider(create: (_) => NotificationPayloadHandlerBloc()),
              BlocProvider(create: (_) => ProfileAttributesBloc()),
              BlocProvider(create: (_) => ConversationListBloc()),
              BlocProvider(create: (_) => UnreadConversationsCountBloc()),
              BlocProvider(create: (_) => NewReceivedLikesAvailableBloc()),

              // Account data
              BlocProvider(create: (_) => AccountBloc()),
              BlocProvider(create: (_) => ContentBloc()),
              BlocProvider(create: (_) => LocationBloc()),
              BlocProvider(create: (_) => MyProfileBloc()),
              BlocProvider(create: (_) => AccountDetailsBloc()),
              BlocProvider(create: (_) => ProfileFilteringSettingsBloc()),

              // Settings
              BlocProvider(create: (_) => EditMyProfileBloc()),
              BlocProvider(create: (_) => EditProfileFilteringSettingsBloc()),
              BlocProvider(create: (_) => InitialContentModerationBloc()),
              BlocProvider(create: (_) => SelectContentBloc()),
              BlocProvider(create: (_) => NewModerationRequestBloc()),
              BlocProvider(create: (_) => ProfilePicturesBloc()),
              BlocProvider(create: (_) => PrivacySettingsBloc()),
              BlocProvider(create: (_) => BlockedProfilesBloc()),
              BlocProvider(create: (_) => SearchSettingsBloc()),
              BlocProvider(create: (_) => EditSearchSettingsBloc()),
              BlocProvider(create: (_) => NotificationSettingsBloc()),
              BlocProvider(create: (_) => UserInterfaceSettingsBloc()),

              // News
              BlocProvider(create: (_) => NewsCountBloc()),
            ],
            child: child,
          ),
          MainState.loginRequired ||
          MainState.demoAccount ||
          MainState.accountBanned ||
          MainState.pendingRemoval ||
          MainState.unsupportedClientVersion ||
          MainState.splashScreen => child,
        };

        return blocProvider;
      }
    );
  }
}
