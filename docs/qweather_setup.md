# 天气服务说明

当前客户端使用 [wttr.in](https://wttr.in/) 提供的公开天气接口：
- 首选获取浏览器/设备的精确经纬度访问 `https://wttr.in/<lat>,<lon>?format=j1&lang=zh`
- 若用户拒绝授权或定位失败，则自动回退到基于 IP 的 `https://wttr.in/?format=j1&lang=zh`
- API 为公开服务，无需额外的密钥或配置项

如需改用自建天气服务，可在 `WeatherService` 内调整请求策略。
