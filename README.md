# pihka-frontend
Dating app frontend


## Update server API bindings

1. Install node version manager (nvm) <https://github.com/nvm-sh/nvm>
2. Install latest node LTS with nvm. For example `nvm install 18`
3. Install openapi-generator from npm. `npm install @openapitools/openapi-generator-cli -g`
4. Start pihka backend in debug mode.
5. Generate bindings
```
openapi-generator-cli generate -i http://localhost:3000/api-doc/pihka_api.json -g dart -o api_client
```

## Update generated code (freezed library)

```
dart run build_runner build
```


## Android MacOS local DNS server for correct certificate handling

### DNS server
```
brew install dnsmasq
```

/opt/homebrew/etc/dnsmasq.conf
```
listen-address=::1,127.0.0.1
address=/DOMAIN/10.0.2.2
port=5353
```

And start DNS

```
/opt/homebrew/opt/dnsmasq/sbin/dnsmasq -d -q --keep-in-foreground -C /opt/homebrew/etc/dnsmasq.conf
```

### Redirect

./Library/Android/sdk/platform-tools/adb devices

telnet 127.0.0.1 5554


# Update localizations

Run `make update-localizations`

The localizations are in the `translations` Android Studio project to make
editing translations easier.

### After git clone

1. Create lib/secrets.dart

```dart
String signInWithGoogleBackendClientId() {
    return "HELLO";
}

String signInWithGoogleIosClientId() {
    return "HELLO";
}
```

2. Add server certificate to

assets_not_in_git/server_root.crt

3. flutter gen-l10n

# About Assets

Google Sign In with buttons are from
<https://developers.google.com/static/identity/images/signin-assets.zip>
zip file found from <https://developers.google.com/identity/branding-guidelines>

# Building native code

1. Install Rust

2. Instal targets

```
rustup target add aarch64-linux-android
rustup target add armv7-linux-androideabi
rustup target add i686-linux-android
rustup target add x86_64-linux-android
```

3. Build app normally

4. If Rust dependencies are changed download cargo about and update
LICENSE file of native_utils Dart package:

```
cargo install cargo-about --locked
make update-licenses-for-native-utils
```
