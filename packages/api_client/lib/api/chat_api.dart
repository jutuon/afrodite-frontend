//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ChatApi {
  ChatApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Delete sent like.
  ///
  /// Delete sent like.  Delete will not work if profile is a match.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> deleteLikeWithHttpInfo(AccountId accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/delete_like';

    // ignore: prefer_final_locals
    Object? postBody = accountId;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Delete sent like.
  ///
  /// Delete sent like.  Delete will not work if profile is a match.
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<LimitedActionResult?> deleteLike(AccountId accountId,) async {
    final response = await deleteLikeWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'LimitedActionResult',) as LimitedActionResult;
    
    }
    return null;
  }

  /// Delete list of pending messages
  ///
  /// Delete list of pending messages
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PendingMessageDeleteList] pendingMessageDeleteList (required):
  Future<Response> deletePendingMessagesWithHttpInfo(PendingMessageDeleteList pendingMessageDeleteList,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/pending_messages';

    // ignore: prefer_final_locals
    Object? postBody = pendingMessageDeleteList;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Delete list of pending messages
  ///
  /// Delete list of pending messages
  ///
  /// Parameters:
  ///
  /// * [PendingMessageDeleteList] pendingMessageDeleteList (required):
  Future<void> deletePendingMessages(PendingMessageDeleteList pendingMessageDeleteList,) async {
    final response = await deletePendingMessagesWithHttpInfo(pendingMessageDeleteList,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get matches
  ///
  /// Get matches
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getMatchesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/matches';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get matches
  ///
  /// Get matches
  Future<MatchesPage?> getMatches() async {
    final response = await getMatchesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MatchesPage',) as MatchesPage;
    
    }
    return null;
  }

  /// Get message number of the most recent message that the recipient has viewed.
  ///
  /// Get message number of the most recent message that the recipient has viewed.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> getMessageNumberOfLatestViewedMessageWithHttpInfo(AccountId accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/message_number_of_latest_viewed_message';

    // ignore: prefer_final_locals
    Object? postBody = accountId;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get message number of the most recent message that the recipient has viewed.
  ///
  /// Get message number of the most recent message that the recipient has viewed.
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<MessageNumber?> getMessageNumberOfLatestViewedMessage(AccountId accountId,) async {
    final response = await getMessageNumberOfLatestViewedMessageWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MessageNumber',) as MessageNumber;
    
    }
    return null;
  }

  /// Get list of pending messages
  ///
  /// Get list of pending messages
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getPendingMessagesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/pending_messages';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get list of pending messages
  ///
  /// Get list of pending messages
  Future<PendingMessagesPage?> getPendingMessages() async {
    final response = await getPendingMessagesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PendingMessagesPage',) as PendingMessagesPage;
    
    }
    return null;
  }

  /// Get current public key of some account
  ///
  /// Get current public key of some account
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  ///
  /// * [int] version (required):
  Future<Response> getPublicKeyWithHttpInfo(String accountId, int version,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/public_key/{account_id}'
      .replaceAll('{account_id}', accountId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'version', version));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get current public key of some account
  ///
  /// Get current public key of some account
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  ///
  /// * [int] version (required):
  Future<GetPublicKey?> getPublicKey(String accountId, int version,) async {
    final response = await getPublicKeyWithHttpInfo(accountId, version,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetPublicKey',) as GetPublicKey;
    
    }
    return null;
  }

  /// Get list of received blocks
  ///
  /// Get list of received blocks
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getReceivedBlocksWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/received_blocks';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get list of received blocks
  ///
  /// Get list of received blocks
  Future<ReceivedBlocksPage?> getReceivedBlocks() async {
    final response = await getReceivedBlocksWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ReceivedBlocksPage',) as ReceivedBlocksPage;
    
    }
    return null;
  }

  /// Get received likes.
  ///
  /// Get received likes.  Profile will not be returned if: - Profile is blocked - Profile is a match
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getReceivedLikesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/received_likes';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get received likes.
  ///
  /// Get received likes.  Profile will not be returned if: - Profile is blocked - Profile is a match
  Future<ReceivedLikesPage?> getReceivedLikes() async {
    final response = await getReceivedLikesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ReceivedLikesPage',) as ReceivedLikesPage;
    
    }
    return null;
  }

  /// Get list of sent blocks
  ///
  /// Get list of sent blocks
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getSentBlocksWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/sent_blocks';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get list of sent blocks
  ///
  /// Get list of sent blocks
  Future<SentBlocksPage?> getSentBlocks() async {
    final response = await getSentBlocksWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SentBlocksPage',) as SentBlocksPage;
    
    }
    return null;
  }

  /// Get sent likes.
  ///
  /// Get sent likes.  Profile will not be returned if:  - Profile is hidden (not public) - Profile is blocked - Profile is a match
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getSentLikesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/sent_likes';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get sent likes.
  ///
  /// Get sent likes.  Profile will not be returned if:  - Profile is hidden (not public) - Profile is blocked - Profile is a match
  Future<SentLikesPage?> getSentLikes() async {
    final response = await getSentLikesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SentLikesPage',) as SentLikesPage;
    
    }
    return null;
  }

  /// Block profile
  ///
  /// Block profile
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> postBlockProfileWithHttpInfo(AccountId accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/block_profile';

    // ignore: prefer_final_locals
    Object? postBody = accountId;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Block profile
  ///
  /// Block profile
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<void> postBlockProfile(AccountId accountId,) async {
    final response = await postBlockProfileWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get pending notification and reset pending notification.
  ///
  /// Get pending notification and reset pending notification.  Requesting this route is always valid to avoid figuring out device token values more easily.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PendingNotificationToken] pendingNotificationToken (required):
  Future<Response> postGetPendingNotificationWithHttpInfo(PendingNotificationToken pendingNotificationToken,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/get_pending_notification';

    // ignore: prefer_final_locals
    Object? postBody = pendingNotificationToken;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get pending notification and reset pending notification.
  ///
  /// Get pending notification and reset pending notification.  Requesting this route is always valid to avoid figuring out device token values more easily.
  ///
  /// Parameters:
  ///
  /// * [PendingNotificationToken] pendingNotificationToken (required):
  Future<PendingNotificationWithData?> postGetPendingNotification(PendingNotificationToken pendingNotificationToken,) async {
    final response = await postGetPendingNotificationWithHttpInfo(pendingNotificationToken,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PendingNotificationWithData',) as PendingNotificationWithData;
    
    }
    return null;
  }

  /// Update message number of the most recent message that the recipient has viewed.
  ///
  /// Update message number of the most recent message that the recipient has viewed.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpdateMessageViewStatus] updateMessageViewStatus (required):
  Future<Response> postMessageNumberOfLatestViewedMessageWithHttpInfo(UpdateMessageViewStatus updateMessageViewStatus,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/message_number_of_latest_viewed_message';

    // ignore: prefer_final_locals
    Object? postBody = updateMessageViewStatus;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Update message number of the most recent message that the recipient has viewed.
  ///
  /// Update message number of the most recent message that the recipient has viewed.
  ///
  /// Parameters:
  ///
  /// * [UpdateMessageViewStatus] updateMessageViewStatus (required):
  Future<void> postMessageNumberOfLatestViewedMessage(UpdateMessageViewStatus updateMessageViewStatus,) async {
    final response = await postMessageNumberOfLatestViewedMessageWithHttpInfo(updateMessageViewStatus,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Replace current public key with a new public key.
  ///
  /// Replace current public key with a new public key. Returns public key ID number which server increments. This must be called only when needed as this route will fail every time if current public key ID number is i64::MAX.  Only version 1 public keys are currently supported.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SetPublicKey] setPublicKey (required):
  Future<Response> postPublicKeyWithHttpInfo(SetPublicKey setPublicKey,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/public_key';

    // ignore: prefer_final_locals
    Object? postBody = setPublicKey;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Replace current public key with a new public key.
  ///
  /// Replace current public key with a new public key. Returns public key ID number which server increments. This must be called only when needed as this route will fail every time if current public key ID number is i64::MAX.  Only version 1 public keys are currently supported.
  ///
  /// Parameters:
  ///
  /// * [SetPublicKey] setPublicKey (required):
  Future<PublicKeyId?> postPublicKey(SetPublicKey setPublicKey,) async {
    final response = await postPublicKeyWithHttpInfo(setPublicKey,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PublicKeyId',) as PublicKeyId;
    
    }
    return null;
  }

  /// Send a like to some account. If both will like each other, then
  ///
  /// Send a like to some account. If both will like each other, then the accounts will be a match.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> postSendLikeWithHttpInfo(AccountId accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/send_like';

    // ignore: prefer_final_locals
    Object? postBody = accountId;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Send a like to some account. If both will like each other, then
  ///
  /// Send a like to some account. If both will like each other, then the accounts will be a match.
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<LimitedActionResult?> postSendLike(AccountId accountId,) async {
    final response = await postSendLikeWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'LimitedActionResult',) as LimitedActionResult;
    
    }
    return null;
  }

  /// Send message to a match.
  ///
  /// Send message to a match.  Max pending message count is 50.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SendMessageToAccount] sendMessageToAccount (required):
  Future<Response> postSendMessageWithHttpInfo(SendMessageToAccount sendMessageToAccount,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/send_message';

    // ignore: prefer_final_locals
    Object? postBody = sendMessageToAccount;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Send message to a match.
  ///
  /// Send message to a match.  Max pending message count is 50.
  ///
  /// Parameters:
  ///
  /// * [SendMessageToAccount] sendMessageToAccount (required):
  Future<SendMessageResult?> postSendMessage(SendMessageToAccount sendMessageToAccount,) async {
    final response = await postSendMessageWithHttpInfo(sendMessageToAccount,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SendMessageResult',) as SendMessageResult;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /chat_api/set_device_token' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [FcmDeviceToken] fcmDeviceToken (required):
  Future<Response> postSetDeviceTokenWithHttpInfo(FcmDeviceToken fcmDeviceToken,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/set_device_token';

    // ignore: prefer_final_locals
    Object? postBody = fcmDeviceToken;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [FcmDeviceToken] fcmDeviceToken (required):
  Future<PendingNotificationToken?> postSetDeviceToken(FcmDeviceToken fcmDeviceToken,) async {
    final response = await postSetDeviceTokenWithHttpInfo(fcmDeviceToken,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PendingNotificationToken',) as PendingNotificationToken;
    
    }
    return null;
  }

  /// Unblock profile
  ///
  /// Unblock profile
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> postUnblockProfileWithHttpInfo(AccountId accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/unblock_profile';

    // ignore: prefer_final_locals
    Object? postBody = accountId;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Unblock profile
  ///
  /// Unblock profile
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<void> postUnblockProfile(AccountId accountId,) async {
    final response = await postUnblockProfileWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
