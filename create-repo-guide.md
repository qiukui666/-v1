# 创建GitHub仓库指南

## 第一步：手动创建仓库

由于GitHub API需要token，请你手动创建仓库：

### 方法一：通过网页创建（推荐）

1. **打开GitHub网站**
   - 访问：https://github.com/new

2. **填写仓库信息**
   - Repository name: `秋葵游戏助手`
   - Description: `秋葵游戏助手 - iOS/TrollStore 游戏语音助手`
   - 选择：Public（公开）
   - ✅ 不要勾选 "Add a README file"
   - ✅ 不要勾选 "Add .gitignore"
   - ✅ 不要勾选 "Choose a license"

3. **点击 "Create repository"**

### 方法二：使用GitHub CLI（如果已安装）

```bash
gh repo create 秋葵游戏助手 --public --description "秋葵游戏助手 - iOS/TrollStore 游戏语音助手"
```

---

## 第二步：推送代码

仓库创建完成后，运行以下命令：

```bash
cd c:/Users/Administrator/WorkBuddy/Claw/AutumnOkraGameAssistant
git push -u origin main
```

---

## 第三步：验证推送

推送成功后，访问：
https://github.com/qiukui666/秋葵游戏助手

你应该能看到：
- ✅ 所有源代码文件
- ✅ 文档文件
- ✅ GitHub Actions workflow
- ✅ README_CN.md

---

## 第四步：构建IPA

1. 访问：https://github.com/qiukui666/秋葵游戏助手/actions
2. 点击 "Build iOS IPA" workflow
3. 点击 "Run workflow" → 选择分支 → 点击绿色 "Run workflow" 按钮
4. 等待3-5分钟
5. 下载生成的 IPA 文件

---

## 提示

如果推送时遇到认证问题，需要配置GitHub凭据：
```bash
git config --global user.email "你的邮箱"
git config --global user.name "qiukui666"
```

然后重新推送：
```bash
git push -u origin main
```
