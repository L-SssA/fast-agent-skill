# 描述优化指南

本指南提供系统化优化技能 `description` 字段的方法，提升技能的触发准确性。

## 1. 描述优化策略

### 1.1 核心原则

#### 使用祈使句表达

**差的示例**：

```yaml
description: This skill processes CSV files and generates charts.
```

**好的示例**：

```yaml
description: Analyze CSV and tabular data files, compute summary statistics, add derived columns, and generate charts. Use when the user has a CSV, TSV, or Excel file and wants to explore, transform, or visualize the data.
```

**原因**：代理在决定是否行动，告诉它"何时行动"比"这个技能做什么"更有效。

#### 关注用户意图，而非实现细节

**差的示例**：

```yaml
description: Uses pandas library to read CSV files and matplotlib to create visualizations.
```

**好的示例**：

```yaml
description: Analyze CSV data, compute statistics, and create visualizations. Use when working with tabular data files or when the user mentions spreadsheets, data analysis, or charts.
```

**原因**：用户描述的是他们想实现的目标，不是技术实现方式。

#### 主动覆盖边界情况

**差的示例**：

```yaml
description: Process CSV files.
```

**好的示例**：

```yaml
description: >
  Analyze CSV and tabular data files — compute summary statistics,
  add derived columns, generate charts, and clean messy data. Use this
  skill when the user has a CSV, TSV, or Excel file and wants to
  explore, transform, or visualize the data, even if they don't
  explicitly mention "CSV" or "analysis."
```

**原因**：即使用户没有明确提及关键词，只要场景相关就应该触发。

#### 保持简洁

- 几句话到短段落通常足够
- 不超过 1024 字符硬限制
- 避免冗余和重复信息

## 2. 描述测试与迭代流程

系统化的测试方法能显著提升描述质量。

### 2.1 设计评估查询集

创建约 20 个测试查询：

- 8-10 个**应触发**的查询
- 8-10 个**不应触发**的查询

**应触发查询的多样性**：

1. **措辞变化**：正式、随意、带拼写错误
   - "Analyze my sales data in CSV format"
   - "can u help me look at this spreadsheet?"
   - "i got a csv file w/ revenue numbers"

2. **显式程度**：直接提及领域 vs 描述需求
   - "Process this CSV file"（显式）
   - "My boss wants a chart from this data file"（隐式）

3. **细节量**：简短 vs 详细
   - "Analyze my sales CSV"（简短）
   - "I have ~/Downloads/q4_sales.csv with columns date, product, revenue - can you find trends?"（详细）

4. **复杂度**：单步任务 vs 多步工作流
   - "Read this CSV"（简单）
   - "Load the data, clean missing values, calculate monthly averages, and create a line chart"（复杂）

**最有价值的应触发查询**：技能有帮助但联系不明显的情况。如果查询已经明确要求技能的功能，任何合理的描述都会触发。

**不应触发查询的质量**：

弱的负面示例（太明显无关）：

- "Write a fibonacci function"
- "What's the weather today?"

强的负面示例（近 miss 案例）：

- "I need to update formulas in my Excel budget spreadsheet"（涉及电子表格，但需要编辑而非分析）
- "Can you write a Python script that reads a CSV and uploads each row to our database?"（涉及 CSV，但任务是数据库 ETL 而非分析）

**真实性技巧**：

真实用户查询包含：

- 文件路径：`~/Downloads/report_final_v2.xlsx`
- 个人背景：`"my manager asked me to..."`
- 具体细节：列名、公司名、数据值
- 随意语言、缩写、偶尔的拼写错误

### 2.2 训练/验证集划分

为避免过拟合，将查询集分为两部分：

- **训练集（~60%）**：用于识别失败和指导改进
- **验证集（~40%）**：用于检查改进是否泛化

**要求**：

- 两个集合都包含应触发和不应触发查询的混合
- 随机打乱后固定划分
- 跨迭代保持一致以便比较

### 2.3 优化循环

执行以下步骤直到满意：

1. **评估当前描述**
   - 在训练集和验证集上运行所有查询
   - 记录每个查询的触发结果

2. **识别训练集中的失败**
   - 应触发但未触发的查询（漏报）
   - 不应触发但触发了的查询（误报）

3. **修订描述**
   - **漏报过多** → 描述可能太窄，扩大范围或添加上下文
   - **误报过多** → 描述可能太宽，增加特异性或澄清边界
   - **避免过拟合**：不要添加失败查询中的具体关键词，而是找到它们代表的通用类别
   - **结构性改变**：如果多次迭代无改进，尝试完全不同的描述框架

4. **重复步骤 1-3**
   - 直到训练集全部通过或无明显改进

5. **选择最佳版本**
   - 基于验证集通过率选择
   - 最佳描述不一定是最后一个，可能是中间某个版本

**迭代次数**：通常 5 次迭代足够。如果性能不再提升，问题可能在查询集而非描述。

## 3. 自动化评估脚本

以下 Bash 脚本框架可自动化评估流程（需根据代理客户端调整）：

```bash
#!/bin/bash
# evaluate_triggers.sh
# 用法: ./evaluate_triggers.sh <queries.json>

QUERIES_FILE="${1:?Usage: $0 <queries.json>}"
SKILL_NAME="your-skill-name"
RUNS=3

# 检测技能是否被调用的函数
# 需要根据你的代理客户端调整此函数
check_triggered() {
  local query="$1"

  # TODO: 替换为你的代理客户端检测逻辑
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
```

**使用方法**：

```bash
chmod +x evaluate_triggers.sh
./evaluate_triggers.sh eval_queries.json > results.json
```

**判定标准**：

- 应触发查询：触发率 > 0.5 为通过
- 不应触发查询：触发率 < 0.5 为通过

## 4. 解释结果

### 高触发率（应触发查询）

- ✓ 良好：描述有效捕获了使用场景
- ✗ 过高（接近 1.0）：可能描述太宽，检查不应触发查询的误报

### 低触发率（应触发查询）

- ✗ 描述太窄或缺少关键触发词
- 解决方案：扩大范围、添加同义词、包含隐式场景

### 高触发率（不应触发查询）

- ✗ 描述太宽或不够具体
- 解决方案：增加特异性、澄清边界、添加排除条件

### 低触发率（不应触发查询）

- ✓ 良好：正确避免了不相关场景

## 5. 避免过拟合

如果针对特定测试查询优化描述，可能导致过拟合——描述在这些查询上表现良好，但在新查询上失败。

**避免方法**：

- 使用训练/验证集划分
- 仅基于训练集失败进行改进
- 寻找通用类别而非具体关键词
- 定期用全新查询测试

## 6. 优化检查清单

完成描述优化后，确认：

- [ ] Description 使用祈使句
- [ ] Description 关注用户意图而非实现
- [ ] Description 覆盖边界情况
- [ ] Description 长度 < 1024 字符
- [ ] 进行了至少 3-5 轮优化迭代
- [ ] 使用了训练/验证集划分
- [ ] 验证集通过率满意
- [ ] 避免了过拟合（用新查询测试）

## 7. 下一步

描述优化完成后：

1. **应用最佳实践**：使用 [best-practices.md](best-practices.md) 改进技能指令内容
2. **测试验证**：使用 [evaluation-testing.md](evaluation-testing.md) 进行全面评估
3. **持续监控**：收集真实使用反馈，定期重新评估

记住：描述优化是提升技能性能最关键的一步。投入足够时间确保描述准确反映技能的使用场景。
