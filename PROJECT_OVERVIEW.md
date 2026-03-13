# 秋葵游戏助手 - 项目总览

## 📋 项目信息

**项目名称**：秋葵游戏助手
**版本**：V1.0
**开发语言**：Swift 5.0+
**最低系统**：iOS 13.0+
**目标平台**：iOS (支持 TrollStore 安装)

## 🎯 项目目标

开发一个专为游戏玩家打造的 iOS 游戏辅助应用，提供实时变声、音效板和悬浮工具箱等功能，提升游戏语音体验。

## ✨ 核心功能

### 1. 实时变声器 (VoiceChanger)
- **功能描述**：实时改变说话声音的音调和速度
- **支持效果**：
  - 原声 (🎤)
  - 萝莉 (👧) - 高音调，快速
  - 大叔 (👨) - 低音调，慢速
  - 机器人 (🤖) - 机械音效
  - 电音 (⚡) - 电子音效
  - 花栗鼠 (🐿️) - 极高音调
  - 深沉 (🎭) - 极低音调

- **技术实现**：
  - 使用 `AVAudioEngine` 进行音频处理
  - 使用 `AVAudioUnitTimePitch` 调整音调
  - 使用 `AVAudioPlayer` 的 `rate` 属性调整速度
  - 使用 `AVAudioRecorder` 录制音频

- **主要类**：
  - `VoiceChangerViewController.swift` - UI 界面
  - `VoiceChangerManager.swift` - 音频处理逻辑

### 2. 音效板 (SoundEffect)
- **功能描述**：快速播放预设的音效
- **支持音效**：
  - 鼓掌 (👏)
  - 笑声 (😂)
  - 哇哦 (😲)
  - 欢呼 (🎉)
  - 悲伤 (😢)
  - 生气 (😡)
  - 加油 (💪)
  - 惊讶 (😱)

- **技术实现**：
  - 使用系统音效 `AudioServicesPlaySystemSound`
  - 支持震动反馈 `UIImpactFeedbackGenerator`
  - 视觉反馈动画

- **主要类**：
  - `SoundEffectViewController.swift` - UI 界面
  - `SoundEffectManager.swift` - 音效播放逻辑

### 3. 悬浮工具箱 (FloatingPanel)
- **功能描述**：悬浮在屏幕上的快捷工具菜单
- **支持工具**：
  - 亮度调节 - 快速调整屏幕亮度
  - 触感反馈 - 触觉反馈开关
  - 勿扰模式 - 跳转到系统勿扰设置
  - 网络检测 - 查看网络状态
  - 录屏功能 - 快捷录屏入口
  - 截图功能 - 保存截图到相册

- **技术实现**：
  - 自定义悬浮视图
  - 手势识别（拖拽、点击）
  - 边缘吸附动画
  - 系统 API 调用

- **主要类**：
  - `FloatingPanelManager.swift` - 悬浮面板管理
  - `FloatingPanelView.swift` - 悬浮视图

## 🏗️ 项目架构

### MVC 架构

```
┌─────────────────────────────────────────┐
│          AppDelegate (应用入口)          │
└─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────┐
│       MainViewController (主界面)        │
└─────────────────────────────────────────┘
                    │
    ┌───────────────┼───────────────┐
    ▼               ▼               ▼
┌─────────┐   ┌─────────┐   ┌─────────┐
│ 变声界面 │   │ 音效界面 │   │ 悬浮面板 │
└─────────┘   └─────────┘   └─────────┘
```

### 文件结构

```
AutumnOkraGameAssistant/
├── AutumnOkraGameAssistant.xcodeproj/    # Xcode 项目文件
│   └── project.pbxproj
│
├── AutumnOkraGameAssistant/              # 源代码目录
│   ├── AppDelegate.swift                 # 应用入口
│   ├── SceneDelegate.swift               # 场景代理
│   ├── ViewController.swift              # 默认控制器
│   │
│   ├── MainViewController.swift          # 主界面控制器
│   ├── VoiceChangerViewController.swift  # 变声界面
│   ├── SoundEffectViewController.swift  # 音效界面
│   │
│   ├── FloatingPanelManager.swift        # 悬浮面板管理器
│   │
│   ├── VoiceChangerManager.swift        # 变声音频处理
│   ├── SoundEffectManager.swift         # 音效管理
│   │
│   ├── Info.plist                        # 应用配置
│   ├── AutumnOkraGameAssistant.entitlements # 权限配置
│   │
│   ├── Main.storyboard                   # 主界面 Storyboard
│   ├── LaunchScreen.storyboard           # 启动屏
│   └── Assets.xcassets/                  # 资源文件
│       ├── Contents.json
│       └── AppIcon.appiconset/
│
├── .github/                              # GitHub Actions
│   └── workflows/
│       └── build-ipa.yml                 # 自动打包配置
│
├── README.md                             # 项目说明
├── DEPLOYMENT.md                         # 部署指南
└── .gitignore                            # Git 忽略文件
```

## 🔧 技术栈

### 开发工具
- **Xcode** 15.0+
- **Swift** 5.0+

### 核心框架
- **UIKit** - 用户界面
- **AVFoundation** - 音频处理
- **Foundation** - 基础框架

### 音频技术
- `AVAudioEngine` - 音频引擎
- `AVAudioPlayer` - 音频播放器
- `AVAudioRecorder` - 音频录制器
- `AVAudioUnitTimePitch` - 音调调节
- `AudioServicesPlaySystemSound` - 系统音效

### UI/UX
- `UINavigationController` - 导航控制器
- `UIStackView` - 布局容器
- `UIPanGestureRecognizer` - 拖拽手势
- `UITapGestureRecognizer` - 点击手势
- `UIView` 动画 - 视觉反馈

## 📦 构建与部署

### 本地构建
```bash
# 使用 Xcode 命令行工具
xcodebuild archive \
  -project AutumnOkraGameAssistant.xcodeproj \
  -scheme AutumnOkraGameAssistant \
  -configuration Release \
  -archivePath build/AutumnOkraGameAssistant.xcarchive

xcodebuild -exportArchive \
  -archivePath build/AutumnOkraGameAssistant.xcarchive \
  -exportPath build/export \
  -exportOptionsPlist exportOptions.plist
```

### GitHub Actions
- 自动构建 IPA 文件
- 支持手动触发和自动触发
- 自动上传到 GitHub Artifacts

### TrollStore 安装
- 无需开发者证书
- 永久有效
- 支持侧载安装

## 📊 权限需求

### Info.plist 配置
```xml
<key>NSMicrophoneUsageDescription</key>
<string>需要麦克风权限用于实时变声功能</string>

<key>NSPhotoLibraryAddUsageDescription</key>
<string>需要相册权限用于保存截图</string>
```

### Entitlements
```xml
<key>com.apple.security.application-groups</key>
<array>
    <string>group.com.autumnokra.gameassistant</string>
</array>
```

## 🎨 UI 设计

### 设计原则
- 简洁明了的界面
- 大按钮适合游戏场景
- 清晰的视觉反馈
- 支持横屏模式

### 颜色方案
- 主色：System Blue
- 辅助色：System Green, System Orange, System Red
- 背景：System Background
- 文字：System Label

### 布局
- 使用 Auto Layout 约束
- 支持不同屏幕尺寸
- 横屏优先设计

## 🚀 未来规划

### 短期计划 (V1.1)
- [ ] 自定义音效上传
- [ ] 变声参数精细调节
- [ ] 音效收藏夹
- [ ] 性能优化

### 中期计划 (V1.2)
- [ ] 游戏场景预设（开黑/整活/直播）
- [ ] 更多悬浮工具
- [ ] Siri 快捷指令集成
- [ ] 小组件支持

### 长期计划 (V2.0)
- [ ] 多人实时语音通话
- [ ] 云端音效库
- [ ] 个性化主题
- [ ] 数据统计功能

## ⚠️ 注意事项

### 法律合规
- 不包含任何游戏注入功能
- 不提供改内存或外挂功能
- 仅提供合法的辅助工具
- 符合 App Store 审核规范（虽然通过 TrollStore 分发）

### 技术限制
- iOS 系统限制某些功能
- 悬浮窗口在某些场景可能受限
- 音频处理依赖设备性能

### 兼容性
- 最低 iOS 13.0
- 支持 iPhone 和 iPad
- 建议使用 TrollStore 安装

## 📞 支持与反馈

### 问题反馈
- 提交 Issue
- 描述问题详情
- 提供设备信息和系统版本

### 功能建议
- 提交 Feature Request
- 说明使用场景
- 提供具体需求

## 📄 许可证

本项目仅供学习和交流使用，请勿用于商业用途。

---

**秋葵游戏助手 V1.0** - 让游戏更有趣！🎮
