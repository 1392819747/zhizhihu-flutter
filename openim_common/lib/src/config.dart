import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:media_kit/media_kit.dart';
import 'package:openim_common/openim_common.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class Config {
  static Future init(Function() runApp) async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      final path = (await getApplicationDocumentsDirectory()).path;
      cachePath = '$path/';
      await DataSp.init();
      await Hive.initFlutter(path);
      MediaKit.ensureInitialized();
      HttpUtil.init();
    } catch (_) {}

    runApp();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    var brightness = Platform.isAndroid ? Brightness.dark : Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
    ));

    final packageInfo = await PackageInfo.fromPlatform();
    _appName = packageInfo.appName;
  }

  static late String _appName;

  static late String cachePath;
  static const uiW = 375.0;
  static const uiH = 812.0;

  static const double textScaleFactor = 1.0;

  static const discoverPageURL = 'https://api.zhizhihu.cn';
  static const allowSendMsgNotFriend = '1';
  // amap key
  static const webKey = 'webKey';
  static const webServerKey = 'webServerKey';
  static const locationHost = 'http://location.your-domain';
  static const String _envQWeatherCombined =
      String.fromEnvironment('QWEATHER_API_KEY', defaultValue: '');
  static const String _envQWeatherCredentialId =
      String.fromEnvironment('QWEATHER_CREDENTIAL_ID', defaultValue: '');
  static const String _envQWeatherProjectId =
      String.fromEnvironment('QWEATHER_PROJECT_ID', defaultValue: '');
  static const String _envQWeatherPrivateKeyB64 =
      String.fromEnvironment('QWEATHER_PRIVATE_KEY_B64', defaultValue: '');
  static const String _envQWeatherPrivateKey =
      String.fromEnvironment('QWEATHER_PRIVATE_KEY', defaultValue: '');
  static const String _envQWeatherPrivateKeyPath =
      String.fromEnvironment('QWEATHER_PRIVATE_KEY_PATH', defaultValue: '');
  static const String _envQWeatherApiHost =
      String.fromEnvironment('QWEATHER_API_HOST', defaultValue: '');
  // 默认请求主机使用官方网关，适用于未配置专用域名的账号
  static const String _defaultQWeatherHost = 'api.qweather.com';

  static QWeatherCredentials? _cachedQWeatherCredentials;

  static QWeatherCredentials? get qWeatherCredentials =>
      _cachedQWeatherCredentials ??= _loadQWeatherCredentials();

  static String get qWeatherBaseUrl {
    final creds = qWeatherCredentials;
    final host = creds?.apiHost ??
        _resolveCredentialString(
          compileTime: _envQWeatherApiHost,
          runtimeKey: 'QWEATHER_API_HOST',
        );
    final resolved = (host == null || host.trim().isEmpty)
        ? _defaultQWeatherHost
        : host.trim();
    if (resolved.startsWith('http://') || resolved.startsWith('https://')) {
      return resolved.endsWith('/v7') ? resolved : '$resolved/v7';
    }
    return 'https://$resolved/v7';
  }

  static QWeatherCredentials? _loadQWeatherCredentials() {
    final combined = _resolveCredentialString(
      compileTime: _envQWeatherCombined,
      runtimeKey: 'QWEATHER_API_KEY',
    );
    if (combined != null && combined.isNotEmpty) {
      final parsed = _parseCombinedCredential(combined);
      if (parsed != null) {
        return parsed;
      }
    }

    final credentialId = _resolveCredentialString(
      compileTime: _envQWeatherCredentialId,
      runtimeKey: 'QWEATHER_CREDENTIAL_ID',
    );
    final projectId = _resolveCredentialString(
      compileTime: _envQWeatherProjectId,
      runtimeKey: 'QWEATHER_PROJECT_ID',
    );
    final privateKeySeed = _loadPrivateKeySeed();
    final apiHost = _resolveCredentialString(
      compileTime: _envQWeatherApiHost,
      runtimeKey: 'QWEATHER_API_HOST',
    );

    if (credentialId == null ||
        credentialId.isEmpty ||
        projectId == null ||
        projectId.isEmpty ||
        privateKeySeed == null) {
      return null;
    }
    return QWeatherCredentials(
      credentialId: credentialId,
      projectId: projectId,
      privateKeySeed: privateKeySeed,
      apiHost: apiHost,
    );
  }

  static QWeatherCredentials? _parseCombinedCredential(String source) {
    final trimmed = source.trim();
    if (trimmed.isEmpty) return null;

    // JSON format support: {"kid":"..","sub":"..","key":".."}
    if (trimmed.startsWith('{') && trimmed.endsWith('}')) {
      try {
        final decoded = jsonDecode(trimmed);
        if (decoded is Map<String, dynamic>) {
          final kid = decoded['kid'] ?? decoded['credentialId'] ?? decoded['id'];
          final sub = decoded['sub'] ?? decoded['projectId'] ?? decoded['project'];
          final host = decoded['host'] ?? decoded['apiHost'];
          final key = decoded['key'] ??
              decoded['privateKey'] ??
              decoded['privateKeyB64'] ??
              decoded['seed'];
          final seed = _decodePrivateKeyBase64(key?.toString()) ??
              _decodePrivateKeyString(key?.toString());
          if (kid != null &&
              kid.toString().isNotEmpty &&
              sub != null &&
              sub.toString().isNotEmpty &&
              seed != null) {
            return QWeatherCredentials(
              credentialId: kid.toString(),
              projectId: sub.toString(),
              privateKeySeed: seed,
              apiHost: host?.toString(),
            );
          }
        }
      } catch (_) {}
    }

    // Pipe separated format: kid|projectId|[apiHost|]base64PrivateKey
    final parts = trimmed.split('|');
    if (parts.length >= 3) {
      final credentialId = parts[0].trim();
      final projectId = parts[1].trim();
      final hasHost = parts.length >= 4;
      final host = hasHost ? parts[2].trim() : null;
      final keyPart = parts.sublist(hasHost ? 3 : 2).join('|').trim();
      final seed = _decodePrivateKeyBase64(keyPart) ?? _decodePrivateKeyString(keyPart);
      if (credentialId.isNotEmpty && projectId.isNotEmpty && seed != null) {
        return QWeatherCredentials(
          credentialId: credentialId,
          projectId: projectId,
          privateKeySeed: seed,
          apiHost: host,
        );
      }
    }

    return null;
  }

  static String? _resolveCredentialString({
    required String compileTime,
    required String runtimeKey,
  }) {
    if (compileTime.isNotEmpty) {
      return compileTime;
    }
    return Platform.environment[runtimeKey];
  }

  static Uint8List? _loadPrivateKeySeed() {
    final candidates = <Uint8List?>[
      _decodePrivateKeyBase64(_envQWeatherPrivateKeyB64),
      _decodePrivateKeyString(_envQWeatherPrivateKey),
      _decodePrivateKeyBase64(Platform.environment['QWEATHER_PRIVATE_KEY_B64']),
      _decodePrivateKeyString(Platform.environment['QWEATHER_PRIVATE_KEY']),
      _decodePrivateKeyFromPath(_envQWeatherPrivateKeyPath),
      _decodePrivateKeyFromPath(
          Platform.environment['QWEATHER_PRIVATE_KEY_PATH']),
      _decodePrivateKeyFromDefaultPaths(),
    ];
    for (final candidate in candidates) {
      if (candidate != null && candidate.isNotEmpty) {
        return candidate;
      }
    }
    return null;
  }

  static Uint8List? _decodePrivateKeyBase64(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    try {
      final normalized = value.replaceAll('\n', '').replaceAll(' ', '');
      final decoded = base64.decode(normalized);
      final seed = _parsePrivateKeyBytes(decoded);
      if (seed != null) return seed;
      final text = utf8.decode(decoded, allowMalformed: true);
      return _parsePrivateKeyText(text);
    } catch (_) {
      return null;
    }
  }

  static Uint8List? _decodePrivateKeyString(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return _parsePrivateKeyText(value);
  }

  static Uint8List? _decodePrivateKeyFromPath(String? path) {
    if (path == null || path.trim().isEmpty) return null;
    final file = File(path.trim());
    if (!file.existsSync()) return null;
    try {
      final content = file.readAsStringSync();
      return _parsePrivateKeyText(content);
    } catch (_) {
      return null;
    }
  }

  static Uint8List? _decodePrivateKeyFromDefaultPaths() {
    final home = Platform.environment['HOME'];
    final candidates = <String>[
      if (home != null) '$home/hefeng/ed25519-private.pem',
      if (home != null) '$home/hefeng/zhizhihu',
      '/Users/lizhiyin/hefeng/ed25519-private.pem',
      '/Users/lizhiyin/hefeng/zhizhihu',
    ];
    for (final path in candidates) {
      final seed = _decodePrivateKeyFromPath(path);
      if (seed != null) return seed;
    }
    return null;
  }

  static Uint8List? _parsePrivateKeyText(String text) {
    final sanitized = text
        .replaceAll('\r', '\n')
        .split('\n')
        .where((line) => !line.startsWith('---') && line.trim().isNotEmpty)
        .join();
    if (sanitized.isEmpty) {
      try {
        return _parsePrivateKeyBytes(
          Uint8List.fromList(utf8.encode(text)),
        );
      } catch (_) {
        return null;
      }
    }
    try {
      final pkcs8Bytes = base64.decode(sanitized);
      return _parsePrivateKeyBytes(pkcs8Bytes);
    } catch (_) {
      return null;
    }
  }

  static Uint8List? _parsePrivateKeyBytes(Uint8List? bytes) {
    if (bytes == null || bytes.isEmpty) return null;
    if (bytes.length == 32) {
      return Uint8List.fromList(bytes);
    }
    final seed = _extractEd25519Seed(bytes);
    if (seed != null) {
      return seed;
    }
    return null;
  }

  static Uint8List? _extractEd25519Seed(Uint8List pkcs8Bytes) {
    for (var i = 0; i < pkcs8Bytes.length - 34; i++) {
      if (pkcs8Bytes[i] == 0x04 && pkcs8Bytes[i + 1] == 0x20) {
        return Uint8List.fromList(pkcs8Bytes.sublist(i + 2, i + 34));
      }
    }
    return null;
  }

  static OfflinePushInfo get offlinePushInfo => OfflinePushInfo(
        title: _appName,
        desc: StrRes.offlineMessage,
        iOSBadgeCount: true,
      );

  static const friendScheme = "io.openim.app/addFriend/";
  static const groupScheme = "io.openim.app/joinGroup/";

  static const _host = "8.217.83.117";

  static const _ipRegex =
      '((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)';

  static bool get _isIP => RegExp(_ipRegex).hasMatch(_host);

  static String get serverIp {
    String? ip;
    var server = DataSp.getServerConfig();
    if (null != server) {
      ip = server['serverIP'];
    }
    return ip ?? _host;
  }

  static String get chatTokenUrl {
    String? url;
    var server = DataSp.getServerConfig();
    if (null != server) {
      url = server['chatTokenUrl'];
    }
    return url ?? (_isIP ? "http://$_host:10009" : "https://$_host/chat");
  }

  static String get appAuthUrl {
    String? url;
    var server = DataSp.getServerConfig();
    if (null != server) {
      url = server['authUrl'];
    }
    return url ?? (_isIP ? "http://$_host:10008" : "https://$_host/chat");
  }

  static String get imApiUrl {
    String? url;
    var server = DataSp.getServerConfig();
    if (null != server) {
      url = server['apiUrl'];
    }
    return url ?? (_isIP ? 'http://$_host:10002' : "https://$_host/api");
  }

  static String get imWsUrl {
    String? url;
    var server = DataSp.getServerConfig();
    if (null != server) {
      url = server['wsUrl'];
    }
    return url ?? (_isIP ? "ws://$_host:10001" : "wss://$_host/msg_gateway");
  }

  static int get logLevel {
    String? level;
    var server = DataSp.getServerConfig();
    if (null != server) {
      level = server['logLevel'];
    }
    return level == null ? 5 : int.parse(level);
  }
}

class QWeatherCredentials {
  QWeatherCredentials({
    required this.credentialId,
    required this.projectId,
    required Uint8List privateKeySeed,
    String? apiHost,
  })  : privateKeySeed = Uint8List.fromList(privateKeySeed),
        apiHost = apiHost?.trim().isEmpty ?? true ? null : apiHost?.trim();

  final String credentialId;
  final String projectId;
  final Uint8List privateKeySeed;
  final String? apiHost;
}
