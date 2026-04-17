#!/usr/bin/env bash
# 卸载技能脚本 - 移除 .agents/skills 目录中的所有技能链接

set -e

echo "开始卸载技能..."

# 定义目标目录
TARGET_DIR="./.agents/skills"

# 检查目标目录是否存在
if [ ! -d "$TARGET_DIR" ]; then
    echo "信息: 技能目录不存在，无需卸载"
    exit 0
fi

# 统计卸载数量
UNINSTALL_COUNT=0

# 遍历并删除所有技能
for skill_dir in "$TARGET_DIR"/*/; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        rm -rf "$skill_dir"
        echo "已卸载: $skill_name"
        UNINSTALL_COUNT=$((UNINSTALL_COUNT + 1))
    fi
done

echo ""
echo "技能卸载完成！"
echo "共卸载 $UNINSTALL_COUNT 个技能"
