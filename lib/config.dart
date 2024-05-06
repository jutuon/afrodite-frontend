

import 'dart:io';

const String _defaultAccountServerAddressAndroid = "***REMOVED***"; // Should point to 10.0.2.2 (Android emulator host)
const String _defaultAccountServerAddressIos = "http://localhost:3000"; // This address is for iOS simulator

String defaultServerUrlAccount() {
  if (Platform.isAndroid) {
    return _defaultAccountServerAddressAndroid;
  } else if (Platform.isIOS) {
    return _defaultAccountServerAddressIos;
  } else {
    throw UnimplementedError();
  }
}

String defaultServerUrlMedia() {
  return defaultServerUrlAccount();
}

String defaultServerUrlProfile() {
  return defaultServerUrlAccount();
}

String defaultServerUrlChat() {
  return defaultServerUrlAccount();
}
