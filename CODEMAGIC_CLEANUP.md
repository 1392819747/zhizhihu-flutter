# Codemagic环境变量清理指南

## 需要删除的环境变量

由于和风天气现在使用JWT自动认证，以下环境变量已经不再需要：

### Codemagic中需要删除的变量：

- **`QWEATHER_API_TOKEN`** - 和风天气API Token（已废弃）

## 操作步骤

### 1. 登录Codemagic控制台
访问 [Codemagic控制台](https://codemagic.io/apps)

### 2. 找到您的项目
选择 `zhizhihu-flutter` 项目

### 3. 删除环境变量
1. 进入 **Settings** → **Environment variables**
2. 找到 `QWEATHER_API_TOKEN` 变量
3. 点击删除按钮
4. 确认删除

### 4. 验证构建
删除环境变量后，可以触发一次构建来验证：
- JWT认证会自动工作
- 天气功能正常
- 无需任何手动配置

## 已更新的文件

以下文件已经更新，移除了对 `QWEATHER_API_TOKEN` 的引用：

- ✅ `codemagic.yaml` - 移除了所有Token相关的构建参数
- ✅ `GITHUB_CI_SETUP.md` - 标记Token配置为已废弃
- ✅ `CONFIGKEY.zh-CN.md` - 更新了配置说明
- ✅ `README.zh-CN.md` - 更新了快速开始指南

## 优势

删除环境变量后的好处：

1. **简化配置** - 无需管理Token的过期和刷新
2. **提高安全性** - 减少了敏感信息的存储
3. **自动化程度更高** - 系统完全自动处理认证
4. **降低维护成本** - 无需定期更新Token

## 验证方法

删除环境变量后，可以通过以下方式验证：

1. **触发Codemagic构建** - 检查构建日志中是否显示"QWeather JWT authentication is automated"
2. **检查天气功能** - 确保天气数据正常显示
3. **查看API调用** - 确认JWT Token自动生成和使用

## 总结

现在和风天气的认证完全自动化，您只需要：
1. 删除Codemagic中的 `QWEATHER_API_TOKEN` 环境变量
2. 享受无需手动配置的天气功能！

所有认证逻辑都已经内置在代码中，系统会自动处理JWT Token的生成和使用。
