
import 'package:openapi/api.dart';

class ProfileEntry {
  final AccountId uuid;
  final ContentId imageUuid;
  final double primaryContentGridCropSize;
  final double primaryContentGridCropX;
  final double primaryContentGridCropY;
  final String name;
  final String profileText;
  final String version;
  final int age;
  final List<ProfileAttributeValue> attributes;
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
      required this.version,
      required this.age,
      required this.attributes,
      this.content1,
      this.content2,
      this.content3,
      this.content4,
      this.content5,
      this.content6,
    }
  );
}
