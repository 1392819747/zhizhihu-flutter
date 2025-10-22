#!/bin/bash
set -euo pipefail

# 修复第三方插件的namespace问题，并补充兼容配置
echo "开始修复第三方插件的namespace问题..."

PUB_CACHE_DIR="${PUB_CACHE:-$HOME/.pub-cache}/hosted/pub.dev"

patch_namespace() {
  local plugin_dir="$1"
  local namespace="$2"
  local gradle_file="$PUB_CACHE_DIR/$plugin_dir/android/build.gradle"

  if [[ ! -f "$gradle_file" ]]; then
    return
  fi

  if grep -q "^\s*namespace" "$gradle_file"; then
    echo "插件 $plugin_dir 已设置 namespace，跳过。"
  else
    echo "修复 $plugin_dir..."
    python3 - "$gradle_file" "$namespace" <<'PY'
import sys
from pathlib import Path

gradle_path = Path(sys.argv[1])
namespace = sys.argv[2]
text = gradle_path.read_text()
needle = "android {"
if needle not in text:
    sys.exit(0)
replacement = f"{needle}\n    namespace '{namespace}'"
updated = text.replace(needle, replacement, 1)
gradle_path.write_text(updated)
PY
  fi
}

ensure_kotlin_jvm_target() {
  local plugin_dir="$1"
  local gradle_file="$PUB_CACHE_DIR/$plugin_dir/android/build.gradle"

  if [[ ! -f "$gradle_file" ]]; then
    return
  fi

  python3 - "$gradle_file" <<'PY'
import sys
from pathlib import Path

gradle_path = Path(sys.argv[1])
text = gradle_path.read_text()
start = text.find("android {")
if start != -1:
    brace_depth = 0
    end = None
    for idx, ch in enumerate(text[start:], start):
        if ch == '{':
            brace_depth += 1
        elif ch == '}':
            brace_depth -= 1
            if brace_depth == 0:
                end = idx
                break
    if end is not None:
        block = text[start:end]
        snippet = "\n    compileOptions {\n        sourceCompatibility JavaVersion.VERSION_1_8\n        targetCompatibility JavaVersion.VERSION_1_8\n    }\n\n    kotlinOptions {\n        jvmTarget = \"1.8\"\n    }\n"
        if "kotlinOptions" not in block and "compileOptions" not in block:
            text = text[:start] + block + snippet + text[end:]

if "tasks.withType(org.jetbrains.kotlin.gradle.tasks.KotlinCompile)" not in text:
    text = text.rstrip() + "\n\ntasks.withType(org.jetbrains.kotlin.gradle.tasks.KotlinCompile).configureEach {\n    kotlinOptions.jvmTarget = \"1.8\"\n}\n"

if not text.endswith("\n"):
    text += "\n"

gradle_path.write_text(text)
PY
}

strip_manifest_package() {
  local plugin_dir="$1"
  local manifest_file="$PUB_CACHE_DIR/$plugin_dir/android/src/main/AndroidManifest.xml"
  if [[ ! -f "$manifest_file" ]]; then
    return
  fi
  python3 - "$manifest_file" <<'PY'
import re
import sys
from pathlib import Path

manifest = Path(sys.argv[1])
text = manifest.read_text()
new_text, count = re.subn(r'\s+package="[^"]+"', '', text, count=1)
if count:
    manifest.write_text(new_text)
PY
}

patch_scan_android_build() {
  local plugin_dir="scan-1.6.0"
  local gradle_file="$PUB_CACHE_DIR/$plugin_dir/android/build.gradle"

  if [[ ! -f "$gradle_file" ]]; then
    return
  fi

  python3 - "$gradle_file" <<'PY'
import re
import sys
from pathlib import Path

gradle_path = Path(sys.argv[1])
text = gradle_path.read_text()

def strip_block(src: str, keyword: str) -> str:
    pattern = re.compile(rf"(?ms)^\s*{keyword}\s*\{{")
    match = pattern.search(src)
    if not match:
        return src
    start = match.start()
    idx = match.end() - 1  # position of '{'
    depth = 0
    while idx < len(src):
        if src[idx] == '{':
            depth += 1
        elif src[idx] == '}':
            depth -= 1
            if depth == 0:
                idx += 1
                break
        idx += 1
    return src[:start].rstrip() + "\n\n" + src[idx:].lstrip()

text = strip_block(text, "buildscript")

replacements = {
    "compileSdkVersion 29": "compileSdkVersion 34",
    "minSdkVersion 19": "minSdkVersion 23",
    "buildToolsVersion '28.0.3'": "",
    "androidx.appcompat:appcompat:1.2.0": "androidx.appcompat:appcompat:1.6.1",
}

for old, new in replacements.items():
    text = text.replace(old, new)

def ensure_target_sdk(src: str) -> str:
    pattern = re.compile(r"defaultConfig\s*\{(?P<body>.*?)\}", re.S)
    match = pattern.search(src)
    if not match:
        return src
    body = match.group('body')
    if "targetSdkVersion" in body:
        return src
    insertion = "\n        targetSdkVersion 34"
    body = body.rstrip() + insertion + "\n    "
    return src[:match.start('body')] + body + src[match.end('body'):]

text = ensure_target_sdk(text)

gradle_path.write_text(text.strip() + "\n")
PY
}

patch_sound_mode_android_build() {
  local plugin_dir="sound_mode-2.0.2"
  local gradle_file="$PUB_CACHE_DIR/$plugin_dir/android/build.gradle"

  if [[ ! -f "$gradle_file" ]]; then
    return
  fi

  python3 - "$gradle_file" <<'PY'
import re
import sys
from pathlib import Path

gradle_path = Path(sys.argv[1])
text = gradle_path.read_text()

def strip_block(src: str, keyword: str) -> str:
    pattern = re.compile(rf"(?ms)^\s*{keyword}\s*\{{")
    match = pattern.search(src)
    if not match:
        return src
    start = match.start()
    idx = match.end() - 1
    depth = 0
    while idx < len(src):
        if src[idx] == '{':
            depth += 1
        elif src[idx] == '}':
            depth -= 1
            if depth == 0:
                idx += 1
                break
        idx += 1
    return src[:start].rstrip() + "\n\n" + src[idx:].lstrip()

text = strip_block(text, "buildscript")
text = strip_block(text, r"rootProject\.allprojects")

replacements = {
    "compileSdkVersion 28": "compileSdkVersion 34",
    "minSdkVersion 16": "minSdkVersion 23",
    "androidx.annotation:annotation:1.1.0": "androidx.annotation:annotation:1.9.1",
}

for old, new in replacements.items():
    text = text.replace(old, new)

def ensure_target_sdk(src: str) -> str:
    pattern = re.compile(r"defaultConfig\s*\{(?P<body>.*?)\}", re.S)
    match = pattern.search(src)
    if not match:
        return src
    body = match.group('body')
    if "targetSdkVersion" in body:
        return src
    insertion = "\n        targetSdkVersion 34"
    body = body.rstrip() + insertion + "\n    "
    return src[:match.start('body')] + body + src[match.end('body'):]

text = ensure_target_sdk(text)

gradle_path.write_text(text.strip() + "\n")
PY
}

patch_namespace "flutter_keyboard_visibility-5.4.1" "com.jrai.flutter_keyboard_visibility"
patch_namespace "flutter_openim_sdk-3.8.3+3" "io.openim.flutter_openim_sdk"
patch_namespace "flutter_sensors-1.0.1" "com.example.fluttersensors"
patch_namespace "scan-1.6.0" "com.chavesgu.scan"
patch_namespace "sound_mode-2.0.2" "com.tryingoutsomething.soundmode.sound_mode"
patch_namespace "uri_to_file-1.0.0" "in.lazymanstudios.uri_to_file"

ensure_kotlin_jvm_target "flutter_sensors-1.0.1"
strip_manifest_package "flutter_sensors-1.0.1"
patch_scan_android_build
patch_sound_mode_android_build

echo "修复完成！"
