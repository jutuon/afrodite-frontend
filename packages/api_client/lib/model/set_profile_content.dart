//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SetProfileContent {
  /// Returns a new [SetProfileContent] instance.
  SetProfileContent({
    required this.c0,
    this.c1,
    this.c2,
    this.c3,
    this.c4,
    this.c5,
    this.gridCropSize,
    this.gridCropX,
    this.gridCropY,
  });

  /// Primary profile image which is shown in grid view.
  ContentId c0;

  ContentId? c1;

  ContentId? c2;

  ContentId? c3;

  ContentId? c4;

  ContentId? c5;

  double? gridCropSize;

  double? gridCropX;

  double? gridCropY;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SetProfileContent &&
    other.c0 == c0 &&
    other.c1 == c1 &&
    other.c2 == c2 &&
    other.c3 == c3 &&
    other.c4 == c4 &&
    other.c5 == c5 &&
    other.gridCropSize == gridCropSize &&
    other.gridCropX == gridCropX &&
    other.gridCropY == gridCropY;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (c0.hashCode) +
    (c1 == null ? 0 : c1!.hashCode) +
    (c2 == null ? 0 : c2!.hashCode) +
    (c3 == null ? 0 : c3!.hashCode) +
    (c4 == null ? 0 : c4!.hashCode) +
    (c5 == null ? 0 : c5!.hashCode) +
    (gridCropSize == null ? 0 : gridCropSize!.hashCode) +
    (gridCropX == null ? 0 : gridCropX!.hashCode) +
    (gridCropY == null ? 0 : gridCropY!.hashCode);

  @override
  String toString() => 'SetProfileContent[c0=$c0, c1=$c1, c2=$c2, c3=$c3, c4=$c4, c5=$c5, gridCropSize=$gridCropSize, gridCropX=$gridCropX, gridCropY=$gridCropY]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'c0'] = this.c0;
    if (this.c1 != null) {
      json[r'c1'] = this.c1;
    } else {
      json[r'c1'] = null;
    }
    if (this.c2 != null) {
      json[r'c2'] = this.c2;
    } else {
      json[r'c2'] = null;
    }
    if (this.c3 != null) {
      json[r'c3'] = this.c3;
    } else {
      json[r'c3'] = null;
    }
    if (this.c4 != null) {
      json[r'c4'] = this.c4;
    } else {
      json[r'c4'] = null;
    }
    if (this.c5 != null) {
      json[r'c5'] = this.c5;
    } else {
      json[r'c5'] = null;
    }
    if (this.gridCropSize != null) {
      json[r'grid_crop_size'] = this.gridCropSize;
    } else {
      json[r'grid_crop_size'] = null;
    }
    if (this.gridCropX != null) {
      json[r'grid_crop_x'] = this.gridCropX;
    } else {
      json[r'grid_crop_x'] = null;
    }
    if (this.gridCropY != null) {
      json[r'grid_crop_y'] = this.gridCropY;
    } else {
      json[r'grid_crop_y'] = null;
    }
    return json;
  }

  /// Returns a new [SetProfileContent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SetProfileContent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SetProfileContent[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SetProfileContent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SetProfileContent(
        c0: ContentId.fromJson(json[r'c0'])!,
        c1: ContentId.fromJson(json[r'c1']),
        c2: ContentId.fromJson(json[r'c2']),
        c3: ContentId.fromJson(json[r'c3']),
        c4: ContentId.fromJson(json[r'c4']),
        c5: ContentId.fromJson(json[r'c5']),
        gridCropSize: mapValueOfType<double>(json, r'grid_crop_size'),
        gridCropX: mapValueOfType<double>(json, r'grid_crop_x'),
        gridCropY: mapValueOfType<double>(json, r'grid_crop_y'),
      );
    }
    return null;
  }

  static List<SetProfileContent> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SetProfileContent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SetProfileContent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SetProfileContent> mapFromJson(dynamic json) {
    final map = <String, SetProfileContent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SetProfileContent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SetProfileContent-objects as value to a dart map
  static Map<String, List<SetProfileContent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SetProfileContent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SetProfileContent.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'c0',
  };
}

