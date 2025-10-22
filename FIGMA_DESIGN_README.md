# 知知狐 - 基于Figma设计的聊天应用界面

## 🎨 设计概述

本项目基于Figma设计重新设计了WeChat应用的界面，采用了现代化的设计语言和用户体验。

## 📱 已实现的界面

### 1. Cover 启动页 (`/cover`)
- **功能**: 应用启动时的封面页面
- **设计特点**: 
  - 全屏背景图片
  - 渐变遮罩效果
  - 现代化的按钮设计
  - 品牌标识展示
- **文件位置**: `lib/pages/cover/`

### 2. 聊天列表页 (`/wechat_mock`)
- **功能**: 主要的聊天列表界面
- **设计特点**:
  - 渐变色头部设计
  - 卡片式聊天项目
  - 现代化的底部导航栏
  - 空状态优化
- **文件位置**: `lib/pages/wechat_mock/`

### 3. 搜索页面 (`/search`)
- **功能**: 聊天记录搜索
- **设计特点**:
  - 实时搜索功能
  - 搜索结果卡片展示
  - 空状态和无结果状态
  - 现代化的搜索栏设计
- **文件位置**: `lib/pages/search/`

## 🎯 设计特色

### 色彩方案
- **主色调**: `#5D6CF5` (蓝紫色)
- **辅助色**: `#2646F7` (深蓝色)
- **成功色**: `#07C160` (微信绿)
- **背景色**: `#F5F7FA` (浅灰)

### 设计原则
1. **现代化**: 采用卡片式设计和圆角元素
2. **一致性**: 统一的设计语言和交互模式
3. **可访问性**: 良好的对比度和字体大小
4. **响应式**: 适配不同屏幕尺寸

## 🚀 使用方法

### 导航到Cover页面
```dart
AppNavigator.startCover();
```

### 导航到聊天列表
```dart
AppNavigator.startWeChatMock();
```

### 导航到搜索页面
```dart
AppNavigator.startSearch();
```

## 📁 文件结构

```
lib/pages/
├── cover/
│   ├── cover_page.dart      # Cover页面UI
│   ├── cover_logic.dart     # Cover页面逻辑
│   └── cover_binding.dart   # Cover页面绑定
├── search/
│   ├── search_page.dart     # 搜索页面UI
│   ├── search_logic.dart    # 搜索页面逻辑
│   └── search_binding.dart  # 搜索页面绑定
└── wechat_mock/
    ├── wechat_mock_page.dart # 聊天列表页面UI
    ├── wechat_mock_logic.dart # 聊天列表页面逻辑
    └── wechat_mock_binding.dart # 聊天列表页面绑定
```

## 🎨 设计资源

### 已导出的图片资源
- `cover.png` - Cover页面背景
- `chat_list.png` - 聊天列表参考图
- `search.png` - 搜索页面参考图
- `search_active.png` - 搜索激活状态参考图
- 其他聊天界面参考图

### 资源文件位置
- 图片资源: `assets/images/`
- 资源常量: `lib/constants/assets.dart`

## 🔧 技术实现

### 依赖包
- `flutter_screenutil` - 屏幕适配
- `get` - 状态管理和路由
- `flutter` - UI框架

### 设计模式
- **MVC架构**: 使用GetX进行状态管理
- **组件化**: 可复用的UI组件
- **响应式设计**: 适配不同设备尺寸

## 📝 待实现功能

- [ ] 聊天对话界面重新设计
- [ ] 用户头像设置界面
- [ ] 更多交互动画效果
- [ ] 深色模式支持

## 🤝 贡献指南

1. 遵循现有的设计规范
2. 保持代码风格一致
3. 添加适当的注释
4. 测试不同设备尺寸的适配

## 📄 许可证

本项目基于原有的OpenIM Flutter项目，遵循相同的许可证条款。
