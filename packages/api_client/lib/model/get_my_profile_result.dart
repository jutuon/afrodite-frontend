//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetMyProfileResult {
  /// Returns a new [GetMyProfileResult] instance.
  GetMyProfileResult({
    this.lastSeenTime,
    required this.profile,
    required this.syncVersion,
    required this.version,
  });

  /// Account's most recent disconnect time.  If the last seen time is not None, then it is Unix timestamp or -1 if the profile is currently online.
  int? lastSeenTime;

  Profile profile;

  ProfileSyncVersion syncVersion;

  ProfileVersion version;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetMyProfileResult &&
    other.lastSeenTime == lastSeenTime &&
    other.profile == profile &&
    other.syncVersion == syncVersion &&
    other.version == version;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (lastSeenTime == null ? 0 : lastSeenTime!.hashCode) +
    (profile.hashCode) +
    (syncVersion.hashCode) +
    (version.hashCode);

  @override
  String toString() => 'GetMyProfileResult[lastSeenTime=$lastSeenTime, profile=$profile, syncVersion=$syncVersion, version=$version]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.lastSeenTime != null) {
      json[r'last_seen_time'] = this.lastSeenTime;
    } else {
      json[r'last_seen_time'] = null;
    }
      json[r'profile'] = this.profile;
      json[r'sync_version'] = this.syncVersion;
      json[r'version'] = this.version;
    return json;
  }

  /// Returns a new [GetMyProfileResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetMyProfileResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetMyProfileResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetMyProfileResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetMyProfileResult(
        lastSeenTime: mapValueOfType<int>(json, r'last_seen_time'),
        profile: Profile.fromJson(json[r'profile'])!,
        syncVersion: ProfileSyncVersion.fromJson(json[r'sync_version'])!,
        version: ProfileVersion.fromJson(json[r'version'])!,
      );
    }
    return null;
  }

  static List<GetMyProfileResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetMyProfileResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetMyProfileResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetMyProfileResult> mapFromJson(dynamic json) {
    final map = <String, GetMyProfileResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetMyProfileResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetMyProfileResult-objects as value to a dart map
  static Map<String, List<GetMyProfileResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetMyProfileResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetMyProfileResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'profile',
    'sync_version',
    'version',
  };
}

