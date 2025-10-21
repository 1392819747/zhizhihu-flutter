enum ApiProviderType { openai, gemini, other }

ApiProviderType apiProviderTypeFromStorage(String value) {
  switch (value) {
    case 'gemini':
      return ApiProviderType.gemini;
    case 'openai':
      return ApiProviderType.openai;
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
      case ApiProviderType.other:
        return 'other';
    }
  }

  bool get isOpenAICompatible => this == ApiProviderType.openai;
}
