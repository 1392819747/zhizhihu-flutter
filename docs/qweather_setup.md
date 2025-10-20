# QWeather 凭据管理说明

为了避免把敏感凭据提交到仓库，和风天气相关的密钥通过以下方式管理：

1. **本地开发**
   - 复制 `config/qweather.env.example` 为 `config/qweather.env.local`。
   - 将最新的 `QWEATHER_API_TOKEN` 写入 `.local` 文件（该 token 由后端服务颁发，建议定期刷新）。
   - 运行本地构建时，通过命令行导入，例如：
     ```bash
     source config/qweather.env.local
     flutter run --dart-define=QWEATHER_API_TOKEN="$QWEATHER_API_TOKEN"
     ```
   - `.gitignore` 已忽略 `config/qweather.env.local`，确保密钥不会被提交。

2. **Codemagic**
   - 使用 API Token 管理后台，将 `QWEATHER_API_TOKEN`（Secret）添加到 `zhiyin` 变量组。
   - 每个 workflow 的 `environment.groups` 已引用 `zhiyin`，构建时会自动加载。
   - “Validate QWeather credentials” 步骤会输出 token 长度及打码摘要，方便确认变量是否注入成功。

和风天气域名现已固定为 `ma4wcmc6h6.re.qweatherapi.com`，无需再在环境变量中配置。如需更换 token，请同步更新本地 `.local` 文件及 Codemagic 变量组。***
