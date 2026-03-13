#!/bin/bash

# 秋葵游戏助手 - 本地测试脚本
# 此脚本用于在 macOS 上快速测试和构建项目

echo "=========================================="
echo "  秋葵游戏助手 - 本地测试工具"
echo "=========================================="
echo ""

# 检查是否在 macOS 上
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ 错误：此脚本只能在 macOS 上运行"
    echo "   请在 Mac 上执行此脚本"
    exit 1
fi

# 检查是否安装了 Xcode
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ 错误：未检测到 Xcode"
    echo "   请先从 App Store 安装 Xcode"
    exit 1
fi

echo "✅ 检测到 Xcode:"
xcodebuild -version
echo ""

# 进入项目目录
cd "$(dirname "$0")"

# 选项菜单
echo "请选择操作："
echo "1. 清理构建缓存"
echo "2. 在模拟器上运行"
echo "3. 构建并导出 IPA"
echo "4. 查看项目结构"
echo "5. 退出"
echo ""
read -p "请输入选项 (1-5): " choice

case $choice in
    1)
        echo ""
        echo "🧹 清理构建缓存..."
        xcodebuild clean -project AutumnOkraGameAssistant.xcodeproj -scheme AutumnOkraGameAssistant
        echo "✅ 清理完成"
        ;;
    2)
        echo ""
        echo "📱 在模拟器上运行..."
        xcodebuild -project AutumnOkraGameAssistant.xcodeproj \
                   -scheme AutumnOkraGameAssistant \
                   -sdk iphonesimulator \
                   -destination 'platform=iOS Simulator,name=iPhone 15' \
                   clean build

        if [ $? -eq 0 ]; then
            echo "✅ 构建成功！"
            echo "💡 提示：请在 Xcode 中点击 Run 按钮启动应用"
        else
            echo "❌ 构建失败"
        fi
        ;;
    3)
        echo ""
        echo "📦 构建并导出 IPA..."

        # 创建导出选项
        cat > exportOptions.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>development</string>
    <key>teamID</key>
    <string></string>
    <key>compileBitcode</key>
    <false/>
    <key>uploadSymbols</key>
    <false/>
    <key>signingStyle</key>
    <string>manual</string>
</dict>
</plist>
EOF

        # 构建并归档
        xcodebuild archive \
            -project AutumnOkraGameAssistant.xcodeproj \
            -scheme AutumnOkraGameAssistant \
            -configuration Release \
            -archivePath build/AutumnOkraGameAssistant.xcarchive \
            CODE_SIGN_IDENTITY="" \
            CODE_SIGNING_REQUIRED=NO \
            CODE_SIGNING_ALLOWED=NO

        if [ $? -eq 0 ]; then
            echo "✅ 归档成功！"

            # 导出 IPA
            xcodebuild -exportArchive \
                -archivePath build/AutumnOkraGameAssistant.xcarchive \
                -exportPath build/export \
                -exportOptionsPlist exportOptions.plist \
                CODE_SIGN_IDENTITY="" \
                CODE_SIGNING_REQUIRED=NO \
                CODE_SIGNING_ALLOWED=NO

            if [ $? -eq 0 ]; then
                echo "✅ IPA 导出成功！"
                echo "📁 文件位置: $(pwd)/build/export/"
                ls -la build/export/*.ipa
                echo ""
                echo "💡 使用方法："
                echo "   1. 将 IPA 文件传输到 iOS 设备"
                echo "   2. 使用 TrollStore 安装"
            else
                echo "❌ IPA 导出失败"
            fi
        else
            echo "❌ 归档失败"
        fi

        # 清理临时文件
        rm exportOptions.plist
        ;;
    4)
        echo ""
        echo "📂 项目结构："
        echo ""
        find . -type f -name "*.swift" -o -name "*.storyboard" -o -name "*.plist" -o -name "*.md" | grep -v ".git" | sort
        ;;
    5)
        echo "👋 再见！"
        exit 0
        ;;
    *)
        echo "❌ 无效选项"
        exit 1
        ;;
esac

echo ""
echo "=========================================="
echo "  操作完成！"
echo "=========================================="
