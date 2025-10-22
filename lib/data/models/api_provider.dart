enum ApiProviderType { 
  openai,      // OpenAI官方及兼容接口
  gemini,      // Google Gemini
  zhipuai,     // 智谱AI
  qwen,        // 通义千问
  moonshot,    // 月之暗面
  other        // 其他自定义
}

ApiProviderType apiProviderTypeFromStorage(String value) {
  switch (value) {
    case 'gemini':
      return ApiProviderType.gemini;
    case 'openai':
      return ApiProviderType.openai;
    case 'zhipuai':
      return ApiProviderType.zhipuai;
    case 'qwen':
      return ApiProviderType.qwen;
    case 'moonshot':
      return ApiProviderType.moonshot;
    default:
      return ApiProviderType.other;
  }
}

extension ApiProviderTypeX on ApiProviderType {
  String get storageValue {
    switch (this) {
      case ApiProviderType.openai:
        return 'openai';
      case ApiProviderType.gemini:
        return 'gemini';
      case ApiProviderType.zhipuai:
        return 'zhipuai';
      case ApiProviderType.qwen:
        return 'qwen';
      case ApiProviderType.moonshot:
        return 'moonshot';
      case ApiProviderType.other:
        return 'other';
    }
  }

  bool get isOpenAICompatible => 
      this == ApiProviderType.openai || 
      this == ApiProviderType.zhipuai || 
      this == ApiProviderType.qwen || 
      this == ApiProviderType.moonshot;

  String get displayName {
    switch (this) {
      case ApiProviderType.openai:
        return 'OpenAI 兼容';
      case ApiProviderType.gemini:
        return 'Google Gemini';
      case ApiProviderType.zhipuai:
        return '智谱AI (GLM)';
      case ApiProviderType.qwen:
        return '通义千问 (Qwen)';
      case ApiProviderType.moonshot:
        return '月之暗面 (Kimi)';
      case ApiProviderType.other:
        return '其他自定义';
    }
  }

  String get defaultBaseUrl {
    switch (this) {
      case ApiProviderType.openai:
        return 'https://api.openai.com/v1';
      case ApiProviderType.gemini:
        return 'https://generativelanguage.googleapis.com/v1beta';
      case ApiProviderType.zhipuai:
        return 'https://open.bigmodel.cn/api/paas/v4';
      case ApiProviderType.qwen:
        return 'https://dashscope.aliyuncs.com/compatible-mode/v1';
      case ApiProviderType.moonshot:
        return 'https://api.moonshot.cn/v1';
      case ApiProviderType.other:
        return 'https://api.example.com/v1';
    }
  }

  String get defaultModel {
    switch (this) {
      case ApiProviderType.openai:
        return 'gpt-3.5-turbo';
      case ApiProviderType.gemini:
        return 'gemini-1.5-flash';
      case ApiProviderType.zhipuai:
        return 'glm-4';
      case ApiProviderType.qwen:
        return 'qwen-turbo';
      case ApiProviderType.moonshot:
        return 'moonshot-v1-8k';
      case ApiProviderType.other:
        return 'custom-model';
    }
  }
}
