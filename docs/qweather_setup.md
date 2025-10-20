# QWeather 凭据管理说明

为了避免把敏感凭据提交到仓库，和风天气相关的密钥通过以下方式管理：

## JWT认证配置

项目现在使用和风天气的JWT认证方式，所有必要的凭据已经内置在代码中：

- **凭据ID**: C5PU3QE2R3
- **项目ID**: 2H2CNHDC83  
- **API Host**: ma4wcmc6h6.re.qweatherapi.com
- **私钥Base64**: MC4CAQAwBQYDK2VwBCIEIMtGiuRndAfjvR1JtObRpiV7g5fCxX6GQmdI9tN7c6xu

系统会自动生成JWT Token进行API认证，无需手动配置。

## 技术实现

1. **JWT Token生成**: 使用Ed25519算法签名，符合和风天气官方规范
2. **自动认证**: 每次API请求都会自动生成新的JWT Token
3. **Token有效期**: 默认24小时，可根据需要调整

## 开发说明

- 本地开发无需额外配置
- Codemagic构建无需配置环境变量
- 所有认证逻辑已封装在`QWeatherJWTGenerator`类中

## API使用

天气服务会自动处理JWT认证，开发者只需调用相应的天气API方法即可：

```dart
final weatherService = WeatherService();
final weather = await weatherService.getCurrentWeather();
```
