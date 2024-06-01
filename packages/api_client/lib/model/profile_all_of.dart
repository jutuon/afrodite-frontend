//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileAllOf {
  /// Returns a new [ProfileAllOf] instance.
  ProfileAllOf({
    required this.age,
    this.attributes = const [],
    required this.name,
    required this.profileText,
    required this.publicId,
  });

  int age;

  List<ProfileAttributeValue> attributes;

  String name;

  String profileText;

  String publicId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileAllOf &&
     other.age == age &&
     other.attributes == attributes &&
     other.name == name &&
     other.profileText == profileText &&
     other.publicId == publicId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (age.hashCode) +
    (attributes.hashCode) +
    (name.hashCode) +
    (profileText.hashCode) +
    (publicId.hashCode);

  @override
  String toString() => 'ProfileAllOf[age=$age, attributes=$attributes, name=$name, profileText=$profileText, publicId=$publicId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'age'] = this.age;
      json[r'attributes'] = this.attributes;
      json[r'name'] = this.name;
      json[r'profile_text'] = this.profileText;
      json[r'public_id'] = this.publicId;
    return json;
  }

  /// Returns a new [ProfileAllOf] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileAllOf? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileAllOf[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileAllOf[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileAllOf(
        age: mapValueOfType<int>(json, r'age')!,
        attributes: ProfileAttributeValue.listFromJson(json[r'attributes'])!,
        name: mapValueOfType<String>(json, r'name')!,
        profileText: mapValueOfType<String>(json, r'profile_text')!,
        publicId: mapValueOfType<String>(json, r'public_id')!,
      );
    }
    return null;
  }

  static List<ProfileAllOf>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileAllOf>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileAllOf.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileAllOf> mapFromJson(dynamic json) {
    final map = <String, ProfileAllOf>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAllOf.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileAllOf-objects as value to a dart map
  static Map<String, List<ProfileAllOf>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileAllOf>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAllOf.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'age',
    'attributes',
    'name',
    'profile_text',
    'public_id',
  };
}

