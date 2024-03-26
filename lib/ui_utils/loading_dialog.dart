


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressDialogOpener<B extends StateStreamable<S>, S> extends StatefulWidget {
  /// Listener which returns true if the dialog should be opened and
  /// false if it should be closed.
  final bool Function(BuildContext, S) dialogVisibilityGetter;
  /// If null only the circular progress indicator is shown.
  final String? loadingText;
  /// Display widget where info text would be shown.
  final Widget Function(BuildContext, S)? stateInfoBuilder;
  const ProgressDialogOpener({
    required this.dialogVisibilityGetter,
    this.stateInfoBuilder,
    this.loadingText,
    Key? key
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProgressDialogOpenerState<B, S>();
}

class _ProgressDialogOpenerState<B extends StateStreamable<S>, S> extends State<ProgressDialogOpener<B, S>> {
  late S latestState;
  bool dialogIdealState = false;
  bool dialogRealState = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      buildWhen: (previous, current) =>
        widget.dialogVisibilityGetter(context, previous) != widget.dialogVisibilityGetter(context, current),
      builder: (context, state) {
        handleDialogStateChange(context, state);
        return const SizedBox.shrink();
      },
    );
  }

  void handleDialogStateChange(BuildContext context, S state) async {
    latestState = state;
    dialogIdealState = widget.dialogVisibilityGetter(context, state);

    if (dialogRealState) {
      // Dialog already open
      return;
    }

    if (dialogIdealState && !dialogRealState) {
      // Open dialog
      dialogRealState = true;

      // Check if the dialog should be opened multiple times (race conditions...)
      while (true) {
        if (dialogIdealState) {
          await openDialog(context, latestState);
        } else {
          break;
        }
      }

      dialogRealState = false;
    }
  }

  Future<void> openDialog(BuildContext context, S state) async {
    final Widget w;
    final text = widget.loadingText;
    final b = widget.stateInfoBuilder;
    if (text != null) {
      w = Text(text);
    } else if (b != null) {
      w = b(context, state);
    } else {
      w = const SizedBox.shrink();
    }

    await Future.delayed(Duration.zero, () async {
      if (context.mounted) {
        await _showLoadingDialog<B, S>(
          context,
          w,
          widget.dialogVisibilityGetter,
        );
      }
    });
  }
}

Future<void> _showLoadingDialog<B extends StateStreamable<S>, S>(
  BuildContext context,
  Widget loadingInfo,
  bool Function(BuildContext, S) dialogVisibilityGetter
) async {
  return await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
              loadingInfo,
              // Use BlocBuilder as it gets the initial state as well.
              BlocBuilder<B, S>(
                buildWhen: (previous, current) =>
                  dialogVisibilityGetter(context, previous) != dialogVisibilityGetter(context, current),
                builder: (context, state) {
                  if (!dialogVisibilityGetter(context, state)) {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      );
    },
  );
}
