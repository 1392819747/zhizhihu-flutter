# GitHub 自动构建配置指南

## 📋 概述

本指南将帮助您为 OpenIM Flutter 项目配置 GitHub Actions 自动构建，支持 Android 和 iOS 平台的构建。

## 🚀 已配置的工作流

### 1. 基础构建工作流 (`build.yml`)
- **触发条件**: 推送到 main/develop 分支，创建 PR
- **功能**: 
  - Android APK 构建
  - iOS 无签名构建
  - 自动运行测试
  - 上传构建产物

### 2. Android 简单构建 (`android-release.yml`)
- **触发条件**: 推送到 main/develop 分支，创建 PR
- **功能**:
  - 无签名 APK 构建
  - 无签名 AAB 构建
  - 自动运行测试
  - 上传构建产物

### 3. iOS 简单构建 (`ios-simple.yml`)
- **触发条件**: 推送到 main/develop 分支，创建 PR
- **功能**:
  - 无签名 iOS 构建
  - 手动打包成 IPA
  - 上传构建产物

## 🔐 GitHub Secrets 配置

### 必需的 Secrets

| 名称 | 用途 |
| ---- | ---- |
当前天气接口采用 wttr.in 公共服务，无需额外 Secrets。

### 如果需要签名构建

如果您将来需要签名构建，可以添加以下 Secrets：

1. **KEYSTORE_BASE64** - keystore 文件的 base64 编码
2. **KEYSTORE_PASSWORD** - keystore 密码
3. **KEY_ALIAS** - 密钥别名
4. **KEY_PASSWORD** - 密钥密码

## 📱 构建产物

### Android
- **APK**: `build/app/outputs/flutter-apk/app-release.apk`
- **AAB**: `build/app/outputs/bundle/release/app-release.aab`

### iOS
- **IPA**: `build/ios/iphoneos/Runner.ipa`
- **App Bundle**: `build/ios/iphoneos/Runner.app`

## 🛠️ 本地构建命令

### Android
```bash
# 调试版本
flutter build apk --debug

# 发布版本
flutter build apk --release

# AAB 发布版本
flutter build appbundle --release
```

### iOS
```bash
# 无签名构建
flutter build ios --no-codesign

# 手动打包 IPA
cd build/ios/iphoneos
mkdir -p Payload
cp -r Runner.app Payload/
zip -r Runner.ipa Payload
```

## 🔧 自定义配置

### 修改 Flutter 版本
在 `.github/workflows/*.yml` 文件中修改：
```yaml
- name: Setup Flutter
  uses: subosito/flutter-action@v2
  with:
    flutter-version: '3.27.4'  # 修改为您需要的版本
```

### 修改构建参数
在构建步骤中添加环境变量：
```yaml
- name: Build APK
  run: flutter build apk --release
  env:
    FLUTTER_BUILD_MODE: release
    BUILD_NAME: ${{ github.ref_name }}
```

## 📋 构建检查清单

### 构建前检查
- [ ] 确保 `pubspec.yaml` 中的版本号正确
- [ ] 检查所有依赖项是否最新
- [ ] 运行 `flutter pub get` 确保依赖正常
- [ ] 运行 `flutter test` 确保测试通过

### Android 构建检查
- [ ] 确保 Android 项目配置正确
- [ ] 检查 `android/app/build.gradle` 中的基本配置
- [ ] 验证应用 ID 和版本信息

### iOS 构建检查
- [ ] 确保 iOS 项目配置正确
- [ ] 检查 `ios/Runner/Info.plist` 配置
- [ ] 验证 Bundle ID 设置

## 🚨 常见问题

### Android 构建失败
1. **Gradle 版本问题**: 检查 `android/gradle/wrapper/gradle-wrapper.properties`
2. **依赖冲突**: 运行 `flutter clean && flutter pub get`
3. **构建配置问题**: 检查 `android/app/build.gradle` 配置

### iOS 构建失败
1. **Xcode 版本**: 确保使用兼容的 Xcode 版本
2. **CocoaPods**: 运行 `cd ios && pod install`
3. **权限问题**: 检查文件权限设置

### 网络问题
1. **依赖下载失败**: 检查网络连接
2. **Flutter SDK 下载**: 使用缓存配置

## 📞 技术支持

如果遇到问题，请检查：
1. GitHub Actions 日志
2. Flutter 官方文档
3. 项目 README 文件

## 🔄 更新日志

- **v1.0**: 初始配置，支持基础构建
- **v1.1**: 添加 Android 无签名构建
- **v1.2**: 添加 iOS 无签名构建
- **v1.3**: 简化配置，移除签名依赖
