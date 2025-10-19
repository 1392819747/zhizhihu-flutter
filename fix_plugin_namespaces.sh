#!/bin/bash

# 修复第三方插件的namespace问题
echo "开始修复第三方插件的namespace问题..."

# 修复 flutter_keyboard_visibility
if [ -f "/Users/builder/.pub-cache/hosted/pub.dev/flutter_keyboard_visibility-5.4.1/android/build.gradle" ]; then
    echo "修复 flutter_keyboard_visibility..."
    sed -i '' 's/android {/android {\n    namespace '\''com.jrai.flutter_keyboard_visibility'\''/' "/Users/builder/.pub-cache/hosted/pub.dev/flutter_keyboard_visibility-5.4.1/android/build.gradle"
fi

# 修复 flutter_openim_sdk
if [ -f "/Users/builder/.pub-cache/hosted/pub.dev/flutter_openim_sdk-3.8.3+3/android/build.gradle" ]; then
    echo "修复 flutter_openim_sdk..."
    sed -i '' 's/android {/android {\n    namespace '\''io.openim.flutter_openim_sdk'\''/' "/Users/builder/.pub-cache/hosted/pub.dev/flutter_openim_sdk-3.8.3+3/android/build.gradle"
fi

# 修复 flutter_sensors
if [ -f "/Users/builder/.pub-cache/hosted/pub.dev/flutter_sensors-1.0.1/android/build.gradle" ]; then
    echo "修复 flutter_sensors..."
    sed -i '' 's/android {/android {\n    namespace '\''com.example.fluttersensors'\''/' "/Users/builder/.pub-cache/hosted/pub.dev/flutter_sensors-1.0.1/android/build.gradle"
fi

# 修复 scan
if [ -f "/Users/builder/.pub-cache/hosted/pub.dev/scan-1.6.0/android/build.gradle" ]; then
    echo "修复 scan..."
    sed -i '' 's/android {/android {\n    namespace '\''com.chavesgu.scan'\''/' "/Users/builder/.pub-cache/hosted/pub.dev/scan-1.6.0/android/build.gradle"
fi

# 修复 sound_mode
if [ -f "/Users/builder/.pub-cache/hosted/pub.dev/sound_mode-2.0.2/android/build.gradle" ]; then
    echo "修复 sound_mode..."
    sed -i '' 's/android {/android {\n    namespace '\''com.tryingoutsomething.soundmode.sound_mode'\''/' "/Users/builder/.pub-cache/hosted/pub.dev/sound_mode-2.0.2/android/build.gradle"
fi

# 修复 uri_to_file
if [ -f "/Users/builder/.pub-cache/hosted/pub.dev/uri_to_file-1.0.0/android/build.gradle" ]; then
    echo "修复 uri_to_file..."
    sed -i '' 's/android {/android {\n    namespace '\''in.lazymanstudios.uri_to_file'\''/' "/Users/builder/.pub-cache/hosted/pub.dev/uri_to_file-1.0.0/android/build.gradle"
fi

echo "修复完成！"
