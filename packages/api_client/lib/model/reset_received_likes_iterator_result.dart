//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ResetReceivedLikesIteratorResult {
  /// Returns a new [ResetReceivedLikesIteratorResult] instance.
  ResetReceivedLikesIteratorResult({
    required this.c,
    required this.s,
    required this.v,
  });

  NewReceivedLikesCount c;

  ReceivedLikesIteratorSessionId s;

  /// Sync version for new received likes count
  SyncVersion v;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResetReceivedLikesIteratorResult &&
    other.c == c &&
    other.s == s &&
    other.v == v;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (c.hashCode) +
    (s.hashCode) +
    (v.hashCode);

  @override
  String toString() => 'ResetReceivedLikesIteratorResult[c=$c, s=$s, v=$v]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'c'] = this.c;
      json[r's'] = this.s;
      json[r'v'] = this.v;
    return json;
  }

  /// Returns a new [ResetReceivedLikesIteratorResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ResetReceivedLikesIteratorResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ResetReceivedLikesIteratorResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ResetReceivedLikesIteratorResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ResetReceivedLikesIteratorResult(
        c: NewReceivedLikesCount.fromJson(json[r'c'])!,
        s: ReceivedLikesIteratorSessionId.fromJson(json[r's'])!,
        v: SyncVersion.fromJson(json[r'v'])!,
      );
    }
    return null;
  }

  static List<ResetReceivedLikesIteratorResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ResetReceivedLikesIteratorResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ResetReceivedLikesIteratorResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ResetReceivedLikesIteratorResult> mapFromJson(dynamic json) {
    final map = <String, ResetReceivedLikesIteratorResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ResetReceivedLikesIteratorResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ResetReceivedLikesIteratorResult-objects as value to a dart map
  static Map<String, List<ResetReceivedLikesIteratorResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ResetReceivedLikesIteratorResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ResetReceivedLikesIteratorResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'c',
    's',
    'v',
  };
}

