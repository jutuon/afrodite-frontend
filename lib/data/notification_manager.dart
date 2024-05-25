import 'dart:io';

import 'package:database/database.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/data/general/notification/state/message_received_static.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_category.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_id.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_payload.dart';
import 'package:pihka_frontend/data/push_notification_manager.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("NotificationManager");

const int _ANDROID_13_API_LEVEL = 33;
const int _ANDROID_8_API_LEVEL = 26;
const String _ANDROID_ICON_RESOURCE_NAME = "ic_notification";

const bool NOTIFICATION_CATEGORY_ENABLED_DEFAULT = true;

// TODO(prod): Check local notifications README

class NotificationManager extends AppSingleton {
  NotificationManager._private();
  static final _instance = NotificationManager._private();
  factory NotificationManager.getInstance() {
    return _instance;
  }

  bool _initDone = false;

  final _pluginHandle = FlutterLocalNotificationsPlugin();
  late final bool _osSupportsNotificationPermission;
  late final bool _osProvidesNotificationSettingsUi;
  NotificationPayload? _appLaunchNotificationPayload;

  bool get osSupportsNotificationPermission => _osSupportsNotificationPermission;
  bool get osProvidesNotificationSettingsUi => _osProvidesNotificationSettingsUi;
  PublishSubject<NotificationPayload> onReceivedPayload = PublishSubject();

  @override
  Future<void> init() async {
    if (_initDone) {
      return;
    }
    _initDone = true;

    const android = AndroidInitializationSettings(
      _ANDROID_ICON_RESOURCE_NAME
    );
    // TODO: The iOS permission settings might need to be set to false
    const darwin = DarwinInitializationSettings();
    const settings = InitializationSettings(
      android: android,
      iOS: darwin,
    );
    final result = await _pluginHandle.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload == null) {
          return;
        }
        final parsedPayload = NotificationPayload.parse(payload);
        if (parsedPayload == null) {
          return;
        }
        onReceivedPayload.add(parsedPayload);
      }
    );

    if (result == true) {
      log.info("Local notifications initialized");
    } else {
      log.error("Failed to initialize local notifications");
    }

    _osSupportsNotificationPermission = await _notificationPermissionShouldBeAsked();
    _osProvidesNotificationSettingsUi = await _isAndroid8OrLater();

    await _createAndroidNotificationChannelsIfNeeded();

    final launchDetails = await _pluginHandle.getNotificationAppLaunchDetails();
    if (launchDetails != null && launchDetails.didNotificationLaunchApp) {
      final payload = launchDetails.notificationResponse?.payload;
      if (payload != null) {
        final parsedPayload = NotificationPayload.parse(payload);
        if (parsedPayload != null) {
          _appLaunchNotificationPayload = parsedPayload;
        }
      }
    }

    // Close push notification only related notifications if those exist
    await NotificationMessageReceivedStatic.getInstance().updateState(false);
  }

  Future<void> askPermissions() async {
    if (Platform.isAndroid) {
      await _pluginHandle.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    } else if (Platform.isIOS) {
      await _pluginHandle.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else {
      throw UnsupportedError("Unsupported platform");
    }

    await PushNotificationManager.getInstance().initPushNotifications();
  }

  Future<bool> _notificationPermissionShouldBeAsked() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= _ANDROID_13_API_LEVEL) {
        return true;
      } else {
        return false;
      }
    } else if (Platform.isIOS) {
      return true;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  Future<bool> _isAndroid8OrLater() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= _ANDROID_8_API_LEVEL) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> sendNotification(
    {
      required NotificationId id,
      required String title,
      String? body,
      required NotificationCategory category,
      NotificationPayload? notificationPayload,
    }
  ) async {
    if (!await category.isEnabled()) {
      return;
    }

    final Priority priority;
    final Importance importance;
    if (category.headsUpNotification) {
      priority = Priority.high;
      importance = Importance.high;
    } else {
      priority = Priority.defaultPriority;
      importance = Importance.defaultImportance;
    }

    final androidDetails = AndroidNotificationDetails(
      category.id,
      category.title,
      priority: priority,
      importance: importance,
      enableLights: true,
    );
    await _pluginHandle.show(
      id.value,
      title,
      body,
      NotificationDetails(
        android: androidDetails,
      ),
      payload: notificationPayload?.toJson(),
    );
  }

  Future<void> hideNotification(NotificationId id) async {
    await _pluginHandle.cancel(id.value);
  }

  Future<void> _createAndroidNotificationChannelsIfNeeded() async {
    if (!await _isAndroid8OrLater()) {
      // Android notification channels are not supported
      return;
    }

    final handle = _pluginHandle.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    for (final category in NotificationCategory.all) {
      final Importance importance;
      if (category.headsUpNotification) {
        importance = Importance.high;
      } else {
        importance = Importance.defaultImportance;
      }

      final notificationChannel = AndroidNotificationChannel(
        category.id,
        category.title,
        importance: importance,
        enableLights: true,
      );

      await handle?.createNotificationChannel(notificationChannel);
    }
  }

  NotificationPayload? getAndRemoveAppLaunchNotificationPayload() {
    final payload = _appLaunchNotificationPayload;
    _appLaunchNotificationPayload = null;
    return payload;
  }

  Future<bool> areNotificationsEnabled() async {
    if (Platform.isAndroid) {
      return await _pluginHandle.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.areNotificationsEnabled() ?? false;
    } else if (Platform.isIOS) {
      final permissions = await _pluginHandle.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.checkPermissions();
      return permissions?.isEnabled ?? false;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  Future<NotificationSessionId> getSessionId() async {
    return NotificationSessionId(id: await KvIntManager.getInstance().getValue(KvInt.notificationSessionId) ?? 0);
  }
}

// TODO(prod): iOS notifications are not working
// TODO(prod): iOS notification permission is asked when app starts.
//             It should be asked at same location as on Android.
// TODO(prod): iOS back navigation gesture is not working on screens which have
//             some special PopScope logic. If back gesture is not working
//             perhaps floating action button should be displayed with
//             save data action.
// TODO(prod): Check that Sqlchipher is loading properly on iOS.
//             At least current error checking code does not notice anything
//             odd.

// TODO(prod): Add some public ID to profiles and use that ID in notifications.
//             Also add list of those IDs to pending notification JSON, sot that
//             normal conversation notifications are possible to be shown.
