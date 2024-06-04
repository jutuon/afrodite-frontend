import "dart:io";

import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/assets.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/logic/account/account.dart";
import "package:pihka_frontend/logic/account/demo_account.dart";
import "package:pihka_frontend/logic/app/navigator_state.dart";
import "package:pihka_frontend/logic/sign_in_with.dart";
import "package:pihka_frontend/model/freezed/logic/account/demo_account.dart";
import "package:pihka_frontend/model/freezed/logic/main/navigator_state.dart";
import "package:pihka_frontend/ui/login.dart";
import "package:pihka_frontend/ui_utils/consts/colors.dart";
import "package:pihka_frontend/ui_utils/loading_dialog.dart";
import "package:pihka_frontend/ui_utils/root_screen.dart";
import "package:pihka_frontend/ui_utils/app_bar/common_actions.dart";
import "package:pihka_frontend/ui_utils/app_bar/menu_actions.dart";
import "package:pihka_frontend/ui_utils/text_field.dart";

import "package:sign_in_with_apple/sign_in_with_apple.dart";


import 'package:pihka_frontend/localizations.dart';
import "package:url_launcher/url_launcher_string.dart";

// TODO(prod): Use SVG for sign in with google button
// TODO(prod): Sign in with buttons dark theme support

// TODO(prod): Show progress when sign in with google/apple returns and
// connecting to server starts

class LoginScreen extends RootScreen {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    // Init AccountBloc so that the initial setup UI does not change from
    // text field to only text when sign in with login is used.
    context.read<AccountBloc>();

    return Scaffold(
      body: Column(
        children: [
          Expanded(child: screenContent()),
          ProgressDialogOpener<DemoAccountBloc, DemoAccountBlocData>(
            dialogVisibilityGetter:
              (state) => state.loginProgressVisible,
            loadingText:
              context.strings.login_screen_demo_account_login_progress_dialog,
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: null,
        actions: [
          menuActions([
            MenuItemButton(
              child: Text(context.strings.login_screen_action_demo_account_login),
              onPressed: () {
                final demoAccountBloc = context.read<DemoAccountBloc>();
                openFirstDemoAccountLoginDialog(context)
                  .then((value) {
                    if (value != null) {
                      demoAccountBloc.add(DoDemoAccountLogin(value));
                    }
                  });
              },
            ),
            // TODO(prod): remove
            MenuItemButton(
              child: Text("Old login"),
              onPressed: () {
                MyNavigator.push(context, MaterialPage<void>(child: LoginScreenOld()));
              },
            ),
            ...commonActionsWhenLoggedOut(context),
          ]),
        ],
      ),
    );
  }

  Widget screenContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  logoAndAppNameAndSlogan(context),
                  const Spacer(flex: 10),
                  signInButtonArea(context),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

const BUTTON_HEIGHT = 50.0;

Widget signInButtonArea(BuildContext context) {
  const COMMON_PADDING = 8.0;

  return Column(
    children: [
      const Padding(padding: EdgeInsets.symmetric(vertical: COMMON_PADDING)),
      // MYSTERY: Without this Row, there is overflow warning if screen is rotated
      // for some reason. Content height is larger than screen height in
      // this case.
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: termsOfServiceAndPrivacyPolicyInfo(context)
          ),
        ],
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: COMMON_PADDING)),
      // TODO(prod): Add more padding?
      SizedBox(
        width: 240,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            firstSignInButton(context),
            const Padding(padding: EdgeInsets.symmetric(vertical: COMMON_PADDING)),
            secondSignInButton(context),
          ],
        ),
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: COMMON_PADDING)),
    ],
  );
}

Widget termsOfServiceAndPrivacyPolicyInfo(BuildContext context) {
  // NOTE: Adding spaces like this does not work for all languages.

  final textStyle = Theme.of(context).textTheme.bodyLarge;
  final linkStyle = textStyle?.copyWith(
    color: LINK_COLOR,
  );

  return RichText(text: TextSpan(
    text: "${context.strings.login_screen_login_note_text_beginning} ",
    style: textStyle,
    children: [
      TextSpan(
        text: context.strings.login_screen_login_note_text_tos,
        style: linkStyle,
        recognizer: TapGestureRecognizer()
          ..onTap = () => launchUrlString(context.strings.url_app_tos_link)
      ),
      TextSpan(text: " ${context.strings.login_screen_login_note_text_and} "),
      TextSpan(
        text: context.strings.login_screen_login_note_text_privacy_policy,
        style: linkStyle,
        recognizer: TapGestureRecognizer()
          ..onTap = () => launchUrlString(context.strings.url_app_privacy_policy_link)
      ),
      const TextSpan(text: "."),
    ],
  ));
}

Widget firstSignInButton(BuildContext context) {
  if (Platform.isIOS) {
    return signInWithAppleButton(context);
  } else {
    return signInWithGoogleButton(context);
  }
}

Widget secondSignInButton(BuildContext context) {
  if (Platform.isIOS) {
    return signInWithGoogleButton(context);
  } else {
    return signInWithAppleButton(context);
  }
}

Widget signInWithAppleButton(BuildContext context) {
  return SignInWithAppleButton(
    onPressed: () =>
      context.read<SignInWithBloc>().add(SignInWithAppleEvent()),
    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
    height: BUTTON_HEIGHT,
  );
}

Widget signInWithGoogleButton(BuildContext context) {
  return IconButton(
    icon: Image.asset(
      ImageAsset.signInWithGoogleButtonImage().path,
      width: null,
      height: BUTTON_HEIGHT,
    ),
    padding: EdgeInsets.zero,
    onPressed: () =>
      context.read<SignInWithBloc>().add(SignInWithGoogle()),
  );
}

Widget logoAndAppNameAndSlogan(BuildContext context) {
  const APP_ICON_SIZE = 100.0;
  final logoRow = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        ImageAsset.appLogo.path,
        width: APP_ICON_SIZE,
        height: APP_ICON_SIZE,
      ),
      Text(context.strings.app_name, style: Theme.of(context).textTheme.headlineMedium),
    ],
  );

  return Column(
    children: [
      logoRow,
      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
      Text(context.strings.app_slogan, style: Theme.of(context).textTheme.titleLarge),
    ],
  );
}


Future<DemoAccountCredentials?> openFirstDemoAccountLoginDialog(BuildContext context) {
  final idField = SimpleTextField(
    hintText: context.strings.login_screen_demo_account_identifier,
    // TODO(prod): remove default username and password
    getInitialValue: () => context.read<DemoAccountBloc>().state.userId ?? "test",
  );
  final passwordField = SimpleTextField(
    hintText: context.strings.login_screen_demo_account_password,
    obscureText: true,
    getInitialValue: () => context.read<DemoAccountBloc>().state.password ?? "tThlYqVHIiY=",
  );
  final pageKey = PageKey();
  return MyNavigator.showDialog<DemoAccountCredentials?>(
    context: context,
    pageKey: pageKey,
    builder: (context) => AlertDialog(
      title: Text(context.strings.login_screen_demo_account_dialog_title),
      content: Column(
        children: [
          Text(context.strings.login_screen_demo_account_dialog_description),
          idField,
          passwordField,
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            MyNavigator.removePage(context, pageKey);
          },
          child: Text(context.strings.generic_cancel)
        ),
        TextButton(
          onPressed: () {
            MyNavigator.removePage(
              context,
              pageKey,
              DemoAccountCredentials(
                idField.controller.text,
                passwordField.controller.text
              )
            );
          },
          child: Text(context.strings.generic_login)
        )
      ],
      scrollable: true,
    )
  );
}
