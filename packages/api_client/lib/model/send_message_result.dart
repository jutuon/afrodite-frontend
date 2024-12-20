//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SendMessageResult {
  /// Returns a new [SendMessageResult] instance.
  SendMessageResult({
    this.errorReceiverBlockedSenderOrReceiverNotFound = false,
    this.errorReceiverPublicKeyOutdated = false,
    this.errorTooManyReceiverAcknowledgementsMissing = false,
    this.errorTooManySenderAcknowledgementsMissing = false,
    this.mn,
    this.ut,
  });

  bool errorReceiverBlockedSenderOrReceiverNotFound;

  bool errorReceiverPublicKeyOutdated;

  bool errorTooManyReceiverAcknowledgementsMissing;

  bool errorTooManySenderAcknowledgementsMissing;

  /// None if error happened
  MessageNumber? mn;

  /// None if error happened
  UnixTime? ut;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SendMessageResult &&
    other.errorReceiverBlockedSenderOrReceiverNotFound == errorReceiverBlockedSenderOrReceiverNotFound &&
    other.errorReceiverPublicKeyOutdated == errorReceiverPublicKeyOutdated &&
    other.errorTooManyReceiverAcknowledgementsMissing == errorTooManyReceiverAcknowledgementsMissing &&
    other.errorTooManySenderAcknowledgementsMissing == errorTooManySenderAcknowledgementsMissing &&
    other.mn == mn &&
    other.ut == ut;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (errorReceiverBlockedSenderOrReceiverNotFound.hashCode) +
    (errorReceiverPublicKeyOutdated.hashCode) +
    (errorTooManyReceiverAcknowledgementsMissing.hashCode) +
    (errorTooManySenderAcknowledgementsMissing.hashCode) +
    (mn == null ? 0 : mn!.hashCode) +
    (ut == null ? 0 : ut!.hashCode);

  @override
  String toString() => 'SendMessageResult[errorReceiverBlockedSenderOrReceiverNotFound=$errorReceiverBlockedSenderOrReceiverNotFound, errorReceiverPublicKeyOutdated=$errorReceiverPublicKeyOutdated, errorTooManyReceiverAcknowledgementsMissing=$errorTooManyReceiverAcknowledgementsMissing, errorTooManySenderAcknowledgementsMissing=$errorTooManySenderAcknowledgementsMissing, mn=$mn, ut=$ut]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'error_receiver_blocked_sender_or_receiver_not_found'] = this.errorReceiverBlockedSenderOrReceiverNotFound;
      json[r'error_receiver_public_key_outdated'] = this.errorReceiverPublicKeyOutdated;
      json[r'error_too_many_receiver_acknowledgements_missing'] = this.errorTooManyReceiverAcknowledgementsMissing;
      json[r'error_too_many_sender_acknowledgements_missing'] = this.errorTooManySenderAcknowledgementsMissing;
    if (this.mn != null) {
      json[r'mn'] = this.mn;
    } else {
      json[r'mn'] = null;
    }
    if (this.ut != null) {
      json[r'ut'] = this.ut;
    } else {
      json[r'ut'] = null;
    }
    return json;
  }

  /// Returns a new [SendMessageResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SendMessageResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SendMessageResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SendMessageResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SendMessageResult(
        errorReceiverBlockedSenderOrReceiverNotFound: mapValueOfType<bool>(json, r'error_receiver_blocked_sender_or_receiver_not_found') ?? false,
        errorReceiverPublicKeyOutdated: mapValueOfType<bool>(json, r'error_receiver_public_key_outdated') ?? false,
        errorTooManyReceiverAcknowledgementsMissing: mapValueOfType<bool>(json, r'error_too_many_receiver_acknowledgements_missing') ?? false,
        errorTooManySenderAcknowledgementsMissing: mapValueOfType<bool>(json, r'error_too_many_sender_acknowledgements_missing') ?? false,
        mn: MessageNumber.fromJson(json[r'mn']),
        ut: UnixTime.fromJson(json[r'ut']),
      );
    }
    return null;
  }

  static List<SendMessageResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SendMessageResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SendMessageResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SendMessageResult> mapFromJson(dynamic json) {
    final map = <String, SendMessageResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SendMessageResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SendMessageResult-objects as value to a dart map
  static Map<String, List<SendMessageResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SendMessageResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SendMessageResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

