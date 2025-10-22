# Flutter SDK Setup for Local Builds

These notes summarize the minimum tooling required to reproduce the CI Android APK build locally.

## Required Tooling
- **Flutter 3.27.4** (stable channel)
- **Java 17** (for Gradle)
- Android SDK command-line tools and platform build tools that match the `compileSdkVersion` declared in `android/app/build.gradle`

## Obtaining Flutter
1. Download the `flutter_linux_3.27.4-stable.tar.xz` archive from the [Flutter release site](https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.27.4-stable.tar.xz).
2. Extract the archive and add the unpacked `flutter/bin` directory to your `PATH`.
3. Run `flutter doctor --android-licenses` and accept the prompts so Gradle can build the Android project.

> If you work behind a restrictive proxy, pre-download the archive via a network that can reach `storage.googleapis.com` and copy it into the build environment manually.

## Preparing the Project
```bash
flutter pub get
flutter clean
flutter pub run build_runner build --delete-conflicting-outputs # only if code generation is needed
```

## Building the APK
```bash
flutter build apk --release
```

The unsigned release APK will appear at `build/app/outputs/flutter-apk/app-release.apk`.
