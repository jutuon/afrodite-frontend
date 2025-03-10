import 'package:app/ui_utils/crop_image_screen.dart';
import 'package:app/utils/list.dart';
import 'package:database/database.dart';

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:openapi/api.dart';

part 'my_profile.freezed.dart';

@freezed
class MyProfileData with _$MyProfileData, UpdateStateProvider {
  MyProfileData._();
  factory MyProfileData({
    @Default(UpdateIdle()) UpdateState updateState,
    MyProfileEntry? profile,
    @Default(false) bool loadingMyProfile,
    InitialAgeInfo? initialAgeInfo,
  }) = _MyProfileData;
}
