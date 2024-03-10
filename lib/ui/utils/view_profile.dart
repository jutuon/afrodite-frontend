


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/database/profile_database.dart';

import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:pihka_frontend/ui/utils/image_page.dart';

const double imgHeight = 400;

Widget viewProifle(BuildContext context, AccountId account, ProfileEntry profile, PrimaryImageProvider img, bool showGridImage) {
  return LayoutBuilder(
    builder: (context, constraints) {

      final Widget imgWidget;
      switch (img) {
        case PrimaryImageFile():

          final tag = img.heroTransition;
          if (tag != null) {
            imgWidget = Hero(
              tag: tag,
              child: Image.file(
                img.file,
                width: constraints.maxWidth,
                height: imgHeight,
              ),
            );
          } else {
            imgWidget = Image.file(
              img.file,
              width: constraints.maxWidth,
              height: imgHeight,
            );
          }
        case PrimaryImageInfo():
          imgWidget = viewProifleImage(context, account, profile, img, showGridImage, constraints);
      }
      String profileText;
      if (profile.profileText.isEmpty) {
        profileText = "";
      } else {
        profileText = profile.profileText;
      }
      return SingleChildScrollView(
        child: Column(
          children: [
            imgWidget,
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(profile.name, style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(profileText, style: Theme.of(context).textTheme.bodyLarge),
              ),
            ),

          ]
        ),
      );
    }
  );
}

Widget viewProifleImage(BuildContext context, AccountId account, ProfileEntry profile, PrimaryImageInfo img, bool showGridImage, BoxConstraints constraints) {

  final double imgMaxWidth;
  if (showGridImage) {
    imgMaxWidth = constraints.maxWidth / 2.0;
  } else {
    imgMaxWidth = constraints.maxWidth;
  }

  final Widget primaryImageWidget;
  final imgContentId = img.img;
  if (imgContentId != null) {
    primaryImageWidget = FutureBuilder(
      future: ImageCacheData.getInstance().getImage(account, imgContentId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active || ConnectionState.waiting: {
            return buildProgressIndicator(imgMaxWidth);
          }
          case ConnectionState.none || ConnectionState.done: {
            final imageFile = snapshot.data;
            if (imageFile != null) {
              return InkWell( // TODO: remove?
                onTap: () {
                  Navigator.push(context, MaterialPageRoute<void>(builder: (_) => ImagePage(account, imgContentId)));
                },
                child: Image.file(
                  imageFile,
                  width: imgMaxWidth,
                  height: imgHeight,
                ),
              );
            } else {
              return Text(context.strings.genericError);
            }
          }
        }
    },);
  } else {
    primaryImageWidget = Text(context.strings.genericEmpty);
  }

  return Row(
    children: [
      primaryImageWidget,
    ]
  );
}

Widget buildProgressIndicator(double imgMaxWidth) {
  return SizedBox(width: imgMaxWidth, child: const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(),
    ],
  ));
}


sealed class PrimaryImageProvider {}

class PrimaryImageFile extends PrimaryImageProvider {
  final File file;
  final ProfileHeroTag? heroTransition;
  PrimaryImageFile(this.file, {this.heroTransition});
}

class PrimaryImageInfo extends PrimaryImageProvider {
  final ContentId img;
  PrimaryImageInfo(this.img);
}
