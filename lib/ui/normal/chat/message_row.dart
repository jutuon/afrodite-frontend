


import 'package:flutter/material.dart';
import 'package:database/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';

Align messageRowWidget(BuildContext context, MessageEntry entry, {Key? key, required TextStyle parentTextStyle}) {
  final (message, sentMessageState, receivedMessageState) = (entry.messageText, entry.sentMessageState, entry.receivedMessageState);
  final isSent = sentMessageState != null;
  return Align(
    //key: key,
    alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
    child: FractionallySizedBox(
      widthFactor: 0.8,
      child: Row(
        children: [
          Expanded(
            child: Align(
              key: key,
              alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
              child: GestureDetector(
                onLongPress: () => openMessageMenu(context, entry),
                child: _messageAndErrorWidget(context, message, sentMessageState, receivedMessageState, parentTextStyle: parentTextStyle),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _messageAndErrorWidget(
  BuildContext context,
  String message,
  SentMessageState? sentMessageState,
  ReceivedMessageState? receivedMessageState,
  {
    required TextStyle parentTextStyle
  }
) {
  if (sentMessageState != null) {
    // Sent message
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 1,
          child: Visibility(
            visible: sentMessageState.isError(),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Icon(Icons.error, color: Theme.of(context).colorScheme.error),
          ),
        ),
        Flexible(
          flex: 10,
          child: _messageWidget(context, message, sentMessageState, receivedMessageState, parentTextStyle: parentTextStyle),
        ),
      ],
    );
  } else {
    // Received message
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (receivedMessageState?.isError() ?? false) Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(Icons.error, color: Theme.of(context).colorScheme.error),
            ),
          ),
        Flexible(
          flex: 10,
          child: _messageWidget(context, message, sentMessageState, receivedMessageState, parentTextStyle: parentTextStyle),
        ),
      ],
    );
  }
}

String messageWidgetText(
  BuildContext context,
  String message,
  SentMessageState? sentMessageState,
  ReceivedMessageState? receivedMessageState,
) {
  if (receivedMessageState == ReceivedMessageState.decryptingFailed) {
    return context.strings.conversation_screen_message_state_decrypting_failed;
  } else if (receivedMessageState == ReceivedMessageState.unknownMessageType) {
    return context.strings.conversation_screen_message_state_unknown_message_type;
  } else {
    return message;
  }
}

Widget _messageWidget(
  BuildContext context,
  String message,
  SentMessageState? sentMessageState,
  ReceivedMessageState? receivedMessageState,
  {
    required TextStyle parentTextStyle,
  }
) {
  final String text = messageWidgetText(context, message, sentMessageState, receivedMessageState);
  final showErrorColor =
    (sentMessageState?.isError() ?? false) ||
    (receivedMessageState?.isError() ?? false);
  final styleChanges = TextStyle(
    // color: Theme.of(context).colorScheme.onPrimary,
    color: showErrorColor ?
      Theme.of(context).colorScheme.onErrorContainer :
      Theme.of(context).colorScheme.onPrimaryContainer,
    fontSize: 16.0,
  );
  final style = parentTextStyle.merge(styleChanges);
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    decoration: BoxDecoration(
      // color: Theme.of(context).colorScheme.primary,
      color: showErrorColor ?
        Theme.of(context).colorScheme.errorContainer :
        Theme.of(context).colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(text, style: style),
  );
}

void openMessageMenu(BuildContext screenContext, MessageEntry entry) {
  if (!screenContext.mounted) {
    return;
  }
  FocusScope.of(screenContext).unfocus();

  final pageKey = PageKey();
  MyNavigator.showDialog<void>(
    context: screenContext,
    pageKey: pageKey,
    builder: (context) => SimpleDialog(
      children: [
        ListTile(
          title: Text(context.strings.generic_details),
          onTap: () async {
            closeActionsAndOpenDetails(screenContext, entry, pageKey);
          },
        ),
        if (entry.sentMessageState == SentMessageState.sendingError) ListTile(
          title: Text(context.strings.generic_delete),
          onTap: () async {
            final bloc = screenContext.read<ConversationBloc>();
            if (bloc.state.isMessageRemovingInProgress || bloc.state.isMessageResendingInProgress) {
              showSnackBar(context.strings.generic_previous_action_in_progress);
            } else {
              bloc.add(RemoveSendFailedMessage(entry.remoteAccountId, entry.localId));
            }
            MyNavigator.removePage(context, pageKey, null);
          },
        ),
        if (entry.sentMessageState == SentMessageState.sendingError) ListTile(
          title: Text(context.strings.generic_resend),
          onTap: () async {
            final bloc = screenContext.read<ConversationBloc>();
            if (bloc.state.isMessageRemovingInProgress || bloc.state.isMessageResendingInProgress) {
              showSnackBar(context.strings.generic_previous_action_in_progress);
            } else {
              bloc.add(ResendSendFailedMessage(entry.remoteAccountId, entry.localId));
            }
            MyNavigator.removePage(context, pageKey, null);
          },
        ),
      ],
    )
  );
}

void closeActionsAndOpenDetails(BuildContext screenContext, MessageEntry entry, PageKey existingPageKey) {
  if (!screenContext.mounted) {
    return;
  }

  final String stateText;
  if (entry.sentMessageState == SentMessageState.pending) {
    stateText = screenContext.strings.conversation_screen_message_state_sending_in_progress;
  } else if (entry.sentMessageState == SentMessageState.sendingError) {
    stateText = screenContext.strings.conversation_screen_message_state_sending_failed;
  } else if (entry.sentMessageState == SentMessageState.sent) {
    stateText = screenContext.strings.conversation_screen_message_state_sent_successfully;
  } else if (entry.receivedMessageState == ReceivedMessageState.received) {
    stateText = screenContext.strings.conversation_screen_message_state_received_successfully;
  } else if (entry.receivedMessageState == ReceivedMessageState.decryptingFailed) {
    stateText = screenContext.strings.conversation_screen_message_state_decrypting_failed;
  } else if (entry.receivedMessageState == ReceivedMessageState.unknownMessageType) {
    stateText = screenContext.strings.conversation_screen_message_state_unknown_message_type;
  } else {
    stateText = "";
  }

  final time = entry.unixTime ?? entry.localUnixTime;

  final infoText = """
${screenContext.strings.generic_message}: ${entry.messageText}
${screenContext.strings.conversation_screen_message_details_message_id}: ${entry.messageNumber?.messageNumber}
${screenContext.strings.generic_time}: ${time.dateTime.toIso8601String()}
${screenContext.strings.generic_state}: $stateText""";

  showInfoDialog(
    screenContext,
    infoText,
    existingPageToBeRemoved: existingPageKey,
  );
}
