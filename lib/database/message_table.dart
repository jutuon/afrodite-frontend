


import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/account_database.dart';

import 'package:drift/drift.dart';
import 'package:pihka_frontend/database/message_entry.dart';
import 'package:pihka_frontend/database/utils.dart';
import 'package:pihka_frontend/utils/date.dart';

part 'message_table.g.dart';

class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuidLocalAccountId => text().map(const AccountIdConverter())();
  TextColumn get uuidRemoteAccountId => text().map(const AccountIdConverter())();
  TextColumn get messageText => text()();
  IntColumn get sentMessageState => integer().nullable()();
  IntColumn get receivedMessageState => integer().nullable()();

  // Server sends valid values for the next two colums.
  IntColumn get messageNumber => integer().map(const NullAwareTypeConverter.wrap(MessageNumberConverter())).nullable()();
  IntColumn get unixTime => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
}

@DriftAccessor(tables: [Messages])
class DaoMessages extends DatabaseAccessor<AccountDatabase> with _$DaoMessagesMixin {
  DaoMessages(AccountDatabase db) : super(db);
  /// Number of all messages in the database
  Future<int?> countMessagesInConversation(
    AccountId localAccountId,
    AccountId remoteAccountId,
  ) async {
    final messageCount = messages.id.count();
    final q = (selectOnly(messages)
      ..where(messages.uuidLocalAccountId.equals(localAccountId.accountId))
      ..where(messages.uuidRemoteAccountId.equals(remoteAccountId.accountId))
      ..addColumns([messageCount])
    );
    return await q.map((r) => r.read(messageCount)).getSingleOrNull();
  }

  /// Returns ID of last inserted row.
  Future<int> _insert(MessageEntry entry) async {
    return await into(messages).insert(MessagesCompanion.insert(
      uuidLocalAccountId: entry.localAccountId,
      uuidRemoteAccountId: entry.remoteAccountId,
      messageText: entry.messageText,
      sentMessageState: Value(entry.sentMessageState?.number),
      receivedMessageState: Value(entry.receivedMessageState?.number),
      messageNumber: Value(entry.messageNumber),
      unixTime: Value(entry.unixTime),
    ));
  }

  Future<void> insertToBeSentMessage(
    AccountId localAccountId,
    AccountId remoteAccountId,
    String messageText,
  ) async {
    final message = MessageEntry(
      localAccountId: localAccountId,
      remoteAccountId: remoteAccountId,
      messageText: messageText,
      sentMessageState: SentMessageState.pending,
    );
    await _insert(message);
  }

  Future<void> insertPendingMessage(AccountId localAccountId, PendingMessage entry) async {
    final unixTime = UtcDateTime.fromUnixEpochMilliseconds(entry.unixTime.unixTime * 1000);
    final message = MessageEntry(
      localAccountId: localAccountId,
      remoteAccountId: entry.id.accountIdSender,
      messageText: entry.message,
      sentMessageState: null,
      receivedMessageState: ReceivedMessageState.waitingDeletionFromServer,
      messageNumber: entry.id.messageNumber,
      unixTime: unixTime,
    );
    await _insert(message);
  }

  Future<void> updateReceivedMessageState(
    AccountId localAccountId,
    AccountId remoteAccountId,
    MessageNumber messageNumber,
    ReceivedMessageState receivedMessageState,
  ) async {
    await (update(messages)
      ..where((t) => t.uuidLocalAccountId.equals(localAccountId.accountId))
      ..where((t) => t.uuidRemoteAccountId.equals(remoteAccountId.accountId))
      ..where((t) => t.messageNumber.equals(messageNumber.messageNumber))
    ).write(MessagesCompanion(
      receivedMessageState: Value(receivedMessageState.number),
    ));
  }

  /// Get message with given index in a conversation.
  /// The index 0 is the latest message.
  Future<MessageEntry?> getMessage(
    AccountId localAccountId,
    AccountId remoteAccountId,
    int index,
  ) async {
    return await (select(messages)
      ..where((t) => t.uuidLocalAccountId.equals(localAccountId.accountId))
      ..where((t) => t.uuidRemoteAccountId.equals(remoteAccountId.accountId))
      ..limit(1, offset: index)
      ..orderBy([
        (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
      ])
    )
      .map((m) => _fromMessage(m))
      .getSingleOrNull();
  }

  /// Get list of messages starting from startId. The next ID is smaller.
  Future<List<MessageEntry>> getMessageListByLocalMessageId(
    AccountId localAccountId,
    AccountId remoteAccountId,
    int startId,
    int limit,
  ) async {
    return await (select(messages)
      ..where((t) => t.uuidLocalAccountId.equals(localAccountId.accountId))
      ..where((t) => t.uuidRemoteAccountId.equals(remoteAccountId.accountId))
      ..where((t) => t.id.isSmallerOrEqualValue(startId))
      ..limit(limit)
      ..orderBy([
        (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
      ])
    )
      .map((m) => _fromMessage(m))
      .get();
  }

  MessageEntry _fromMessage(Message m) {
    final sentMessageStateNumber = m.sentMessageState;
    final SentMessageState? sentMessageState;
    if (sentMessageStateNumber != null) {
      sentMessageState = SentMessageState.values[sentMessageStateNumber];
    } else {
      sentMessageState = null;
    }

    final receivedMessageStateNumber = m.receivedMessageState;
    final ReceivedMessageState? receivedMessageState;
    if (receivedMessageStateNumber != null) {
      receivedMessageState = ReceivedMessageState.values[receivedMessageStateNumber];
    } else {
      receivedMessageState = null;
    }

    return MessageEntry(
      localAccountId: m.uuidLocalAccountId,
      remoteAccountId: m.uuidRemoteAccountId,
      messageText: m.messageText,
      sentMessageState: sentMessageState,
      receivedMessageState: receivedMessageState,
      messageNumber: m.messageNumber,
      unixTime: m.unixTime,
    );
  }
}
