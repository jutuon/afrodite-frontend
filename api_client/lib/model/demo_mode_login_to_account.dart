//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DemoModeLoginToAccount {
  /// Returns a new [DemoModeLoginToAccount] instance.
  DemoModeLoginToAccount({
    required this.accountId,
    required this.token,
  });

  AccountId accountId;

  DemoModeToken token;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DemoModeLoginToAccount &&
     other.accountId == accountId &&
     other.token == token;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountId.hashCode) +
    (token.hashCode);

  @override
  String toString() => 'DemoModeLoginToAccount[accountId=$accountId, token=$token]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_id'] = this.accountId;
      json[r'token'] = this.token;
    return json;
  }

  /// Returns a new [DemoModeLoginToAccount] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DemoModeLoginToAccount? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DemoModeLoginToAccount[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DemoModeLoginToAccount[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DemoModeLoginToAccount(
        accountId: AccountId.fromJson(json[r'account_id'])!,
        token: DemoModeToken.fromJson(json[r'token'])!,
      );
    }
    return null;
  }

  static List<DemoModeLoginToAccount>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DemoModeLoginToAccount>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DemoModeLoginToAccount.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DemoModeLoginToAccount> mapFromJson(dynamic json) {
    final map = <String, DemoModeLoginToAccount>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DemoModeLoginToAccount.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DemoModeLoginToAccount-objects as value to a dart map
  static Map<String, List<DemoModeLoginToAccount>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DemoModeLoginToAccount>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DemoModeLoginToAccount.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account_id',
    'token',
  };
}

