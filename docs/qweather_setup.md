# QWeather 凭据管理说明

为了避免把敏感凭据提交到仓库，和风天气相关的密钥通过以下方式管理：

1. **本地开发**
   - 复制 `config/qweather.env.example` 为 `config/qweather.env.local`。
   - 将实际的 `QWEATHER_API_KEY`（格式 `credentialId|projectId|[apiHost|]base64PrivateKey`）以及可选的 `QWEATHER_API_HOST` 写入 `.local` 文件。
   - 运行本地构建时，通过命令行导入，例如：
     ```bash
     source config/qweather.env.local
     flutter run --dart-define=QWEATHER_API_KEY="$QWEATHER_API_KEY" \
                 --dart-define=QWEATHER_API_HOST="$QWEATHER_API_HOST"
     ```
   - `.gitignore` 已忽略 `config/qweather.env.local`，确保密钥不会被提交。

2. **Codemagic**
   - 项目已在 `zhiyin` 变量组中配置 `QWEATHER_API_KEY`（安全存储）和 `QWEATHER_API_HOST=ma4wcmc6h6.re.qweatherapi.com`。
   - 每个 workflow 的 `environment.groups` 已引用 `zhiyin`，构建时会自动加载。
   - “Validate QWeather credentials” 步骤会输出掩码后的 Credential/Project ID，方便确认变量是否注入成功。

如需更换密钥或域名，记得同时更新本地 `.local` 文件和 Codemagic 变量组。***
