//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetProfileContentResult {
  /// Returns a new [GetProfileContentResult] instance.
  GetProfileContentResult({
    this.c,
    this.v,
  });

  ProfileContent? c;

  ProfileContentVersion? v;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetProfileContentResult &&
    other.c == c &&
    other.v == v;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (c == null ? 0 : c!.hashCode) +
    (v == null ? 0 : v!.hashCode);

  @override
  String toString() => 'GetProfileContentResult[c=$c, v=$v]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.c != null) {
      json[r'c'] = this.c;
    } else {
      json[r'c'] = null;
    }
    if (this.v != null) {
      json[r'v'] = this.v;
    } else {
      json[r'v'] = null;
    }
    return json;
  }

  /// Returns a new [GetProfileContentResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetProfileContentResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetProfileContentResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetProfileContentResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetProfileContentResult(
        c: ProfileContent.fromJson(json[r'c']),
        v: ProfileContentVersion.fromJson(json[r'v']),
      );
    }
    return null;
  }

  static List<GetProfileContentResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetProfileContentResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetProfileContentResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetProfileContentResult> mapFromJson(dynamic json) {
    final map = <String, GetProfileContentResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetProfileContentResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetProfileContentResult-objects as value to a dart map
  static Map<String, List<GetProfileContentResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetProfileContentResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetProfileContentResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

