# 评估与测试指南

本指南提供系统化评估技能性能的方法，包括触发率测试和输出质量评估。

## 1. 触发率评估

触发率评估测试技能的 `description` 字段是否能准确判断何时应该激活技能。

### 1.1 设计评估查询集

参考 [description-optimization.md](description-optimization.md) 中的描述优化策略，创建平衡的查询集：

**推荐规模**：

- 总计约 20 个查询
- 8-10 个应触发（should_trigger: true）
- 8-10 个不应触发（should_trigger: false）

**查询格式**（JSON）：

```json
[
  {
    "query": "Analyze my sales data in ~/data/q4_results.csv",
    "should_trigger": true
  },
  {
    "query": "Write a Python function to calculate fibonacci numbers",
    "should_trigger": false
  }
]
```

### 1.2 执行评估

#### 多次运行计算触发率

由于模型行为的非确定性，每个查询应运行多次（建议 3 次）。

**触发率计算**：

```
触发率 = 技能被调用的次数 / 总运行次数
```

**判定标准**：

- 应触发查询：触发率 > 0.5 为通过
- 不应触发查询：触发率 < 0.5 为通过

#### 自动化评估脚本

使用 [assets/eval-script-template.sh](../assets/eval-script-template.sh) 作为起点，根据你的代理客户端调整检测逻辑。

**使用方法**：

```bash
chmod +x eval-script-template.sh
./eval-script-template.sh eval_queries.json > results.json
```

**分析结果**：

```bash
# 查看总体通过率
jq '[.[] | select(
  (.should_trigger and .trigger_rate > 0.5) or
  (not .should_trigger and .trigger_rate < 0.5)
)] | length' results.json

# 查看失败的查询
jq '[.[] | select(
  (.should_trigger and .trigger_rate <= 0.5) or
  (not .should_trigger and .trigger_rate >= 0.5)
)]' results.json
```

### 1.3 训练/验证集划分

为避免过拟合，将查询集分为两部分：

**划分比例**：

- 训练集：~60%（用于指导改进）
- 验证集：~40%（用于检查泛化能力）

**操作步骤**：

1. 随机打乱查询集
2. 按 60/40 分割为 `train_queries.json` 和 `validation_queries.json`
3. 确保两个集合都有应触发和不应触发查询的混合
4. 固定划分，跨迭代保持一致

**优化流程**：

```
1. 在训练集上评估当前描述
2. 识别训练集中的失败案例
3. 修订描述（仅基于训练集反馈）
4. 在验证集上检查改进是否泛化
5. 重复步骤 1-4 直到满意
6. 选择验证集通过率最高的版本
```

**关键原则**：

- 仅使用训练集失败案例指导改进
- 不要根据验证集结果调整描述（会导致过拟合）
- 如果验证集性能下降，回退到之前的版本

### 1.4 解释结果

**高触发率（应触发查询）**：

- ✓ 良好：描述有效捕获了使用场景
- ✗ 过高（接近 1.0）：可能描述太宽，检查不应触发查询的误报

**低触发率（应触发查询）**：

- ✗ 描述太窄或缺少关键触发词
- 解决方案：扩大范围、添加同义词、包含隐式场景

**高触发率（不应触发查询）**：

- ✗ 描述太宽或不够具体
- 解决方案：增加特异性、澄清边界、添加排除条件

**低触发率（不应触发查询）**：

- ✓ 良好：正确避免了不相关场景

## 2. 输出质量评估

触发率测试确保技能在正确时机激活，输出质量评估确保技能产生有用、准确的结果。

### 2.1 设计测试用例集

为技能的典型使用场景创建测试用例。

**测试用例格式**：

```json
{
  "test_cases": [
    {
      "id": "tc_001",
      "name": "Basic CSV Analysis",
      "input": "Analyze the sales data in ~/data/sales.csv",
      "expected_output_criteria": [
        "Should read the CSV file",
        "Should compute summary statistics (mean, median, etc.)",
        "Should identify trends or patterns",
        "Should present results in a clear format"
      ],
      "difficulty": "easy"
    },
    {
      "id": "tc_002",
      "name": "Complex Multi-step Workflow",
      "input": "Load data.csv, clean missing values, calculate monthly averages, and create a line chart showing trends",
      "expected_output_criteria": [
        "Should handle missing data appropriately",
        "Should calculate correct monthly averages",
        "Should generate a valid chart",
        "Should explain the findings"
      ],
      "difficulty": "hard"
    }
  ]
}
```

**测试用例多样性**：

覆盖不同难度级别：

- **简单**：单步任务，清晰的输入输出
- **中等**：多步任务，需要一些判断
- **困难**：复杂工作流，涉及多个决策点

覆盖不同场景：

- 典型用例（最常见的场景）
- 边界情况（极端值、空数据等）
- 错误处理（无效输入、缺失文件等）

### 2.2 定义评分标准

为每个测试用例定义明确的评分标准。

**评分维度**：

1. **正确性**（Correctness）
   - 结果是否准确？
   - 是否遵循了指令？
   - 是否有计算或逻辑错误？

2. **完整性**（Completeness）
   - 是否完成了所有要求的步骤？
   - 是否遗漏了重要信息？

3. **清晰度**（Clarity）
   - 输出是否易于理解？
   - 是否使用了适当的格式？
   - 解释是否清楚？

4. **效率**（Efficiency）
   - 是否使用了最优方法？
   - 是否浪费了不必要的步骤？
   - 是否合理使用了工具？

**评分等级**：

- **5分（优秀）**：完全满足所有标准，超出预期
- **4分（良好）**：满足主要标准，有小瑕疵
- **3分（合格）**：基本完成任务，有明显改进空间
- **2分（需改进）**：部分完成，有重大缺陷
- **1分（失败）**：未能完成任务或结果错误

### 2.3 执行评估

#### 手动评估流程

1. **运行测试用例**
   - 对每个测试用例，使用技能执行任务
   - 记录代理的完整响应

2. **对照标准评分**
   - 根据 expected_output_criteria 逐项检查
   - 为每个维度打分（1-5）
   - 计算平均分

3. **记录问题**
   - 记录任何错误或不当行为
   - 标注可以改进的地方
   - 收集具体的失败案例

4. **汇总结果**
   - 计算整体平均分
   - 识别薄弱环节
   - 确定优先级改进项

#### 自动化评估（如可行）

对于某些类型的技能，可以编写自动化验证脚本检查输出格式和内容。

### 2.4 系统化迭代改进

基于评估结果进行有针对性的改进。

**识别常见问题模式**：

**正确性问题**：

- 代理误解了指令 → 澄清指令，提供更多示例
- 代理犯了系统性错误 → 添加 gotchas 章节
- 代理忽略了约束 → 强调关键限制

**完整性问题**：

- 代理跳过了步骤 → 使用清单格式明确步骤
- 代理遗漏了验证 → 添加验证循环指令
- 代理未处理边界情况 → 列出边界情况及处理方法

**清晰度问题**：

- 输出格式不一致 → 提供输出模板
- 解释不充分 → 要求代理解释推理过程
- 技术术语过多 → 指定目标受众和语言风格

**效率问题**：

- 代理尝试多种方法 → 提供明确的默认方案
- 代理重复工作 → 指示缓存中间结果
- 代理使用了错误的工具 → 明确推荐工具

**改进策略**：

1. **针对性修改**
   - 根据具体问题修改 SKILL.md
   - 每次只改一个方面，便于归因

2. **重新评估**
   - 运行相同的测试用例
   - 比较改进前后的分数
   - 确认改进有效且无回归

3. **文档化变更**
   - 记录做了什么改动
   - 记录为什么这样改
   - 记录效果如何

4. **持续监控**
   - 定期运行测试套件
   - 收集真实用户反馈
   - 发现新问题时更新测试用例

## 3. 综合评估报告

创建评估报告跟踪技能的演进。

### 报告模板

```markdown
# Skill Evaluation Report

## Skill: [skill-name]

## Date: [YYYY-MM-DD]

## Version: [version]

## Summary

- Overall Trigger Rate: [X]%
- Overall Output Quality: [X]/5
- Tests Passed: [X]/[Y]

## Trigger Rate Analysis

- Should-trigger queries: [X]/[Y] passed
- Should-not-trigger queries: [X]/[Y] passed
- Common failures: [list common failure patterns]

## Output Quality Analysis

- Correctness: [X]/5
- Completeness: [X]/5
- Clarity: [X]/5
- Efficiency: [X]/5

## Issues Found

1. [Issue description]
   - Severity: [High/Medium/Low]
   - Frequency: [Always/Sometimes/Rarely]
   - Suggested fix: [recommendation]

## Improvements Made

1. [Change description]
   - Impact: [improvement observed]

## Next Steps

- [Priority 1 improvement]
- [Priority 2 improvement]
- [Additional test cases to add]
```

## 4. 最佳实践

### 4.1 评估频率

- **开发阶段**：每次重大修改后评估
- **稳定阶段**：每月或每季度定期评估
- **问题驱动**：收到用户反馈后立即评估

### 4.2 测试用例维护

- 随着技能演进而更新测试用例
- 添加新发现的边界情况
- 删除过时或不相关的用例
- 保持测试集的代表性和平衡性

### 4.3 避免常见陷阱

**过拟合评估集**：

- ✗ 针对特定测试查询优化描述
- ✓ 关注通用模式和原则

**忽略负样本**：

- ✗ 只测试应触发的场景
- ✓ 同样重视不应触发的场景

**单次评估定论**：

- ✗ 基于一次运行下结论
- ✓ 多次运行取平均值

**忽视上下文成本**：

- ✗ 只关注准确性
- ✓ 同时考虑效率和上下文使用

## 5. 评估检查清单

完成评估后，确认：

- [ ] 设计了平衡的评估查询集（应触发/不应触发）
- [ ] 进行了多次运行计算触发率
- [ ] 使用了训练/验证集划分
- [ ] 设计了多样化的测试用例集
- [ ] 定义了明确的评分标准
- [ ] 执行了手动或自动评估
- [ ] 记录了问题和改进项
- [ ] 创建了评估报告
- [ ] 制定了后续改进计划

## 6. 下一步

评估完成后：

1. **应用改进**：根据评估结果优化技能
2. **重新评估**：验证改进是否有效
3. **部署**：将稳定的技能部署到生产环境
4. **监控**：持续收集反馈，定期重新评估

记住：评估不是一次性活动，而是持续改进循环的关键部分。通过系统化的评估和迭代，你可以创建出高质量、可靠的技能。
