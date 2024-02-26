

import 'package:flutter/material.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/main.dart';



// TODO: Show details button for displaying more detailed error message
void showSnackBar(String text) {
  globalScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  globalScaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(content: Text(text), behavior: SnackBarBehavior.floating)
  );
}

Future<bool?> showConfirmDialog(BuildContext context, String actionText, {String? details}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(actionText),
      content: details != null ? Text(details) : null,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(context.strings.genericCancel)
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(context.strings.genericOk)
        )
      ],
    )
  );
}

Future<bool?> showInfoDialog(BuildContext context, String text) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      content: SelectableText(text),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(context.strings.genericClose)
        ),
      ],
    )
  );
}

abstract class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({super.key});

  String title(BuildContext context);
  /// Action bar actions
  List<Widget>? actions(BuildContext context) => null;
}
