//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileAttributeFilterList {
  /// Returns a new [ProfileAttributeFilterList] instance.
  ProfileAttributeFilterList({
    this.filters = const [],
    this.lastSeenTimeFilter,
    this.unlimitedLikesFilter,
  });

  List<ProfileAttributeFilterValue> filters;

  LastSeenTimeFilter? lastSeenTimeFilter;

  bool? unlimitedLikesFilter;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileAttributeFilterList &&
    _deepEquality.equals(other.filters, filters) &&
    other.lastSeenTimeFilter == lastSeenTimeFilter &&
    other.unlimitedLikesFilter == unlimitedLikesFilter;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (filters.hashCode) +
    (lastSeenTimeFilter == null ? 0 : lastSeenTimeFilter!.hashCode) +
    (unlimitedLikesFilter == null ? 0 : unlimitedLikesFilter!.hashCode);

  @override
  String toString() => 'ProfileAttributeFilterList[filters=$filters, lastSeenTimeFilter=$lastSeenTimeFilter, unlimitedLikesFilter=$unlimitedLikesFilter]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'filters'] = this.filters;
    if (this.lastSeenTimeFilter != null) {
      json[r'last_seen_time_filter'] = this.lastSeenTimeFilter;
    } else {
      json[r'last_seen_time_filter'] = null;
    }
    if (this.unlimitedLikesFilter != null) {
      json[r'unlimited_likes_filter'] = this.unlimitedLikesFilter;
    } else {
      json[r'unlimited_likes_filter'] = null;
    }
    return json;
  }

  /// Returns a new [ProfileAttributeFilterList] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileAttributeFilterList? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileAttributeFilterList[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileAttributeFilterList[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileAttributeFilterList(
        filters: ProfileAttributeFilterValue.listFromJson(json[r'filters']),
        lastSeenTimeFilter: LastSeenTimeFilter.fromJson(json[r'last_seen_time_filter']),
        unlimitedLikesFilter: mapValueOfType<bool>(json, r'unlimited_likes_filter'),
      );
    }
    return null;
  }

  static List<ProfileAttributeFilterList> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileAttributeFilterList>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileAttributeFilterList.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileAttributeFilterList> mapFromJson(dynamic json) {
    final map = <String, ProfileAttributeFilterList>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAttributeFilterList.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileAttributeFilterList-objects as value to a dart map
  static Map<String, List<ProfileAttributeFilterList>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileAttributeFilterList>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileAttributeFilterList.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'filters',
  };
}

