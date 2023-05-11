


import 'dart:async';

import 'package:camera/camera.dart';
import 'package:http/http.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/api_provider.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MediaRepository {
  final ApiProvider api;

  MediaRepository(this.api);


  ApiProvider getMediaApi() {
    return api;
  }
}
