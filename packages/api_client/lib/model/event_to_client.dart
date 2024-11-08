//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class EventToClient {
  /// Returns a new [EventToClient] instance.
  EventToClient({
    this.accountState,
    this.accountSyncVersion,
    this.contentProcessingStateChanged,
    required this.event,
    this.latestViewedMessageChanged,
    this.permissions,
    this.visibility,
  });

  /// Data for event AccountStateChanged
  AccountState? accountState;

  /// Data for event AccountSyncVersionChanged
  AccountSyncVersion? accountSyncVersion;

  /// Data for event ContentProcessingStateChanged
  ContentProcessingStateChanged? contentProcessingStateChanged;

  EventType event;

  /// Data for event LatestViewedMessageChanged
  LatestViewedMessageChanged? latestViewedMessageChanged;

  /// Data for event AccountPermissionsChanged
  Permissions? permissions;

  /// Data for event ProfileVisibilityChanged
  ProfileVisibility? visibility;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EventToClient &&
    other.accountState == accountState &&
    other.accountSyncVersion == accountSyncVersion &&
    other.contentProcessingStateChanged == contentProcessingStateChanged &&
    other.event == event &&
    other.latestViewedMessageChanged == latestViewedMessageChanged &&
    other.permissions == permissions &&
    other.visibility == visibility;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountState == null ? 0 : accountState!.hashCode) +
    (accountSyncVersion == null ? 0 : accountSyncVersion!.hashCode) +
    (contentProcessingStateChanged == null ? 0 : contentProcessingStateChanged!.hashCode) +
    (event.hashCode) +
    (latestViewedMessageChanged == null ? 0 : latestViewedMessageChanged!.hashCode) +
    (permissions == null ? 0 : permissions!.hashCode) +
    (visibility == null ? 0 : visibility!.hashCode);

  @override
  String toString() => 'EventToClient[accountState=$accountState, accountSyncVersion=$accountSyncVersion, contentProcessingStateChanged=$contentProcessingStateChanged, event=$event, latestViewedMessageChanged=$latestViewedMessageChanged, permissions=$permissions, visibility=$visibility]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.accountState != null) {
      json[r'account_state'] = this.accountState;
    } else {
      json[r'account_state'] = null;
    }
    if (this.accountSyncVersion != null) {
      json[r'account_sync_version'] = this.accountSyncVersion;
    } else {
      json[r'account_sync_version'] = null;
    }
    if (this.contentProcessingStateChanged != null) {
      json[r'content_processing_state_changed'] = this.contentProcessingStateChanged;
    } else {
      json[r'content_processing_state_changed'] = null;
    }
      json[r'event'] = this.event;
    if (this.latestViewedMessageChanged != null) {
      json[r'latest_viewed_message_changed'] = this.latestViewedMessageChanged;
    } else {
      json[r'latest_viewed_message_changed'] = null;
    }
    if (this.permissions != null) {
      json[r'permissions'] = this.permissions;
    } else {
      json[r'permissions'] = null;
    }
    if (this.visibility != null) {
      json[r'visibility'] = this.visibility;
    } else {
      json[r'visibility'] = null;
    }
    return json;
  }

  /// Returns a new [EventToClient] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EventToClient? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "EventToClient[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "EventToClient[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return EventToClient(
        accountState: AccountState.fromJson(json[r'account_state']),
        accountSyncVersion: AccountSyncVersion.fromJson(json[r'account_sync_version']),
        contentProcessingStateChanged: ContentProcessingStateChanged.fromJson(json[r'content_processing_state_changed']),
        event: EventType.fromJson(json[r'event'])!,
        latestViewedMessageChanged: LatestViewedMessageChanged.fromJson(json[r'latest_viewed_message_changed']),
        permissions: Permissions.fromJson(json[r'permissions']),
        visibility: ProfileVisibility.fromJson(json[r'visibility']),
      );
    }
    return null;
  }

  static List<EventToClient> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EventToClient>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EventToClient.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EventToClient> mapFromJson(dynamic json) {
    final map = <String, EventToClient>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EventToClient.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EventToClient-objects as value to a dart map
  static Map<String, List<EventToClient>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EventToClient>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EventToClient.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'event',
  };
}

