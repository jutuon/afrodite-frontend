//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AllMatchesPage {
  /// Returns a new [AllMatchesPage] instance.
  AllMatchesPage({
    this.profiles = const [],
    required this.version,
  });

  List<AccountId> profiles;

  /// This version can be sent to the server when WebSocket protocol data sync is happening.
  MatchesSyncVersion version;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AllMatchesPage &&
    _deepEquality.equals(other.profiles, profiles) &&
    other.version == version;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profiles.hashCode) +
    (version.hashCode);

  @override
  String toString() => 'AllMatchesPage[profiles=$profiles, version=$version]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'profiles'] = this.profiles;
      json[r'version'] = this.version;
    return json;
  }

  /// Returns a new [AllMatchesPage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AllMatchesPage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AllMatchesPage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AllMatchesPage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AllMatchesPage(
        profiles: AccountId.listFromJson(json[r'profiles']),
        version: MatchesSyncVersion.fromJson(json[r'version'])!,
      );
    }
    return null;
  }

  static List<AllMatchesPage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AllMatchesPage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AllMatchesPage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AllMatchesPage> mapFromJson(dynamic json) {
    final map = <String, AllMatchesPage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AllMatchesPage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AllMatchesPage-objects as value to a dart map
  static Map<String, List<AllMatchesPage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AllMatchesPage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AllMatchesPage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'profiles',
    'version',
  };
}

