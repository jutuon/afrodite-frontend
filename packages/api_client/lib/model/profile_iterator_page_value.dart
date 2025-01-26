//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileIteratorPageValue {
  /// Returns a new [ProfileIteratorPageValue] instance.
  ProfileIteratorPageValue({
    required this.accountId,
    required this.age,
    required this.name,
  });

  AccountId accountId;

  int age;

  String name;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileIteratorPageValue &&
    other.accountId == accountId &&
    other.age == age &&
    other.name == name;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountId.hashCode) +
    (age.hashCode) +
    (name.hashCode);

  @override
  String toString() => 'ProfileIteratorPageValue[accountId=$accountId, age=$age, name=$name]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_id'] = this.accountId;
      json[r'age'] = this.age;
      json[r'name'] = this.name;
    return json;
  }

  /// Returns a new [ProfileIteratorPageValue] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileIteratorPageValue? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileIteratorPageValue[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileIteratorPageValue[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileIteratorPageValue(
        accountId: AccountId.fromJson(json[r'account_id'])!,
        age: mapValueOfType<int>(json, r'age')!,
        name: mapValueOfType<String>(json, r'name')!,
      );
    }
    return null;
  }

  static List<ProfileIteratorPageValue> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileIteratorPageValue>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileIteratorPageValue.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileIteratorPageValue> mapFromJson(dynamic json) {
    final map = <String, ProfileIteratorPageValue>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileIteratorPageValue.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileIteratorPageValue-objects as value to a dart map
  static Map<String, List<ProfileIteratorPageValue>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileIteratorPageValue>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileIteratorPageValue.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account_id',
    'age',
    'name',
  };
}

