import 'dart:async';

import 'package:camera/camera.dart';
import 'package:http/http.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository extends AppSingleton {
  ProfileRepository._private();
  static final _instance = ProfileRepository._private();
  factory ProfileRepository.getInstance() {
    return _instance;
  }

  final ApiManager api = ApiManager.getInstance();
  IteratorType _currentIterator = DatabaseIterator();

  @override
  Future<void> init() async {
    // nothing to do
  }

  Future<Profile?> requestProfile(AccountId id) async {
    return await api.profile((api) => api.getProfile(id.accountId));
  }

  Future<void> resetProfileIterator(bool clearDatabase) async {
    if (clearDatabase) {
      await api.profile((api) => api.postResetProfilePaging());
      await ProfileListDatabase.getInstance().clearProfiles();
      _currentIterator = OnlineIterator();
    } else {
      _currentIterator.reset();
    }
  }

  Future<List<ProfileListEntry>> nextList() async {
    final nextList = await _currentIterator.nextList();

    if (nextList.isEmpty && _currentIterator is OnlineIterator) {
      _currentIterator = DatabaseIterator();
    }
    return nextList;
  }
}

sealed class IteratorType {
  /// Resets the iterator to the beginning
  void reset() {}
  /// Returns the next list of profiles
  Future<List<ProfileListEntry>> nextList() async {
    return [];
  }
}
class OnlineIterator extends IteratorType {
  int currentIndex = 0;
  DatabaseIterator? databaseIterator;
  final ApiManager api = ApiManager.getInstance();

  OnlineIterator();

  @override
  void reset() {
    /// Reset to use database iterator and then continue online profile
    /// iterating.
    databaseIterator = DatabaseIterator();
  }

  @override
  Future<List<ProfileListEntry>> nextList() async {
    // Handle case where iterator has been reseted in the middle
    // of online iteration. Get the beginning from the database.
    final iterator = databaseIterator;
    if (iterator != null) {
      final list = await iterator.nextList();
      if (list.isNotEmpty) {
        return list;
      } else {
        databaseIterator = null;
      }
    }

    // TODO: What if server restarts? The client thinks that it is
    // in the middle of the list, but the server has reseted the iterator.

    final List<ProfileListEntry> list = List.empty(growable: true);
    final profiles = await api.profile((api) => api.postGetNextProfilePage());
    if (profiles != null) {
      if (profiles.profiles.isEmpty) {
        return [];
      }

      for (final p in profiles.profiles) {
        final profile = p;
        final primaryImageInfo = await api.media((api) => api.getPrimaryImageInfo(profile.id.accountId, false));
        final imageUuid = primaryImageInfo?.contentId?.contentId;
        if (imageUuid == null) {
          continue;
        }
        // final profileData = await api.profile((api) => api.getProfile(profile.id.accountId));
        // TODO: compare cached profile data with the one from the server
        final entry = ProfileListEntry(profile.id.accountId, imageUuid);
        await ProfileListDatabase.getInstance().insertProfile(entry);
        list.add(entry);
      }
    }
    return list;
  }
}
class DatabaseIterator extends IteratorType {
  int currentIndex;
  DatabaseIterator({this.currentIndex = 0});

  @override
  void reset() {
    currentIndex = 0;
  }

  @override
  Future<List<ProfileListEntry>> nextList() async {
    const queryCount = 10;
    final profiles = await ProfileListDatabase.getInstance().getProfileList(currentIndex, queryCount);
    if (profiles != null) {
      currentIndex += queryCount;
      return profiles;
    } else {
      return [];
    }
  }
}
