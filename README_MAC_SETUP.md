# 🖥️ 使用Mac重新创建Xcode项目指南

由于手动创建的Xcode项目文件格式不完整，建议使用Xcode重新创建项目。

---

## 📋 前置条件

- ✅ Mac电脑
- ✅ 已安装Xcode（从App Store下载）
- ✅ GitHub账号
- ✅ 本地项目文件

---

## 🚀 重新创建项目步骤

### 第1步：在Mac上准备项目文件

```bash
# 克隆你的仓库
git clone https://github.com/qiukui666/-v1.git
cd -v1

# 或者如果你已经有本地文件，进入项目目录
cd c:/Users/Administrator/WorkBuddy/Claw/AutumnOkraGameAssistant
```

### 第2步：用Xcode创建新项目

1. **打开Xcode**

2. **创建新项目**
   - 菜单栏：`File` → `New` → `Project...`
   - 或者快捷键：`⌘ + Shift + N`

3. **选择模板**
   - 选择 `iOS` 标签
   - 选择 `App` 模板
   - 点击 `Next`

4. **填写项目信息**
   ```
   Product Name: AutumnOkraGameAssistant
   Team: (选择你的开发者团队，或"None")
   Organization Identifier: com.autumnokra
   Bundle Identifier: com.autumnokra.gameassistant
   Interface: Storyboard
   Language: Swift
   ```

5. **保存位置**
   - 选择一个临时位置（比如桌面）
   - 创建新文件夹：`Desktop/AutumnOkraGameAssistant`
   - 点击 `Create`

### 第3步：删除自动生成的文件

新项目会自动创建一些文件，我们需要删除它们并使用我们自己的代码：

1. 在Xcode左侧的项目导航器中，找到这些文件并删除：
   - `ViewController.swift`（保留，稍后替换）
   - `Main.storyboard`（保留，稍后替换）
   - `LaunchScreen.storyboard`（保留，稍后替换）
   - `Assets.xcassets`（保留，稍后替换）
   - `Info.plist`（保留，稍后替换）

   **重要：删除时选择 "Move to Trash"**

### 第4步：复制项目文件

将你之前创建的所有文件复制到新项目中：

#### 方法A：通过Finder复制（推荐）

1. 打开两个Finder窗口：
   - 窗口1：`/Users/你的用户名/WorkBuddy/Claw/AutumnOkraGameAssistant/AutumnOkraGameAssistant/`
   - 窗口2：Xcode项目文件夹

2. 复制以下文件到新项目：
   ```
   所有 .swift 文件：
   - AppDelegate.swift
   - SceneDelegate.swift
   - MainViewController.swift
   - VoiceChangerViewController.swift
   - SoundEffectViewController.swift
   - FloatingPanelManager.swift
   - ViewController.swift（覆盖默认的）

   资源文件：
   - Info.plist（覆盖默认的）
   - Main.storyboard（覆盖默认的）
   - LaunchScreen.storyboard（覆盖默认的）
   - Assets.xcassets/（覆盖默认的）
   - AutumnOkraGameAssistant.entitlements
   ```

#### 方法B：通过命令行复制

```bash
# 假设你的项目在桌面上的临时位置
cd ~/Desktop/AutumnOkraGameAssistant/AutumnOkraGameAssistant

# 复制所有Swift文件
cp /path/to/your/project/AutumnOkraGameAssistant/*.swift .

# 复制资源文件
cp /path/to/your/project/AutumnOkraGameAssistant/*.storyboard .
cp /path/to/your/project/AutumnOkraGameAssistant/Info.plist .
cp /path/to/your/project/AutumnOkraGameAssistant/AutumnOkraGameAssistant.entitlements .

# 复制Assets
rm -rf Assets.xcassets
cp -r /path/to/your/project/AutumnOkraGameAssistant/Assets.xcassets .
```

### 第5步：在Xcode中添加文件

1. 在Xcode中，右键点击 `AutumnOkraGameAssistant` 文件夹
2. 选择 `Add Files to "AutumnOkraGameAssistant"...`
3. 选择所有复制的文件
4. 确保勾选：
   - ✅ "Copy items if needed"
   - ✅ "Create groups"
   - ✅ "Add to targets: AutumnOkraGameAssistant"
5. 点击 `Add`

### 第6步：配置项目设置

1. 在Xcode中，点击项目名称（蓝色图标）
2. 选择 `AutumnOkraGameAssistant` target
3. 在 `General` 标签下：
   - 设置 `Display Name`: `秋葵游戏助手`
   - 设置 `Bundle Identifier`: `com.autumnokra.gameassistant`
   - 设置 `Version`: `1.0`
   - 设置 `Build`: `1`

4. 在 `Signing & Capabilities` 标签下：
   - 取消勾选 "Automatically manage signing"
   - 设置 `Team`: (选择你的团队，或留空)
   - 设置 `Signing Certificate`: (选择证书，或"Manual Signing")

### 第7步：配置权限

1. 打开 `Info.plist` 文件
2. 确保包含以下权限描述：
   ```xml
   <key>NSMicrophoneUsageDescription</key>
   <string>需要麦克风权限用于实时变声功能</string>

   <key>NSPhotoLibraryAddUsageDescription</key>
   <string>需要相册权限用于保存截图</string>
   ```

### 第8步：测试构建

1. 在Xcode顶部工具栏，选择模拟器（如iPhone 15）
2. 点击 `Run` 按钮（▶️）
3. 等待编译和运行

如果成功，你应该能看到应用在模拟器中启动！

### 第9步：导出IPA

1. 在Xcode顶部工具栏，选择 `Any iOS Device`
2. 菜单栏：`Product` → `Archive`
3. 等待归档完成
4. 在 `Organizer` 窗口中：
   - 选择刚创建的Archive
   - 点击 `Distribute App`
   - 选择 `Ad Hoc` 或 `Development`
   - 选择签名方式（或选择 "Automatically manage signing"）
   - 点击 `Distribute` → `Export`
   - 选择保存位置
   - 导出的文件就是 `.ipa` 文件

### 第10步：提交代码

```bash
# 删除旧的项目文件
rm -rf AutumnOkraGameAssistant.xcodeproj

# 复制新创建的项目文件（从Xcode项目位置）
cp -r ~/Desktop/AutumnOkraGameAssistant/AutumnOkraGameAssistant.xcodeproj .

# 提交更改
git add .
git commit -m "Recreate Xcode project with proper structure"
git push
```

---

## 🎯 快速脚本（可选）

如果你想自动化这个过程，可以创建一个脚本：

```bash
#!/bin/bash

# setup-mac-project.sh
echo "=== 秋葵游戏助手 - Mac项目设置 ==="

# 设置路径
OLD_PROJECT="/path/to/your/old/project"
NEW_PROJECT=~/Desktop/AutumnOkraGameAssistant

echo "1. 创建新Xcode项目..."
# 需要手动在Xcode中创建项目

echo "2. 复制文件..."
cp $OLD_PROJECT/AutumnOkraGameAssistant/*.swift $NEW_PROJECT/AutumnOkraGameAssistant/
cp $OLD_PROJECT/AutumnOkraGameAssistant/*.storyboard $NEW_PROJECT/AutumnOkraGameAssistant/
cp $OLD_PROJECT/AutumnOkraGameAssistant/Info.plist $NEW_PROJECT/AutumnOkraGameAssistant/
cp $OLD_PROJECT/AutumnOkraGameAssistant/AutumnOkraGameAssistant.entitlements $NEW_PROJECT/AutumnOkraGameAssistant/

echo "3. 在Xcode中打开项目并添加文件..."
open $NEW_PROJECT/AutumnOkraGameAssistant.xcodeproj

echo "完成！请在Xcode中完成后续步骤。"
```

---

## ⚠️ 常见问题

### Q1: 编译错误 "Use of unresolved identifier"
**A:** 确保所有Swift文件都已添加到项目中，检查 `Build Phases` → `Compile Sources`

### Q2: Storyboard找不到
**A:** 检查 `Info.plist` 中的 Storyboard 文件名是否正确

### Q3: 权限问题
**A:** 确保在 `Info.plist` 中正确配置了所有需要的权限

### Q4: 签名失败
**A:** 可以先在 `Signing & Capabilities` 中选择 "Automatically manage signing"

---

## ✅ 完成后的下一步

1. 测试应用是否正常运行
2. 导出IPA文件
3. 使用TrollStore安装到iOS设备
4. 测试所有功能

---

## 📞 需要帮助？

如果遇到问题，请检查：
- Xcode版本是否最新
- 所有文件是否正确复制
- Build Settings中的配置是否正确

---

**祝项目重建顺利！** 🎉
