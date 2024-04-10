
import 'package:openapi/api.dart';
import 'package:pihka_frontend/ui_utils/crop_image_screen.dart';

class ProfileEntry {
  final AccountId uuid;
  final ContentId imageUuid;
  final double primaryContentGridCropSize;
  final double primaryContentGridCropX;
  final double primaryContentGridCropY;
  final String name;
  final String profileText;
  final int age;
  final List<ProfileAttributeValue> attributes;
  final String? version;
  final ContentId? content1;
  final ContentId? content2;
  final ContentId? content3;
  final ContentId? content4;
  final ContentId? content5;
  final ContentId? content6;
  ProfileEntry(
    {
      required this.uuid,
      required this.imageUuid,
      required this.primaryContentGridCropSize,
      required this.primaryContentGridCropX,
      required this.primaryContentGridCropY,
      required this.name,
      required this.profileText,
      required this.age,
      required this.attributes,
      this.version,
      this.content1,
      this.content2,
      this.content3,
      this.content4,
      this.content5,
      this.content6,
    }
  );

  List<ContentId> primaryImgAndPossibleOtherImgs() {
    final List<ContentId> contentList = [imageUuid];
    final c1 = content1;
    if (c1 != null) {
      contentList.add(c1);
    }
    final c2 = content2;
    if (c2 != null) {
      contentList.add(c2);
    }
    final c3 = content3;
    if (c3 != null) {
      contentList.add(c3);
    }
    final c4 = content4;
    if (c4 != null) {
      contentList.add(c4);
    }
    final c5 = content5;
    if (c5 != null) {
      contentList.add(c5);
    }
    return contentList;
  }

  String profileTitle() {
    return '$name$age';
  }

  CropResults primaryImageCropInfo() {
    return CropResults.fromValues(
      primaryContentGridCropSize,
      primaryContentGridCropX,
      primaryContentGridCropY
    );
  }
}
