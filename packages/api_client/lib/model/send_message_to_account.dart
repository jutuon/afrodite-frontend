//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SendMessageToAccount {
  /// Returns a new [SendMessageToAccount] instance.
  SendMessageToAccount({
    required this.message,
    required this.receiver,
    required this.receiverPublicKeyId,
    required this.receiverPublicKeyVersion,
  });

  String message;

  AccountId receiver;

  PublicKeyId receiverPublicKeyId;

  PublicKeyVersion receiverPublicKeyVersion;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SendMessageToAccount &&
     other.message == message &&
     other.receiver == receiver &&
     other.receiverPublicKeyId == receiverPublicKeyId &&
     other.receiverPublicKeyVersion == receiverPublicKeyVersion;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (message.hashCode) +
    (receiver.hashCode) +
    (receiverPublicKeyId.hashCode) +
    (receiverPublicKeyVersion.hashCode);

  @override
  String toString() => 'SendMessageToAccount[message=$message, receiver=$receiver, receiverPublicKeyId=$receiverPublicKeyId, receiverPublicKeyVersion=$receiverPublicKeyVersion]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'message'] = this.message;
      json[r'receiver'] = this.receiver;
      json[r'receiver_public_key_id'] = this.receiverPublicKeyId;
      json[r'receiver_public_key_version'] = this.receiverPublicKeyVersion;
    return json;
  }

  /// Returns a new [SendMessageToAccount] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SendMessageToAccount? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SendMessageToAccount[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SendMessageToAccount[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SendMessageToAccount(
        message: mapValueOfType<String>(json, r'message')!,
        receiver: AccountId.fromJson(json[r'receiver'])!,
        receiverPublicKeyId: PublicKeyId.fromJson(json[r'receiver_public_key_id'])!,
        receiverPublicKeyVersion: PublicKeyVersion.fromJson(json[r'receiver_public_key_version'])!,
      );
    }
    return null;
  }

  static List<SendMessageToAccount>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SendMessageToAccount>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SendMessageToAccount.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SendMessageToAccount> mapFromJson(dynamic json) {
    final map = <String, SendMessageToAccount>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SendMessageToAccount.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SendMessageToAccount-objects as value to a dart map
  static Map<String, List<SendMessageToAccount>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SendMessageToAccount>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SendMessageToAccount.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'message',
    'receiver',
    'receiver_public_key_id',
    'receiver_public_key_version',
  };
}

