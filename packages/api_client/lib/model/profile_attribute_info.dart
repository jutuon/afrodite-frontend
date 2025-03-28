//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileAttributeInfo {
  /// Returns a new [ProfileAttributeInfo] instance.
  ProfileAttributeInfo({
    required this.attributeOrder,
    this.attributes = const [],
  });

  AttributeOrderMode attributeOrder;

  List<AttributeIdAndHash> attributes;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileAttributeInfo &&
    other.attributeOrder == attributeOrder &&
    _deepEquality.equals(other.attributes, attributes);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (attributeOrder.hashCode) +
    (attributes.hashCode);

  @override
  String toString() => 'ProfileAttributeInfo[attributeOrder=$attributeOrder, attributes=$attributes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'attribute_order'] = this.attributeOrder;
      json[r'attributes'] = this.attributes;
    return json;
  }

  /// Returns a new [ProfileAttributeInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileAttributeInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileAttributeInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileAttributeInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileAttributeInfo(
        attributeOrder: AttributeOrderMode.fromJson(json[r'attribute_order'])!,
        attributes: AttributeIdAndHash.listFromJson(json[r'attributes']),
      );
    }
    return null;
  }

  static List<ProfileAttributeInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileAttributeInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileAttributeInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileAttributeInfo> mapFromJson(dynamic json) {
    final map = <String, ProfileAttributeInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAttributeInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileAttributeInfo-objects as value to a dart map
  static Map<String, List<ProfileAttributeInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileAttributeInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileAttributeInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'attribute_order',
    'attributes',
  };
}

