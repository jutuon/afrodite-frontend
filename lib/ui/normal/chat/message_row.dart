


import 'package:flutter/material.dart';
import 'package:database/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/chat/conversation_bloc.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/time.dart';

const int _OPACITY_FOR_ON_SURFACE_CONTENT = 128;

Align messageRowWidget(BuildContext context, MessageEntry entry, {Key? keyFromMessageRenderer, required TextStyle parentTextStyle}) {
  final sentMessageState = entry.messageState.toSentState();
  final infoState = entry.messageState.toInfoState();
  final isSent = sentMessageState != null;

  Widget rowContent;
  if (infoState == null) {
    rowContent = FractionallySizedBox(
      widthFactor: 0.8,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
              child: GestureDetector(
                onLongPress: () => openMessageMenu(context, entry),
                child: _messageWidget(
                  context,
                  entry,
                  sentMessageState,
                  entry.messageState.toReceivedState(),
                  parentTextStyle: parentTextStyle
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } else {
    // Info message
    rowContent = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: infoMessage(context, infoState, parentTextStyle: parentTextStyle),
      ),
    );
  }

  return Align(
    key: keyFromMessageRenderer,
    alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
    child: rowContent,
  );
}

List<Widget> infoMessage(
  BuildContext context,
  InfoMessageState infoState,
  {
    required TextStyle parentTextStyle,
  }
) {
  final String text;
  final IconData iconData;
  switch (infoState) {
    case InfoMessageState.infoMatchFirstPublicKeyReceived:
      text = context.strings.conversation_screen_message_info_encryption_started;
      iconData = Icons.lock;
    case InfoMessageState.infoMatchPublicKeyChanged:
      text = context.strings.conversation_screen_message_info_encryption_key_changed;
      iconData = Icons.key;
  }
  final color = Theme.of(context).colorScheme.onSurface.withAlpha(_OPACITY_FOR_ON_SURFACE_CONTENT);
  final textStyle = parentTextStyle.merge(TextStyle(
    color: color,
    fontSize: 13.0,
  ));
  return [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Icon(iconData, color: color, size: 20),
    ),
    Text(text, style: textStyle),
  ];
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
  } else if (receivedMessageState == ReceivedMessageState.publicKeyDownloadFailed) {
    return context.strings.conversation_screen_message_state_public_key_download_failed;
  } else {
    return message;
  }
}

Widget _messageWidget(
  BuildContext context,
  MessageEntry entry,
  SentMessageState? sentMessageState,
  ReceivedMessageState? receivedMessageState,
  {
    required TextStyle parentTextStyle,
  }
) {
  final String text = messageWidgetText(context, entry.messageText, sentMessageState, receivedMessageState);
  final showErrorColor =
    (sentMessageState?.isError() ?? false) ||
    (receivedMessageState?.isError() ?? false);
  final textColor = showErrorColor ?
      Theme.of(context).colorScheme.onErrorContainer :
      Theme.of(context).colorScheme.onPrimaryContainer;
  final messageTextStyle = parentTextStyle.merge(TextStyle(
    color: textColor,
    fontSize: 16.0,
  ));
  final messageWidget = Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    decoration: BoxDecoration(
      color: showErrorColor ?
        Theme.of(context).colorScheme.errorContainer :
        Theme.of(context).colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(text, style: messageTextStyle),
  );
  final messageTimeTextStyle = parentTextStyle.merge(TextStyle(
    color: Theme.of(context).colorScheme.onSurface.withAlpha(_OPACITY_FOR_ON_SURFACE_CONTENT),
    fontSize: 12.0,
  ));
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
    child: Column(
      mainAxisAlignment: receivedMessageState != null ?
        MainAxisAlignment.start :
        MainAxisAlignment.end,
      crossAxisAlignment: receivedMessageState != null ?
        CrossAxisAlignment.start :
        CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        showErrorIconIfNeeded(
          context,
          messageWidget,
          sentMessageState,
          receivedMessageState,
        ),
        Align(
          alignment: receivedMessageState != null ?
            Alignment.centerLeft :
            Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
            child: Text(_timeStringFromMessage(entry), style: messageTimeTextStyle),
          ),
        ),
      ],
    ),
  );
}

Widget showErrorIconIfNeeded(
  BuildContext context,
  Widget messageWidget,
  SentMessageState? sentMessageState,
  ReceivedMessageState? receivedMessageState,
) {
  if (sentMessageState != null) {
    // Sent message
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 1,
          // Visibility is here to avoid text area size changes
          child: Visibility(
            visible: sentMessageState.isError(),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error, color: Theme.of(context).colorScheme.error),
            ),
          ),
        ),
        Flexible(
          flex: 10,
          child: messageWidget,
        ),
      ],
    );
  } else if (receivedMessageState != null) {
    // Received message
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (receivedMessageState.isError()) Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error, color: Theme.of(context).colorScheme.error),
            ),
          ),
        Flexible(
          flex: 10,
          child: messageWidget,
        ),
      ],
    );
  } else {
    return const SizedBox.shrink();
  }
}

String _timeStringFromMessage(MessageEntry entry) {
  final messageTime = entry.unixTime ?? entry.localUnixTime;
  return timeString(messageTime);
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
        if (entry.messageState.toSentState() == SentMessageState.sendingError) ListTile(
          title: Text(context.strings.generic_delete),
          onTap: () async {
            final bloc = screenContext.read<ConversationBloc>();
            if (bloc.state.isActionsInProgress()) {
              showSnackBar(context.strings.generic_previous_action_in_progress);
            } else {
              bloc.add(RemoveSendFailedMessage(entry.remoteAccountId, entry.localId));
            }
            MyNavigator.removePage(context, pageKey, null);
          },
        ),
        if (entry.messageState.toSentState() == SentMessageState.sendingError) ListTile(
          title: Text(context.strings.generic_resend),
          onTap: () async {
            final bloc = screenContext.read<ConversationBloc>();
            if (bloc.state.isActionsInProgress()) {
              showSnackBar(context.strings.generic_previous_action_in_progress);
            } else {
              bloc.add(ResendSendFailedMessage(entry.remoteAccountId, entry.localId));
            }
            MyNavigator.removePage(context, pageKey, null);
          },
        ),
        if (entry.messageState.toReceivedState() == ReceivedMessageState.publicKeyDownloadFailed) ListTile(
          title: Text(context.strings.generic_retry),
          onTap: () async {
            final bloc = screenContext.read<ConversationBloc>();
            if (bloc.state.isActionsInProgress()) {
              showSnackBar(context.strings.generic_previous_action_in_progress);
            } else {
              bloc.add(RetryPublicKeyDownload(entry.remoteAccountId, entry.localId));
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
  final sentMessageState = entry.messageState.toSentState();
  final receivedMessageState = entry.messageState.toReceivedState();
  if (sentMessageState == SentMessageState.pending) {
    stateText = screenContext.strings.conversation_screen_message_state_sending_in_progress;
  } else if (sentMessageState == SentMessageState.sendingError) {
    stateText = screenContext.strings.conversation_screen_message_state_sending_failed;
  } else if (sentMessageState == SentMessageState.sent) {
    stateText = screenContext.strings.conversation_screen_message_state_sent_successfully;
  } else if (receivedMessageState == ReceivedMessageState.received) {
    stateText = screenContext.strings.conversation_screen_message_state_received_successfully;
  } else if (receivedMessageState == ReceivedMessageState.decryptingFailed) {
    stateText = screenContext.strings.conversation_screen_message_state_decrypting_failed;
  } else if (receivedMessageState == ReceivedMessageState.unknownMessageType) {
    stateText = screenContext.strings.conversation_screen_message_state_unknown_message_type;
  } else if (receivedMessageState == ReceivedMessageState.publicKeyDownloadFailed) {
    stateText = screenContext.strings.conversation_screen_message_state_public_key_download_failed;
  } else {
    stateText = "";
  }

  final time = entry.unixTime ?? entry.localUnixTime;

  final infoText = """
${screenContext.strings.generic_message}: ${entry.messageText}
${screenContext.strings.conversation_screen_message_details_message_id}: ${entry.messageNumber?.mn}
${screenContext.strings.generic_time}: ${time.dateTime.toIso8601String()}
${screenContext.strings.generic_state}: $stateText""";

  showInfoDialog(
    screenContext,
    infoText,
    existingPageToBeRemoved: existingPageKey,
  );
}
