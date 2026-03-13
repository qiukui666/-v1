# 秋葵游戏助手

> 专为游戏玩家打造的 iOS/TrollStore 版游戏语音助手

## 🎮 功能特性

### 1. 实时变声器 🎤
- **7种变声效果**：原声、萝莉、大叔、机器人、电音、花栗鼠、深沉
- **实时音频处理**：支持音调和播放速度调节
- **一键切换**：快速切换不同变声效果

### 2. 音效板 🔊
- **8种常用音效**：鼓掌、笑声、哇哦、欢呼、悲伤、生气、加油、惊讶
- **即时播放**：点击即播，无需等待
- **触摸反馈**：震动和视觉反馈增强体验

### 3. 悬浮工具箱 ⚡
- **亮度调节**：一键调整屏幕亮度
- **触感反馈**：触觉反馈开关
- **勿扰模式**：快速访问系统勿扰设置
- **网络检测**：实时查看网络状态
- **录屏功能**：快捷录屏入口
- **截图功能**：一键保存游戏画面

## 📱 安装方法

### 方式一：GitHub Actions 自动打包（推荐）
1. Fork 本仓库
2. 在 GitHub Actions 页面手动触发 workflow
3. 下载生成的 IPA 文件
4. 使用 TrollStore 安装

### 方式二：手动编译
1. 在 macOS 上打开 Xcode
2. 打开 `AutumnOkraGameAssistant.xcodeproj`
3. 选择目标设备（真机或模拟器）
4. 点击 Build 或 Run

## 🎯 使用说明

### 实时变声
1. 打开应用，点击"实时变声"
2. 选择想要的变声效果
3. 按住"按住说话"按钮开始录制
4. 松开按钮自动播放变声效果

### 音效板
1. 打开应用，点击"音效板"
2. 点击任意音效按钮即可播放
3. 音效支持连续点击

### 悬浮工具箱
1. 打开应用，点击"悬浮工具箱"
2. 悬浮球出现在屏幕右侧
3. 点击悬浮球打开工具菜单
4. 可以拖拽悬浮球到任意位置

## 🔧 技术栈

- **语言**：Swift 5.0+
- **框架**：UIKit, AVFoundation
- **音频处理**：AVAudioEngine, AVAudioUnitTimePitch
- **最低系统**：iOS 13.0+
- **开发工具**：Xcode 15.0+

## 📦 项目结构

```
AutumnOkraGameAssistant/
├── AutumnOkraGameAssistant/
│   ├── AppDelegate.swift              # 应用入口
│   ├── MainViewController.swift       # 主界面
│   ├── VoiceChangerViewController.swift  # 变声功能
│   ├── SoundEffectViewController.swift  # 音效板
│   ├── FloatingPanelManager.swift     # 悬浮面板
│   ├── VoiceChangerManager.swift      # 变声音频处理
│   └── SoundEffectManager.swift       # 音效管理
├── .github/workflows/
│   └── build-ipa.yml                  # GitHub Actions 配置
└── README.md
```

## ⚠️ 注意事项

1. **权限要求**：
   - 麦克风权限：用于实时变声和录音
   - 相册权限：用于保存截图

2. **使用限制**：
   - 本应用不包含任何游戏注入功能
   - 不提供改内存或外挂功能
   - 仅提供合法的辅助工具

3. **TrollStore 兼容性**：
   - 需要已安装 TrollStore 的 iOS 设备
   - 支持 iOS 13.0 及以上版本

## 🚀 未来计划

- [ ] 自定义音效上传
- [ ] 变声参数精细调节
- [ ] 音效收藏夹
- [ ] 游戏场景预设（开黑/整活/直播）
- [ ] 更多悬浮工具

## 📄 开源协议

本项目仅供学习和交流使用，请勿用于商业用途。

## 🙏 致谢

- 感谢 TrollStore 项目提供的 sideload 能力
- 感谢开源社区的音频处理方案

---

**秋葵游戏助手 V1.0** - 让游戏更有趣！🎮
