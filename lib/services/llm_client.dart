import 'package:dio/dio.dart';

import '../data/models/api_provider.dart';
import '../domain/entities/api_entities.dart';

class LlmClient {
  LlmClient({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<String> createChatCompletion({
    required ApiEndpoint endpoint,
    required String apiKey,
    required List<Map<String, String>> messages,
  }) async {
    switch (endpoint.type) {
      case ApiProviderType.openai:
        return _createOpenAiCompletion(
            endpoint: endpoint, apiKey: apiKey, messages: messages);
      case ApiProviderType.gemini:
        throw UnimplementedError('Gemini 接口暂未实现');
      case ApiProviderType.other:
        return _createOpenAiCompletion(
            endpoint: endpoint, apiKey: apiKey, messages: messages);
    }
  }

  Future<String> _createOpenAiCompletion({
    required ApiEndpoint endpoint,
    required String apiKey,
    required List<Map<String, String>> messages,
  }) async {
    final url = _normalizeUrl(endpoint.baseUrl, '/chat/completions');
    final config = endpoint.generationConfig;
    final payload = {
      'model': endpoint.model,
      'messages': messages,
      'temperature': config.temperature,
      'top_p': config.topP,
      'max_tokens': config.maxTokens,
      'frequency_penalty': config.frequencyPenalty,
      'presence_penalty': config.presencePenalty,
      'stream': false,
    };
    if (config.stopSequences.isNotEmpty) {
      payload['stop'] = config.stopSequences;
    }
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        url,
        data: payload,
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
      );
      final data = response.data;
      if (data == null) throw Exception('空响应');
      final choices = data['choices'] as List?;
      if (choices == null || choices.isEmpty) throw Exception('接口未返回结果');
      final message = choices.first['message'] as Map<String, dynamic>?;
      if (message == null) throw Exception('响应不含 message 字段');
      final content = message['content'] as String? ?? '';
      return content;
    } on DioError catch (error) {
      final message = error.response?.data is Map<String, dynamic>
          ? (error.response?.data['error']?['message'] ?? error.message)
          : error.message;
      throw Exception('调用失败：$message');
    }
  }

  String _normalizeUrl(String base, String path) {
    final normalizedBase =
        base.endsWith('/') ? base.substring(0, base.length - 1) : base;
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return '$normalizedBase$normalizedPath';
  }
}
