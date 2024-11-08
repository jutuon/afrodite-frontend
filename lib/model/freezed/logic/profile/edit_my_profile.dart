
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:app/utils/immutable_list.dart';

part 'edit_my_profile.freezed.dart';

@freezed
class EditMyProfileData with _$EditMyProfileData {
  factory EditMyProfileData({
    int? age,
    String? name,
    @Default(UnmodifiableList<ProfileAttributeValueUpdate>.empty())
      UnmodifiableList<ProfileAttributeValueUpdate> attributes,
    @Default(false) bool unlimitedLikes,
  }) = _EditMyProfileData;
}
