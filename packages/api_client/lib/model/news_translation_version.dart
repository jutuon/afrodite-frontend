//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class NewsTranslationVersion {
  /// Returns a new [NewsTranslationVersion] instance.
  NewsTranslationVersion({
    required this.version,
  });

  int version;

  @override
  bool operator ==(Object other) => identical(this, other) || other is NewsTranslationVersion &&
    other.version == version;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (version.hashCode);

  @override
  String toString() => 'NewsTranslationVersion[version=$version]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'version'] = this.version;
    return json;
  }

  /// Returns a new [NewsTranslationVersion] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static NewsTranslationVersion? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "NewsTranslationVersion[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "NewsTranslationVersion[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return NewsTranslationVersion(
        version: mapValueOfType<int>(json, r'version')!,
      );
    }
    return null;
  }

  static List<NewsTranslationVersion> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <NewsTranslationVersion>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = NewsTranslationVersion.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, NewsTranslationVersion> mapFromJson(dynamic json) {
    final map = <String, NewsTranslationVersion>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NewsTranslationVersion.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of NewsTranslationVersion-objects as value to a dart map
  static Map<String, List<NewsTranslationVersion>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<NewsTranslationVersion>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = NewsTranslationVersion.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'version',
  };
}

