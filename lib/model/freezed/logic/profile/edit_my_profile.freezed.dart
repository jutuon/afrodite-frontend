// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_my_profile.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
class _DetectDefaultValueInCopyWith {
  const _DetectDefaultValueInCopyWith();
}

/// @nodoc
const _detectDefaultValueInCopyWith = _DetectDefaultValueInCopyWith();

/// @nodoc
final _privateConstructorErrorEditMyProfileData = UnsupportedError(
    'Private constructor EditMyProfileData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EditMyProfileData {
  int? get age => throw _privateConstructorErrorEditMyProfileData;
  String? get name => throw _privateConstructorErrorEditMyProfileData;
  UnmodifiableList<ProfileAttributeValueUpdate> get attributes => throw _privateConstructorErrorEditMyProfileData;
  bool get unlimitedLikes => throw _privateConstructorErrorEditMyProfileData;

  EditMyProfileData copyWith({
    int? age,
    String? name,
    UnmodifiableList<ProfileAttributeValueUpdate>? attributes,
    bool? unlimitedLikes,
  }) => throw _privateConstructorErrorEditMyProfileData;
}

/// @nodoc
abstract class _EditMyProfileData implements EditMyProfileData {
  factory _EditMyProfileData({
    int? age,
    String? name,
    UnmodifiableList<ProfileAttributeValueUpdate> attributes,
    bool unlimitedLikes,
  }) = _$EditMyProfileDataImpl;
}

/// @nodoc
class _$EditMyProfileDataImpl with DiagnosticableTreeMixin implements _EditMyProfileData {
  static const UnmodifiableList<ProfileAttributeValueUpdate> _attributesDefaultValue = UnmodifiableList<ProfileAttributeValueUpdate>.empty();
  static const bool _unlimitedLikesDefaultValue = false;
  
  _$EditMyProfileDataImpl({
    this.age,
    this.name,
    this.attributes = _attributesDefaultValue,
    this.unlimitedLikes = _unlimitedLikesDefaultValue,
  });

  @override
  final int? age;
  @override
  final String? name;
  @override
  final UnmodifiableList<ProfileAttributeValueUpdate> attributes;
  @override
  final bool unlimitedLikes;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditMyProfileData(age: $age, name: $name, attributes: $attributes, unlimitedLikes: $unlimitedLikes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditMyProfileData'))
      ..add(DiagnosticsProperty('age', age))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('attributes', attributes))
      ..add(DiagnosticsProperty('unlimitedLikes', unlimitedLikes));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EditMyProfileDataImpl &&
        (identical(other.age, age) ||
          other.age == age) &&
        (identical(other.name, name) ||
          other.name == name) &&
        (identical(other.attributes, attributes) ||
          other.attributes == attributes) &&
        (identical(other.unlimitedLikes, unlimitedLikes) ||
          other.unlimitedLikes == unlimitedLikes)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    age,
    name,
    attributes,
    unlimitedLikes,
  );

  @override
  EditMyProfileData copyWith({
    Object? age = _detectDefaultValueInCopyWith,
    Object? name = _detectDefaultValueInCopyWith,
    Object? attributes,
    Object? unlimitedLikes,
  }) => _$EditMyProfileDataImpl(
    age: (age == _detectDefaultValueInCopyWith ? this.age : age) as int?,
    name: (name == _detectDefaultValueInCopyWith ? this.name : name) as String?,
    attributes: (attributes ?? this.attributes) as UnmodifiableList<ProfileAttributeValueUpdate>,
    unlimitedLikes: (unlimitedLikes ?? this.unlimitedLikes) as bool,
  );
}
