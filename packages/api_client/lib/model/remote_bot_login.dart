//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RemoteBotLogin {
  /// Returns a new [RemoteBotLogin] instance.
  RemoteBotLogin({
    required this.aid,
    required this.password,
  });

  AccountId aid;

  String password;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RemoteBotLogin &&
    other.aid == aid &&
    other.password == password;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (aid.hashCode) +
    (password.hashCode);

  @override
  String toString() => 'RemoteBotLogin[aid=$aid, password=$password]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'aid'] = this.aid;
      json[r'password'] = this.password;
    return json;
  }

  /// Returns a new [RemoteBotLogin] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RemoteBotLogin? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RemoteBotLogin[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RemoteBotLogin[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RemoteBotLogin(
        aid: AccountId.fromJson(json[r'aid'])!,
        password: mapValueOfType<String>(json, r'password')!,
      );
    }
    return null;
  }

  static List<RemoteBotLogin> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RemoteBotLogin>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RemoteBotLogin.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RemoteBotLogin> mapFromJson(dynamic json) {
    final map = <String, RemoteBotLogin>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RemoteBotLogin.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RemoteBotLogin-objects as value to a dart map
  static Map<String, List<RemoteBotLogin>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RemoteBotLogin>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RemoteBotLogin.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'aid',
    'password',
  };
}

