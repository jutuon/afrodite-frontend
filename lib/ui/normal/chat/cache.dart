import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/database/chat/message_database.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';
import 'package:pihka_frontend/utils.dart';

var log = Logger("MessageCache");

class MessageCache {
  int? size;
  bool cacheUpdateNeeded = false;
  void Function(bool jumpToLatestMessage, double? newMessagesHeight)? _onCacheUpdate;
  void Function(MessageContainer container, double totalHeight)? _runMessageRenderer;
  bool renderingInProgress = false;
  bool jumpToLatestAtNextUpdate = false;
  final AccountId _accountId;
  int? initialMsgLocalKey;
  /// Index 0 is the latest message of the already existing messages.
  List<MessageContainer> _topMessages = [];
  /// Index 0 is the latest message.
  List<MessageContainer> _bottomMessages = [];

  /// Queue for new messages which will have the size calculated.
  Queue<MessageContainer> _newMessages = Queue();

  MessageCache(this._accountId);

  void registerCacheUpdateCallback(void Function(bool, double?) callback) {
    _onCacheUpdate = callback;
    if (cacheUpdateNeeded) {
      // Not sure if this is needed but this might be run when
      // sending the first message after match.
      _onCacheUpdate!(true, null);
      cacheUpdateNeeded = false;
    }
  }

  void registerMessageRenderCallback(void Function(MessageContainer message, double totalHeight) callback) {
    _runMessageRenderer = callback;
  }

  void setInitialMessagesIfNotSet(List<MessageEntry> initialMessages) {
    if (size == null) {
      log.info("Setting initial messages: ${initialMessages.length}");
      _topMessages = initialMessages.map((e) => MessageContainer(e)).toList();
      size = initialMessages.length;
      initialMsgLocalKey = initialMessages.firstOrNull?.id;
    }
  }

  void setNewSize(int newSize, bool jumpToLatestMessage) {
    if (newSize != size) {
      log.info("New size: $newSize, jumpToLatestMessage: $jumpToLatestMessage");
      _updateCache(jumpToLatestMessage, size == null);
      size = newSize;
    }
  }

  Future<void> _updateCache(bool jumpToLatestMessage, bool initialLoad) async {
    await ChatRepository.getInstance().messageIteratorReset(_accountId);
    bool useBottom = true;
    List<MessageContainer> newBottomMessages = [];
    List<MessageContainer> newTopMessages = [];
    while (true) {
      final messages = await ChatRepository.getInstance().messageIteratorNext();
      if (messages.isEmpty) {
        break;
      }

      // ignore: prefer_conditional_assignment
      if (initialMsgLocalKey == null) {
        initialMsgLocalKey = messages.first.id;
      }

      if (initialLoad) {
        for (final message in messages) {
          newTopMessages.add(MessageContainer(message));
        }
      } else {
        for (final message in messages) {
          if (message.id == initialMsgLocalKey) {
            useBottom = false;
          }
          if (useBottom) {
            newBottomMessages.add(MessageContainer(message));
          } else {
            newTopMessages.add(MessageContainer(message));
          }
        }
      }
    }
    _topMessages = newTopMessages;

    for (final (i, message) in newBottomMessages.indexed) {
      if (i < _bottomMessages.length) {
        /// Update old bottom messsages.
        _bottomMessages[i].entry = message.entry;
      } else {
        _newMessages.addLast(message);
      }
    }

    if (!jumpToLatestAtNextUpdate) {
      jumpToLatestAtNextUpdate = jumpToLatestMessage || initialLoad;
    }
    initRendering();
  }

  void initRendering() {
    if (renderingInProgress) {
      log.info("Init rendering: already rendering");
      return;
    } else {
      log.info("Init rendering");
      renderingInProgress = true;
    }

    final callback = _runMessageRenderer;
    if (callback == null) {
      log.info("Init rendering: not registered");
      renderingInProgress = false;
      _triggerUpdateCallback(0);
    } else {
      if (_newMessages.isNotEmpty) {
        final next = _newMessages.removeFirst();
        callback(next, 0);
      } else {
        renderingInProgress = false;
        _triggerUpdateCallback(0);
      }
    }

  }

  /// Start rendering again if needed.
  void completeOneRendering(MessageContainer message, double totalHeight) {
    log.info("Submit rendering: ${message.entry.id}, $totalHeight");

    _bottomMessages.add(message);

    final callback = _runMessageRenderer;
    if (_newMessages.isNotEmpty && callback != null) {
      final next = _newMessages.removeFirst();
      callback(next, totalHeight);
    } else {
      renderingInProgress = false;
      _triggerUpdateCallback(totalHeight);
    }
  }

  void _triggerUpdateCallback(double? totalHeight) {
    final updateCallback = _onCacheUpdate;
    if (updateCallback != null) {
      updateCallback(jumpToLatestAtNextUpdate, totalHeight);
      jumpToLatestAtNextUpdate = false;
    } else {
      log.info("Callback not registered, so callback will run when registered.");
      // Refresh when callback is registered.
      cacheUpdateNeeded = true;
    }
  }

  int getTopMessagesSize() {
    return _topMessages.length;
  }

  int getBottomMessagesSize() {
    return _bottomMessages.length;
  }

  /// If null, message entry does not exists.
  /// First message in top messages list is index 0 message.
  MessageEntry? getMessageUsingConstantIndexing(int index) {
    if (index >= 0) {
      return _topMessages.elementAtOrNull(index)?.entry;
    } else {
      final bottomIndex = -index - 1;
      if (bottomIndex < 0) {
        return null;
      } else {
        return _bottomMessages.elementAtOrNull(bottomIndex)?.entry;
      }
    }
  }

  /// If null, message entry does not exists
  /// Last message in bottom messages list is index 0 message.
  MessageEntry? getMessageUsingLatestMessageIndexing(int index) {
    if (index >= getBottomMessagesSize()) {
      final i = index - getBottomMessagesSize();
      return _topMessages.elementAtOrNull(i)?.entry;
    } else {
      return _bottomMessages.elementAtOrNull(index)?.entry;
    }
  }

  /// If null, message entry does not exists
  MessageEntry? topMessagesindexToEntry(int index) {
    return _topMessages.elementAtOrNull(index)?.entry;
  }

  /// If null, message entry does not exists
  MessageEntry? bottomMessagesindexToEntry(int index) {
    return _bottomMessages.elementAtOrNull(index)?.entry;
  }

  void moveBottomMessagesToTop() async {
    _topMessages = [..._bottomMessages, ..._topMessages];
    initialMsgLocalKey = _topMessages.firstOrNull?.entry?.id;
    _bottomMessages = [];
    _triggerUpdateCallback(null);
    log.info("Moved bottom messages to top");
  }

  // Debugging

  void debugSetInitialMessagesIfNotSet(int debugMsgCount) {
    final List<MessageEntry> msgList = [];
    for (int i = 0; i < debugMsgCount; i++) {
      msgList.add(debugBuildEntry("$i", i % 4 == 0));
    }
    setInitialMessagesIfNotSet(msgList);
  }

  int counter = 0;
  MessageEntry debugBuildEntry(String text, bool isSent) {
    final SentMessageState? state;
    if (isSent) {
      state = SentMessageState.pending;
    } else {
      state = null;
    }
    return MessageEntry(
      AccountId(accountId: ""),
      AccountId(accountId: ""),
      text,
      sentMessageState: state,
      id: counter++,
    );
  }

  void debugAddToTop(String text, bool isSent) {
    final entry = debugBuildEntry(text, isSent);
    _topMessages.add(MessageContainer(entry));
    _onCacheUpdate!(false, null);
  }

  void debugRemoveFromTop() {
    if (_topMessages.isNotEmpty) {
      _topMessages.removeAt(0);
    }
    _onCacheUpdate!(false, null);
  }

  void debugAddToBottom(String text, bool isSent) {
    final entry = debugBuildEntry(text, isSent);
    _newMessages.addFirst(MessageContainer(entry));
    initRendering();
  }

  void debugRemoveFromBottom() {
    if (_bottomMessages.isNotEmpty) {
      _bottomMessages.removeAt(0);
    }
    _onCacheUpdate!(false, null);
  }
}

/// Message end its size which will be calculated.
class MessageContainer {
  MessageEntry entry;
  MessageContainer(this.entry);
}
