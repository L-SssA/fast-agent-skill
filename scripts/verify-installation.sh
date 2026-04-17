#!/usr/bin/env bash
# 验证技能安装脚本 - 检查 .agents/skills 目录中的技能安装状态

set -e

echo "===================================="
echo "  Agent Skills 安装验证"
echo "===================================="
echo ""

# 定义源目录和目标目录
SOURCE_DIR="./skills"
TARGET_DIR="./.agents/skills"

# 检查目标目录是否存在
if [ ! -d "$TARGET_DIR" ]; then
    echo "[错误] 技能目录不存在！"
    echo "请先运行 install-skills.sh 安装技能。"
    exit 1
fi

echo "[信息] 检查已安装的技能..."
echo ""

# 统计源目录中的技能总数
TOTAL_COUNT=0
if [ -d "$SOURCE_DIR" ]; then
    TOTAL_COUNT=$(find "$SOURCE_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l)
fi

# 统计已安装的技能数量
INSTALLED_COUNT=0
for skill_dir in "$TARGET_DIR"/*/; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        echo "[✓] $skill_name - 已安装"
        INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
    fi
done

echo ""
echo "===================================="
echo "  验证结果"
echo "===================================="
echo "已安装技能数: $INSTALLED_COUNT/$TOTAL_COUNT"
echo ""

if [ "$INSTALLED_COUNT" -eq "$TOTAL_COUNT" ]; then
    echo "[成功] 所有技能已正确安装！"
    echo ""
    echo "你可以在代理会话中使用 /skills 命令来查看可用技能。"
elif [ "$INSTALLED_COUNT" -gt 0 ]; then
    echo "[警告] 部分技能未安装，请运行 install-skills.sh 重新安装。"
else
    echo "[错误] 没有安装任何技能，请运行 install-skills.sh 进行安装。"
fi

echo ""
