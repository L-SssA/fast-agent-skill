#!/usr/bin/env bash
# 安装技能脚本 - 使用软链接将 skills 目录中的技能链接到 .agents/skills 目录

set -e

echo "开始安装技能..."

# 定义源目录和目标目录
SOURCE_DIR="./skills"
TARGET_DIR="./.agents/skills"

# 检查源目录是否存在
if [ ! -d "$SOURCE_DIR" ]; then
    echo "错误: 源目录 $SOURCE_DIR 不存在"
    exit 1
fi

# 创建目标目录（如果不存在）
mkdir -p "$TARGET_DIR"

# 遍历源目录中的所有技能
for skill_dir in "$SOURCE_DIR"/*/; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        target_path="$TARGET_DIR/$skill_name"
        
        # 如果目标已存在，先删除
        if [ -e "$target_path" ] || [ -L "$target_path" ]; then
            rm -rf "$target_path"
            echo "已移除现有的 $skill_name"
        fi
        
        # 创建软链接
        ln -s "$(cd "$skill_dir" && pwd)" "$target_path"
        echo "已创建软链接: $skill_name -> $target_path"
    fi
done

echo "技能安装完成！"
echo "技能已链接到: $TARGET_DIR"
echo ""
echo "可用技能列表:"
ls -la "$TARGET_DIR"