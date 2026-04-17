#!/bin/bash
# evaluate_triggers.sh
# 用法: ./evaluate_triggers.sh <queries.json>
# 
# 此脚本用于评估技能的触发率。
# 需要根据你的代理客户端调整 check_triggered 函数。

QUERIES_FILE="${1:?Usage: $0 <queries.json>}"
SKILL_NAME="your-skill-name"
RUNS=3

# 检测技能是否被调用的函数
# 需要根据你的代理客户端调整此函数
check_triggered() {
  local query="$1"
  
  # TODO: 替换为你的代理客户端检测逻辑
  # 示例：Claude Code 的检测逻辑
  # claude -p "$query" --output-format json 2>/dev/null \
  #   | jq -e --arg skill "$SKILL_NAME" \
  #     'any(.messages[].content[]; .type == "tool_use" and .name == "Skill" and .input.skill == $skill)' \
  #     > /dev/null 2>&1
  
  # 如果技能被调用返回 0（成功），否则返回 1（失败）
  return 1
}

count=$(jq length "$QUERIES_FILE")
for i in $(seq 0 $((count - 1))); do
  query=$(jq -r ".[$i].query" "$QUERIES_FILE")
  should_trigger=$(jq -r ".[$i].should_trigger" "$QUERIES_FILE")
  triggers=0

  for run in $(seq 1 $RUNS); do
    check_triggered "$query" && triggers=$((triggers + 1))
  done

  jq -n \
    --arg query "$query" \
    --argjson should_trigger "$should_trigger" \
    --argjson triggers "$triggers" \
    --argjson runs "$RUNS" \
    '{query: $query, should_trigger: $should_trigger, triggers: $triggers, runs: $runs, trigger_rate: ($triggers / $runs)}'
done | jq -s '.'
