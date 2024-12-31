# Afrodite
Afrodite is a dating app. This
repository contains the frontend part. [Backend repository](https://github.com/jutuon/afrodite-backend)

The app is under development and it is not ready for production.

<img src="/../images/profiles-view.jpg?raw=true" alt="Profiles view screenshot" width="30%">

## Features

Check [features.md](docs/features.md).

## Building and running

Tagged development preview versions (0.x) of frontend and backend
with the same minor version number are compatible with each other.
Main branch might be broken or incompatible with the backend.

1. Install [dependencies](#dependencies).

2. Add [placeholder files](#placeholder-files-needed-for-compiling-the-project).
   If building for iOS then also add missing
   [iOS project files](#add-missing-ios-project-files).

3. Build and run the frontend.

```
flutter devices
flutter run --release -d DEVICE
```

4. Optionally install [development dependencies](#development-dependencies).

4. Optionally add [push notification and Sign in with Google support](#adding-push-notification-and-sign-in-with-google-support).

### Dependencies

#### Android builds (on Ubuntu 22.04 and macOS)

1. Install [Rust](https://www.rust-lang.org/learn/get-started).

2. Install Android Rust targets.

```
rustup target add aarch64-linux-android
rustup target add armv7-linux-androideabi
rustup target add i686-linux-android
rustup target add x86_64-linux-android
```

3. Install [Flutter](https://docs.flutter.dev/get-started/install).

#### iOS builds (on macOS)

1. Install [Rust](https://www.rust-lang.org/learn/get-started).

2. Install iOS Rust targets.

```
rustup target add aarch64-apple-ios
rustup target add aarch64-apple-ios-sim
rustup target add x86_64-apple-ios
```

3. Install CocoaPods.

   <https://guides.cocoapods.org/using/getting-started.html#sudo-less-installation>

4. Install [Flutter](https://docs.flutter.dev/get-started/install).

### Development dependencies

Makefile commands starting with `watch` requires `fswatch`.

```
# Ubuntu
sudo apt install fswatch
```

```
# macOS with Homebrew package manager
brew install fswatch
```

Commands `make watch-translations`, `make watch-translations-linux` and `make update-translations` requires [xml2arb](https://github.com/jutuon/xml2arb).

Commands `make watch-freezed-code` and `make update-freezed-code` requires [icegen](https://github.com/jutuon/icegen).

Command `make update-api-bindings` requires `openapi-generator-cli`.

1. Install node version manager (nvm) <https://github.com/nvm-sh/nvm>
2. Install latest node LTS with nvm. For example `nvm install 18`
3. Install openapi-generator from npm.
   `npm install @openapitools/openapi-generator-cli -g`
4. Start backend in debug mode.
5. Run `make update-api-bindings`.

Command `make update-licenses-for-native-utils` requires
[cargo-about](https://github.com/EmbarkStudios/cargo-about).

### Placeholder files needed for compiling the project

lib/firebase_options.dart
```dart
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static const FirebaseOptions currentPlatform = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
  );
}
```

lib/sign_in_with_google_ids.dart
```dart
String signInWithGoogleBackendClientId() {
  return "";
}
```

### Add missing iOS project files

The file ios/Runner.xcodeproj is not included in the repository as it contains
development team ID. It can be created with following commands

```
cd afrodite-frontend
flutter create --platforms ios --project-name app .
```

Other new files or changes which `flutter create` command creates can be
removed.

## About Assets

Sign in with Google buttons are from
<https://developers.google.com/static/identity/images/signin-assets.zip>
ZIP file found from <https://developers.google.com/identity/branding-guidelines>.

## Add push notification and Sign in with Google support

Add web client ID by modifying web/index.html line

```html
<meta name="google-signin-client_id" content="TODO">
```

Add iOS client ID by modifying ios/Runner/Info.plist location

```xml
<!-- Copied from downloaded OAuth 2 client info. Value for key REVERSED_CLIENT_ID. -->
<string>TODO</string>
```

Enable gradle plugin for Google Services from android/app/build.gradle

```gradle
    // START: FlutterFire Configuration
    // Uncomment the following line if you have google-services.json added
    // id 'com.google.gms.google-services'
    // END: FlutterFire Configuration
```

Also add files

```
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
lib/firebase_options.dart
lib/sign_in_with_google_ids.dart
firebase.json
```

## Questions and answers

Check backend [README.md](https://github.com/jutuon/afrodite-backend#questions-and-answers).

## Contributions

Only bug fixes or documentation improvements are accepted at the moment.

Contributions must have the same license as the project (dual-licensed with
MIT and Apache 2.0).

## License

MIT License or Apache License 2.0
