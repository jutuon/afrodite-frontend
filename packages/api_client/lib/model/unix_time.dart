//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UnixTime {
  /// Returns a new [UnixTime] instance.
  UnixTime({
    required this.ut,
  });

  int ut;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UnixTime &&
    other.ut == ut;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (ut.hashCode);

  @override
  String toString() => 'UnixTime[ut=$ut]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'ut'] = this.ut;
    return json;
  }

  /// Returns a new [UnixTime] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UnixTime? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UnixTime[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UnixTime[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UnixTime(
        ut: mapValueOfType<int>(json, r'ut')!,
      );
    }
    return null;
  }

  static List<UnixTime> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UnixTime>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UnixTime.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UnixTime> mapFromJson(dynamic json) {
    final map = <String, UnixTime>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UnixTime.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UnixTime-objects as value to a dart map
  static Map<String, List<UnixTime>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UnixTime>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UnixTime.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'ut',
  };
}

