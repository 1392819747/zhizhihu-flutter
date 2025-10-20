import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:cryptography/cryptography.dart';

/// 和风天气JWT Token生成器
/// 根据官方文档实现EdDSA签名算法
class QWeatherJWTGenerator {
  /// 凭据ID (kid)
  final String credentialId;
  
  /// 项目ID (sub)
  final String projectId;
  
  /// 私钥Base64字符串
  final String privateKeyBase64;
  
  QWeatherJWTGenerator({
    required this.credentialId,
    required this.projectId,
    required this.privateKeyBase64,
  });

  /// 生成JWT Token
  /// [expirationHours] 过期时间（小时），默认24小时
  Future<String> generateToken({int expirationHours = 24}) async {
    try {
      // 解析私钥
      final privateKey = await _parsePrivateKey();
      
      // 当前时间戳
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      
      // Header
      final header = {
        'alg': 'EdDSA',
        'kid': credentialId,
      };
      
      // Payload
      final payload = {
        'sub': projectId,
        'iat': now - 30, // 签发时间，提前30秒
        'exp': now + (expirationHours * 3600), // 过期时间
      };
      
      // 编码Header和Payload
      final headerEncoded = _base64UrlEncode(jsonEncode(header));
      final payloadEncoded = _base64UrlEncode(jsonEncode(payload));
      
      // 创建签名数据
      final signingInput = '$headerEncoded.$payloadEncoded';
      final signingBytes = utf8.encode(signingInput);
      
      // 使用Ed25519签名
      final signature = await Ed25519().sign(
        signingBytes,
        keyPair: privateKey,
      );
      
      // 编码签名
      final signatureEncoded = _base64UrlEncodeBytes(Uint8List.fromList(signature.bytes));
      
      // 组合JWT
      return '$headerEncoded.$payloadEncoded.$signatureEncoded';
    } catch (e) {
      throw Exception('生成JWT Token失败: $e');
    }
  }

  /// 解析私钥
  Future<SimpleKeyPair> _parsePrivateKey() async {
    try {
      // 解码Base64私钥（这是DER编码的私钥）
      final privateKeyBytes = base64Decode(privateKeyBase64);
      
      // 从DER编码中提取32字节的种子
      // DER格式: 30 2E 02 01 00 30 05 06 03 2B 65 70 04 22 04 20 [32字节种子]
      final seedBytes = privateKeyBytes.sublist(16, 48); // 提取最后32字节作为种子
      
      // 创建Ed25519私钥
      return Ed25519().newKeyPairFromSeed(seedBytes);
    } catch (e) {
      throw Exception('解析私钥失败: $e');
    }
  }

  /// Base64URL编码
  String _base64UrlEncode(String input) {
    final bytes = utf8.encode(input);
    return base64Url.encode(bytes).replaceAll('=', '');
  }

  /// Base64URL编码字节数组
  String _base64UrlEncodeBytes(Uint8List bytes) {
    return base64Url.encode(bytes).replaceAll('=', '');
  }
}

/// 和风天气配置类
class QWeatherConfig {
  static const String credentialId = 'C5PU3QE2R3';
  static const String projectId = '2H2CNHDC83';
  static const String apiHost = 'ma4wcmc6h6.re.qweatherapi.com';
  static const String privateKeyBase64 = 'MC4CAQAwBQYDK2VwBCIEIMtGiuRndAfjvR1JtObRpiV7g5fCxX6GQmdI9tN7c6xu';
  
  /// 创建JWT生成器实例
  static QWeatherJWTGenerator createJWTGenerator() {
    return QWeatherJWTGenerator(
      credentialId: credentialId,
      projectId: projectId,
      privateKeyBase64: privateKeyBase64,
    );
  }
  
  /// 获取API基础URL
  static String get baseUrl => 'https://$apiHost';
  
  /// 获取天气API URL
  static String get weatherApiUrl => '$baseUrl/v7';
  
  /// 获取地理API URL
  static String get geoApiUrl => '$baseUrl/v2';
}
