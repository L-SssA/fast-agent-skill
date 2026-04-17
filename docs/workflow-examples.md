# 完整工作流程教程

本教程通过实战案例展示如何使用 create-skill、enhance-skill 和 optimize-skill 创建、增强和优化高质量的 Agent Skills。

## 第一部分：技能概览

### 三个核心技能简介

#### create-skill：从零创建符合标准的技能框架

**功能**：帮助用户搭建技能的基础框架，确保符合官方标准。

**适用场景**：

- 需要新建技能时
- 学习 Agent Skills 规范
- 快速搭建基础结构

**核心能力**：

- 目录结构规范指导
- Frontmatter 字段详解
- 基础模板提供
- 命名规范验证

**详细文档**：[create-skill 使用指南](create-skill-usage.md)

---

#### enhance-skill：从外部资料增强技能内容

**功能**：从用户提供的各种资料（文档、代码、对话等）中提取有价值信息，并通过交互式确认智能整合到指定技能包中。

**适用场景**：

- 有新技术文档需要整合到现有技能
- 从项目经验中提取最佳实践
- 补充边界情况和注意事项
- 基于社区反馈改进技能

**核心能力**：

- 多类型资料处理（文档、代码、技术规范等）
- 智能信息提取和分类
- 交互式确认流程
- 智能整合策略（更新文件/创建新文件/优化结构）
- 技能能力分析和缺口识别

**典型工作流**：

1. 确认目标技能
2. 分析技能当前能力
3. 接收输入资料
4. 提取相关信息
5. 用户确认
6. 智能整合
7. 生成增强报告

---

#### optimize-skill：优化描述、提升质量、测试验证

**功能**：对现有技能进行系统化优化，提升触发率和输出质量。

**适用场景**：

- 技能触发率低
- 输出质量不稳定
- 需要应用最佳实践
- 需要系统化测试

**核心能力**：

- 描述优化（提升触发准确性）
- 最佳实践应用（Gotchas、模板、清单等）
- 评估测试（触发率、输出质量）
- 持续改进策略

**详细文档**：[optimize-skill 使用指南](optimize-skill-usage.md)

---

### 三者关系和典型工作流

```
┌─────────────────┐
│   需求分析       │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  create-skill   │ ← 创建基础框架
│  (一次)         │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ enhance-skill   │ ← 从外部资料增强
│  (按需多次)     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ optimize-skill  │ ← 描述优化
│  (多次迭代)     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ optimize-skill  │ ← 质量提升
│  (多次迭代)     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ optimize-skill  │ ← 测试验证
│  (定期执行)     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   部署使用       │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  收集反馈        │ ← 持续改进循环
└────────┬────────┘
         │
         ├────→ 返回 enhance-skill (添加新知识)
         └────→ 返回 optimize-skill (优化质量)
```

**关键要点**：

- create-skill 通常只使用一次（创建阶段）
- enhance-skill 按需使用（当有新的外部资料需要整合时）
- optimize-skill 会多次使用（优化、测试、迭代）
- 这是一个循环过程，不是一次性任务
- 三个技能协同工作，覆盖技能的完整生命周期

### 前置条件

#### 环境要求

- **代理环境**：支持 Agent Skills 的环境
- **文件系统访问**：能够创建和编辑文件
- **文本编辑器**：用于查看和修改生成的文件

#### 技能包安装确认

1. 克隆或下载 fast-agent-skill 仓库
2. 将 `skills/` 目录放置到代理可发现的目录中（如 `.agents/skills/`）
3. 启动代理会话，使用 `/skills` 命令确认看到：
   - `create-skill`
   - `enhance-skill`
   - `optimize-skill`

如果技能未出现，检查：

- 目录路径是否正确
- SKILL.md 文件格式是否正确
- 代理是否重新加载了技能列表

---

## 第二部分：实战案例

### 案例 1：从零创建 CSV 数据分析技能（完整流程）

#### 场景描述

**背景**：您是一名数据分析师，经常需要处理销售数据 CSV 文件，包括：

- 计算汇总统计（总额、平均值、最大值等）
- 添加衍生列（如利润率、同比增长等）
- 生成可视化图表
- 清理脏数据（缺失值、异常值）

**目标**：创建一个专门的技能，让代理能够高效地处理这些任务。

---

#### 阶段 1：使用 create-skill 创建基础框架

**步骤 1.1：向智能体提出需求**

```markdown
用户: "我想创建一个处理 CSV 数据的技能，主要用于销售数据分析"

智能体自动激活 create-skill 技能，开始引导：

"好的，我来帮您创建 CSV 数据分析技能。首先确认一些细节：

1. 主要功能：
   - 计算汇总统计？
   - 添加衍生列？
   - 生成图表？
   - 数据清洗？

2. 输入格式：
   - 仅 CSV 还是也包括 Excel、TSV？
   - 文件大小范围？

3. 输出要求：
   - 统计报告格式？
   - 图表类型偏好？
   - 是否需要保存结果？"
```

**步骤 1.2：确认需求细节**

```markdown
用户:
"1. 主要功能都要，特别是统计和图表 2. 主要是 CSV，偶尔有 Excel 3. 输出要清晰的结构化报告，图表保存为 PNG 4. 文件大小一般不超过 10MB"

智能体:
"明白了。我将创建一个名为 csv-data-analysis 的技能。
现在开始搭建基础框架..."
```

**步骤 1.3：智能体加载参考文档并指导创建**

智能体会加载 [framework.md](../skills/create-skill/references/framework.md)，然后：

**创建目录结构**：

```
csv-data-analysis/
├── SKILL.md
├── scripts/
│   └── analyze.py          # Python 分析脚本
├── references/
│   └── advanced-stats.md   # 高级统计方法参考
└── assets/
    └── report-template.md  # 报告模板
```

**编写 frontmatter**：

```yaml
---
name: csv-data-analysis
description: Analyze CSV and tabular data files, compute summary statistics, add derived columns, generate charts, and clean messy data. Use when the user has a CSV, TSV, or Excel file and wants to explore, transform, or visualize the data.
license: MIT
metadata:
  author: your-name
  version: "1.0"
---
```

**编写基础 body 内容**：

````markdown
# CSV Data Analysis Skill

## 使用前准备

确保已安装以下依赖：

- Python 3.8+
- pandas
- matplotlib
- openpyxl (用于 Excel 文件)

安装命令：

```bash
pip install pandas matplotlib openpyxl
```
````

## 使用步骤

1. **加载数据**
   - 读取 CSV/Excel 文件
   - 检查数据结构（列名、数据类型、行数）
   - 识别缺失值和异常值

2. **数据清洗**
   - 处理缺失值（删除或填充）
   - 修正数据类型
   - 去除重复行

3. **计算统计**
   - 基本统计：均值、中位数、标准差
   - 分组统计：按类别聚合
   - 时间序列统计：趋势分析

4. **生成图表**
   - 选择合适的图表类型
   - 设置标题、标签、图例
   - 保存为 PNG 文件

5. **生成报告**
   - 使用 report-template.md 格式
   - 包含关键发现和洞察
   - 附上图表引用

## 示例

### 输入

"分析 sales_2024.csv，计算每月销售额，生成趋势图"

### 输出

- 月度销售统计表
- 销售趋势折线图 (sales_trend.png)
- 关键发现总结

## 注意事项

- 大文件（>10MB）可能需要分批处理
- 日期格式可能不一致，需要统一
- 缺失值处理需要根据业务逻辑决定

## 相关文件

- [高级统计方法](references/advanced-stats.md)
- [报告模板](assets/report-template.md)
- [分析脚本](scripts/analyze.py)

````

**步骤 1.4：初步验证**

智能体会提醒您检查：

```markdown
✓ 目录名 csv-data-analysis 与 name 字段一致
✓ name 符合命名规范（小写、连字符、长度合适）
✓ description 包含"做什么"和"何时使用"
✓ SKILL.md 行数 < 500（使用了渐进式披露）
✓ 提供了清晰的步骤和示例
✓ 文件引用使用相对路径

基础框架创建完成！

下一步建议：
1. 使用 optimize-skill 优化 description 以提高触发率
2. 添加更多实际案例和边界情况
3. 进行测试验证
````

---

#### 阶段 2：使用 optimize-skill 优化描述

**问题识别**：虽然基础框架已建立，但 description 可能不够精确，导致：

- 相关查询没有触发技能
- 或者在不相关场景误触发

**步骤 2.1：启动优化流程**

```markdown
用户: "我刚用 create-skill 创建了 csv-data-analysis 技能，想优化一下 description"

智能体自动激活 optimize-skill：

"好的，我们来优化 description。首先了解当前状况：

1. 当前的 description 是什么？
2. 有没有遇到触发问题？（很少激活或误触发）
3. 有哪些典型的使用场景？"
```

**步骤 2.2：设计评估查询集**

智能体会加载 [description-optimization.md](../skills/optimize-skill/references/description-optimization.md)，帮助设计测试查询：

**应触发的查询（10 个）**：

```
1. "分析这个 CSV 文件的数据"
2. "帮我看看 sales.csv 的销售趋势"
3. "计算每个月的平均销售额"
4. "can u help me look at this spreadsheet?"
5. "i got a csv file w/ revenue numbers, need stats"
6. "Load the data, clean missing values, and create a line chart"
7. "My boss wants a chart from this data file"
8. "Generate summary statistics for the dataset"
9. "Add a profit margin column to this table"
10. "Visualize the quarterly performance data"
```

**不应触发的查询（10 个）**：

```
1. "帮我写一个 Python 爬虫"
2. "解释什么是机器学习"
3. "创建一个网站页面"
4. "翻译这段文字成英文"
5. "设计一个数据库 schema"
6. "编写单元测试代码"
7. "配置 Docker 容器"
8. "优化 SQL 查询性能"
9. "设置 CI/CD 流水线"
10. "绘制系统架构图"
```

**步骤 2.3：执行优化循环**

**第 1 轮：初始测试**

当前 description：

```yaml
description: Analyze CSV and tabular data files, compute summary statistics, add derived columns, generate charts, and clean messy data. Use when the user has a CSV, TSV, or Excel file and wants to explore, transform, or visualize the data.
```

测试结果（模拟）：

- 应触发查询：7/10 触发（失败：4, 5, 9）
- 不应触发查询：10/10 正确不触发

**识别问题**：

- 查询 4、5（随意表达）未触发 → 需要扩大措辞范围
- 查询 9（"profit margin column"）未触发 → 缺少"derived columns"的关键词

**修订 description**：

```yaml
description: >
  Analyze CSV and tabular data files — compute summary statistics,
  add derived columns (like profit margin, growth rate), generate
  charts, and clean messy data. Use this skill when the user has a
  CSV, TSV, or Excel file and wants to explore, transform, or
  visualize the data, even if they don't explicitly mention "CSV" or
  "analysis." Also use for spreadsheets, data files, or when asked
  to calculate metrics from tabular data.
```

**第 2 轮：再次测试**

测试结果：

- 应触发查询：9/10 触发（失败：7）
- 不应触发查询：10/10 正确不触发

**识别问题**：

- 查询 7（"chart from this data file"）仍未触发 → 需要更明确提及"chart"和"data file"

**再次修订**：

```yaml
description: >
  Analyze CSV and tabular data files — compute summary statistics,
  add derived columns (like profit margin, growth rate), generate
  charts and visualizations, and clean messy data. Use this skill
  when the user has a CSV, TSV, Excel file, spreadsheet, or any
  tabular data file and wants to explore, transform, visualize, or
  calculate metrics from the data. Also use when asked to create
  charts, graphs, or reports from data files, even if they don't
  explicitly mention "CSV," "analysis," or specific file formats.
```

**第 3 轮：最终测试**

测试结果：

- 应触发查询：10/10 触发 ✓
- 不应触发查询：10/10 正确不触发 ✓

**优化完成！**

**优化前后对比**：

| 指标               | 优化前 | 优化后 | 改进   |
| ------------------ | ------ | ------ | ------ |
| 应触发查询成功率   | 70%    | 100%   | +30%   |
| 不应触发查询准确率 | 100%   | 100%   | 保持   |
| 描述长度           | 较短   | 适中   | 更全面 |
| 关键词覆盖         | 基础   | 丰富   | 更好   |

---

#### 阶段 3：使用 optimize-skill 提升质量

**步骤 3.1：应用最佳实践**

```markdown
用户: "description 已经优化好了，现在想提升整体质量"

智能体加载 best-practices.md：

"好的，我们来应用最佳实践提升质量。让我检查当前 SKILL.md：

发现的问题：

1. 缺少 Gotchas 章节（边界情况和陷阱）
2. 没有提供输出格式模板
3. 指令可以更具体（提供默认方案）
4. 可以添加验证循环确保质量

我们逐一改进..."
```

**改进 1：添加 Gotchas 章节**

```markdown
## Gotchas（重要注意事项）

- **日期格式不一致**：CSV 中的日期可能是 "2024-01-01"、"01/01/2024" 或 "Jan 1, 2024"，需要先统一格式
- **编码问题**：中文 CSV 可能是 UTF-8 或 GBK 编码，读取失败时尝试不同编码
- **大内存占用**：超过 10MB 的文件建议使用 chunked 读取或 Dask
- **缺失值含义**：空值可能是 "未知"、"不适用" 或 "0"，需要根据业务逻辑判断
- **图表颜色**：避免使用红绿色搭配（色盲友好），推荐使用蓝色系
```

**改进 2：提供输出格式模板**

在 `assets/report-template.md` 中：

```markdown
# 数据分析报告

## 数据概览

- 文件名：{filename}
- 行数：{row_count}
- 列数：{column_count}
- 时间范围：{date_range}

## 关键统计

| 指标   | 值      |
| ------ | ------- |
| 总额   | {total} |
| 平均值 | {mean}  |
| 最大值 | {max}   |
| 最小值 | {min}   |

## 主要发现

1. {finding_1}
2. {finding_2}
3. {finding_3}

## 图表

![趋势图](charts/trend.png)
![分布图](charts/distribution.png)

## 建议

- {recommendation_1}
- {recommendation_2}
```

**改进 3：添加验证循环**

````markdown
## 验证步骤

在完成分析后，执行以下验证：

1. **数据完整性检查**
   ```python
   print(f"原始行数: {len(original_df)}")
   print(f"处理后行数: {len(processed_df)}")
   print(f"缺失值数量: {processed_df.isnull().sum().sum()}")
   ```
````

2. **统计合理性检查**
   - 平均值是否在合理范围内？
   - 是否有异常极值？
   - 分组统计总和是否等于总体？

3. **图表质量检查**
   - 标题是否清晰？
   - 坐标轴标签是否完整？
   - 图例是否正确？
   - 文件是否成功保存？

4. **报告完整性检查**
   - 所有必需章节都已填写？
   - 图表引用是否正确？
   - 数字格式是否一致？

````

**改进 4：提供默认方案**

```markdown
## 推荐工具和方法

**默认方案**（适用于大多数情况）：
- 数据读取：`pandas.read_csv()`
- 数据清洗：`dropna()` 或 `fillna(0)`
- 统计分析：`describe()` + `groupby()`
- 图表生成：`matplotlib.pyplot`
- 报告格式：使用 assets/report-template.md

**替代方案**（特殊情况）：
- 大文件：使用 `dask` 或分块读取
- 复杂图表：使用 `seaborn` 或 `plotly`
- Excel 文件：使用 `openpyxl` 引擎
````

---

#### 阶段 4：使用 optimize-skill 测试验证

**步骤 4.1：触发率评估**

```markdown
用户: "现在想测试一下技能的实际表现"

智能体加载 evaluation-testing.md：

"好的，我们进行系统化测试。首先进行触发率评估：

准备测试查询集（使用之前设计的 20 个查询）：

- 10 个应触发
- 10 个不应触发

建议运行 5-10 次以获得稳定结果。"
```

**执行测试**（可以使用提供的脚本模板）：

```bash
# 复制评估脚本模板
cp ../skills/optimize-skill/assets/eval-script-template.sh eval-csv-skill.sh

# 编辑脚本，填入测试查询
# 运行评估
bash eval-csv-skill.sh
```

**测试结果示例**：

```
=== 触发率评估报告 ===

测试次数：10
应触发查询：10
不应触发查询：10

结果：
- 应触发查询成功率：100% (10/10)
- 不应触发查询准确率：100% (10/10)
- 总体准确率：100%

评价：优秀 ✓
```

**步骤 4.2：输出质量评估**

设计测试用例：

**测试用例 1：基本统计分析**

```
输入："分析 sales_2024.csv，给出基本统计"
期望输出：
  ✓ 包含行数、列数
  ✓ 包含均值、中位数、标准差
  ✓ 格式清晰易读

评分：9/10（缺少最大值和最小值）
```

**测试用例 2：生成图表**

```
输入："创建月度销售趋势图"
期望输出：
  ✓ 生成 PNG 文件
  ✓ 标题清晰
  ✓ 坐标轴有标签
  ✓ 图表保存到正确位置

评分：10/10
```

**测试用例 3：数据清洗**

```
输入："清理 data.csv 中的缺失值"
期望输出：
  ✓ 说明处理方法
  ✓ 显示处理前后对比
  ✓ 保留原始数据备份

评分：8/10（未提醒备份原始数据）
```

**综合评分**：9/10

**步骤 4.3：生成评估报告**

```markdown
# CSV Data Analysis Skill 评估报告

## 概述

- 技能名称：csv-data-analysis
- 评估日期：2024-01-15
- 评估者：optimize-skill

## 触发率评估

- 测试次数：10
- 应触发成功率：100%
- 不应触发准确率：100%
- **评级：优秀** ✓

## 输出质量评估

- 测试用例数：3
- 平均评分：9/10
- **评级：良好** ✓

## 优点

1. 触发率极高，描述准确
2. 输出格式规范，易于理解
3. 包含验证循环，质量保证好
4. Gotchas 章节实用

## 改进建议

1. 基本统计中添加最大值和最小值
2. 数据清洗时提醒备份原始数据
3. 增加更多图表类型示例

## 结论

技能质量优秀，可以部署使用。建议根据改进建议在下一版本中优化。
```

---

#### 案例 1 总结

通过这个完整案例，我们展示了：

1. **使用 create-skill 创建基础框架**（阶段 1）
   - 需求分析和确认
   - 目录结构搭建
   - Frontmatter 编写
   - 基础指令编写

2. **使用 optimize-skill 优化描述**（阶段 2）
   - 设计评估查询集
   - 执行 3 轮优化循环
   - 触发率从 70% 提升到 100%

3. **使用 optimize-skill 提升质量**（阶段 3）
   - 添加 Gotchas 章节
   - 提供输出模板
   - 添加验证循环
   - 提供默认方案

4. **使用 optimize-skill 测试验证**（阶段 4）
   - 触发率评估：100%
   - 输出质量评分：9/10
   - 生成综合评估报告

**总耗时**：约 2-3 小时（含多次迭代）

**最终成果**：一个高质量、经过验证的 CSV 数据分析技能

---

### 案例 2：优化现有的 PDF 处理技能（仅使用 optimize-skill）

#### 场景描述

**背景**：您已经有一个基础的 PDF 处理技能 `pdf-processor`，但存在以下问题：

- 技能很少被激活（触发率低）
- 有时能正确提取文本，有时会遗漏内容（输出不稳定）
- 不知道如何处理扫描版 PDF

**目标**：使用 optimize-skill 优化现有技能，解决上述问题。

**当前技能状态**：

```
pdf-processor/
└── SKILL.md (150 行)
```

当前 description：

```yaml
description: Process PDF files and extract text.
```

---

#### 问题诊断

```markdown
用户: "我的 pdf-processor 技能效果不好，触发率低，输出也不稳定"

智能体激活 optimize-skill：

"我来帮您诊断问题。首先看看当前状况：

1. 当前的 description 是什么？
2. 典型的失败案例有哪些？
3. 用户通常如何请求 PDF 相关任务？"

用户:
"description 很简单：'Process PDF files and extract text.'
失败案例：

- 用户说'从这个 PDF 里提取文字'，技能没激活
- 扫描版 PDF 完全无法处理
- 有时提取的文本格式混乱"

智能体:
"问题很明确：

1. Description 过于简单，缺少关键词和使用场景
2. 没有处理扫描版 PDF 的说明
3. 缺少输出格式规范

我们分两步优化：

- 先优化 description 提升触发率
- 再应用最佳实践提升输出质量"
```

---

#### 优化过程

**步骤 1：描述优化**

加载 [description-optimization.md](../skills/optimize-skill/references/description-optimization.md)

**设计评估查询集**：

应触发查询：

```
1. "从这个 PDF 里提取文字"
2. "Extract text from document.pdf"
3. "帮我把 PDF 转成文本"
4. "Read the content of this PDF file"
5. "我需要 PDF 里的表格数据"
6. "Convert PDF to text format"
7. "Scan this PDF and get the text"
8. "Pull out all text from the document"
```

不应触发查询：

```
1. "帮我创建一个 PDF 文件"
2. "压缩这个 PDF"
3. "合并多个 PDF"
4. "给 PDF 添加密码"
```

**执行优化循环**：

**第 1 轮**：

```yaml
# 原始 description
description: Process PDF files and extract text.

# 测试结果：3/8 应触发查询成功（37.5%）

# 问题分析：
# - 缺少"extract"、"text"的同义词
# - 没有说明使用场景
# - 过于简短

# 修订后
description: Extract text and tables from PDF files. Use when working with PDF documents or when the user mentions PDFs, document extraction, or converting PDFs to text.
```

**第 2 轮**：

```yaml
# 测试结果：6/8 应触发查询成功（75%）

# 问题分析：
# - 查询 5（"表格数据"）未触发 → 已包含"tables"，可能是其他原因
# - 查询 7（"Scan"）未触发 → 需要提及扫描版

# 再次修订
description: >
  Extract text and tables from PDF files, including scanned documents
  using OCR. Use when working with PDF documents, extracting content
  from PDFs, converting PDFs to text, or when the user mentions PDFs,
  document extraction, reading PDFs, or scanning PDF files.
```

**第 3 轮**：

```yaml
# 测试结果：8/8 应触发查询成功（100%）✓
# 不应触发查询：4/4 正确不触发 ✓

# 优化完成！
```

**优化效果**：

- 触发率：37.5% → 100% (+62.5%)
- 描述长度：38 字符 → 245 字符（仍在 1024 限制内）

---

**步骤 2：应用最佳实践提升输出质量**

加载 [best-practices.md](../skills/optimize-skill/references/best-practices.md)

**问题 1：扫描版 PDF 无法处理**

添加 Gotchas 章节：

```markdown
## Gotchas

- **扫描版 PDF**：是图片而非文本，需要使用 OCR（光学字符识别）
  - 推荐工具：`pdf2image` + `pytesseract`
  - 安装：`pip install pdf2image pytesseract`
  - 注意：需要系统安装 Tesseract OCR 引擎

- **加密 PDF**：需要密码才能读取
  - 提示用户提供密码
  - 使用 `pikepdf` 库解密

- **复杂布局**：多栏、表格、图片混合
  - 提取顺序可能错乱
  - 建议使用 `pdfplumber` 而非 `PyPDF2`

- **字体嵌入问题**：某些特殊字符可能显示为方框
  - 尝试不同编码（UTF-8, Latin-1）
  - 记录无法识别的字符
```

**问题 2：输出格式混乱**

提供输出模板：

```markdown
## 输出格式规范

提取的文本应按以下格式组织：
```

# [PDF 文件名]

## 元数据

- 页数：{page_count}
- 作者：{author}
- 创建日期：{creation_date}

## 提取内容

### 第 1 页

{page_1_text}

### 第 2 页

{page_2_text}

...

## 提取统计

- 总字符数：{char_count}
- 总字数：{word_count}
- 识别置信度：{confidence}%（OCR 时）

## 注意事项

- {warnings}

```

```

**问题 3：缺少验证步骤**

添加验证循环：

````markdown
## 验证步骤

提取完成后，执行以下验证：

1. **完整性检查**
   ```python
   print(f"总页数: {total_pages}")
   print(f"已提取页数: {extracted_pages}")
   assert total_pages == extracted_pages, "页数不匹配！"
   ```
````

2. **质量检查**
   - 是否有大量空白页？
   - 是否有乱码或方框字符？
   - 文本长度是否合理？

3. **OCR 置信度检查**（扫描版）

   ```python
   if confidence < 80:
       print("警告：OCR 置信度较低，可能需要人工校对")
   ```

4. **文件格式检查**
   - 输出文件是否成功保存？
   - 编码是否正确（UTF-8）？

````

**问题 4：没有提供默认方案**

添加推荐工具：
```markdown
## 推荐工具和方法

**默认方案**（适用于大多数 PDF）：
```python
import pdfplumber

with pdfplumber.open("document.pdf") as pdf:
    text = ""
    for page in pdf.pages:
        text += page.extract_text()
````

**扫描版 PDF**：

```python
from pdf2image import convert_from_path
import pytesseract

images = convert_from_path("scanned.pdf")
text = ""
for image in images:
    text += pytesseract.image_to_string(image, lang='chi_sim+eng')
```

**工具选择指南**：

- 普通文本 PDF：`pdfplumber`（首选）或 `PyPDF2`
- 扫描版 PDF：`pdf2image` + `pytesseract`
- 需要保留格式：`pdfminer.six`
- 需要提取表格：`pdfplumber`（内置表格检测）

```

---

**步骤 3：系统化测试验证**

加载 [evaluation-testing.md](../skills/optimize-skill/references/evaluation-testing.md)

**触发率测试**：
```

=== 触发率评估报告 ===

测试次数：10
应触发查询：8
不应触发查询：4

结果：

- 应触发查询成功率：100% (8/8)
- 不应触发查询准确率：100% (4/4)
- 总体准确率：100%

评价：优秀 ✓

对比优化前：

- 优化前：37.5%
- 优化后：100%
- 提升：+62.5%

```

**输出质量测试**：

测试用例 1：普通文本 PDF
```

输入："提取 report.pdf 的文字"
期望：
✓ 成功提取所有页面
✓ 格式清晰
✓ 包含元数据

评分：9/10

```

测试用例 2：扫描版 PDF
```

输入："从这个扫描件 PDF 中提取文字"
期望：
✓ 使用 OCR 处理
✓ 显示置信度
✓ 提醒可能需人工校对

评分：10/10

```

测试用例 3：加密 PDF
```

输入："打开 password.pdf"
期望：
✓ 提示需要密码
✓ 说明如何提供密码

评分：8/10（可以更友好地引导）

````

**综合评分**：9/10

---

#### 对比展示：优化前后的差异

| 维度 | 优化前 | 优化后 | 改进 |
|------|--------|--------|------|
| **Description 长度** | 38 字符 | 245 字符 | 更详细 |
| **触发率** | 37.5% | 100% | +62.5% |
| **扫描版支持** | ✗ 不支持 | ✓ OCR 支持 | 新功能 |
| **输出格式** | 无规范 | 有模板 | 更统一 |
| **验证步骤** | 无 | 有 4 步验证 | 更可靠 |
| **Gotchas** | 无 | 4 条注意事项 | 更健壮 |
| **输出质量评分** | ~6/10 | 9/10 | +50% |

**用户反馈**：
> "优化后的技能好用多了！以前经常不响应，现在一提到 PDF 就能激活。而且扫描版也能处理了，输出格式也很整齐。"

---

#### 案例 2 总结

通过这个案例，我们展示了：

1. **问题诊断**：识别触发率低和输出不稳定的根本原因
2. **描述优化**：3 轮迭代，触发率从 37.5% 提升到 100%
3. **质量提升**：应用最佳实践，添加 Gotchas、模板、验证循环
4. **测试验证**：系统化评估，量化改进效果

**关键点**：
- 即使已有技能，也可以大幅优化
- 描述优化是最快见效的改进
- 最佳实践应用能显著提升输出质量
- 测试验证帮助量化改进效果

**总耗时**：约 1-2 小时

---

### 案例 3：使用 enhance-skill 增强现有技能（从文档提取知识）

#### 场景描述

**背景**：您已经有一个 `python-async` 技能，用于指导异步编程。最近 Python 发布了 3.12 版本，带来了一些新的异步特性和最佳实践。您找到了一份详细的技术博客文章，想要将这些新知识整合到现有技能中。

**目标**：使用 enhance-skill 从技术文档中提取有价值的信息，并智能整合到 `python-async` 技能中。

**输入资料**：一篇关于 "Python 3.12 异步编程新特性" 的技术博客（约 3000 字）

---

#### 阶段 1：确认目标技能和接收资料

**步骤 1.1：向智能体提出需求**

```markdown
用户: "我有一份 Python 3.12 异步编程新特性的技术博客，想用来增强我的 python-async 技能"

智能体自动激活 enhance-skill 技能，开始引导：

"好的，我来帮您增强 python-async 技能。首先让我分析一下当前技能的状态。"
````

**步骤 1.2：分析当前技能**

智能体读取 `skills/python-async/SKILL.md` 和相关 references：

```markdown
智能体: "我已经分析了 python-async 技能的当前状态：

当前能力：

- async/await 基础语法
- asyncio.create_task() 使用
- 基本的异常处理
- 简单的并发控制

现有文件：

- SKILL.md (180 行)
- references/basics.md (120 行)
- references/task-management.md (150 行)
- references/error-handling.md (100 行)

请提供您的技术博客内容，我将从中提取与 python-async 相关的有价值信息。"
```

**步骤 1.3：提供输入资料**

```markdown
用户: [粘贴技术博客内容]

博客标题：Python 3.12 异步编程新特性与最佳实践

主要内容：

1. ExceptionGroup 和 except\* 语法
2. TaskGroup 上下文管理器
3. 改进的错误消息和调试
4. 性能优化技巧
5. 常见陷阱和解决方案
   ...
```

---

#### 阶段 2：智能提取信息

**步骤 2.1：加载提取指南**

智能体加载 `references/extraction-guide.md`，开始分析资料。

**步骤 2.2：提取相关信息**

智能体分析博客内容，提取以下信息：

```markdown
智能体: "我从博客中提取了以下有价值的信息：

## 新增知识 (New Knowledge)

[NK-001] ExceptionGroup 和 except\* 语法

- 相关性评分: 5/5
- 内容: Python 3.11+ 引入的新特性，用于同时处理多个异常
- 示例代码: 完整的异常组处理示例
- 建议整合位置: 创建 references/exception-groups.md

[NK-002] TaskGroup 上下文管理器

- 相关性评分: 5/5
- 内容: Python 3.11+ 的 taskgroup，简化任务管理
- 示例代码: TaskGroup 使用示例
- 建议整合位置: 更新 references/task-management.md

## 最佳实践 (Best Practices)

[BP-001] 异步函数命名约定

- 相关性评分: 4/5
- 内容: async 函数应以 \_async 后缀命名，提高可读性
- 建议整合位置: 更新 references/basics.md

[BP-002] 超时配置推荐值

- 相关性评分: 4/5
- 内容: 连接超时 5s，读取超时 30s，基于实际测试
- 建议整合位置: 创建 references/timeout-config.md

## 边界情况 (Edge Cases)

[EC-001] 嵌套事件循环问题

- 相关性评分: 5/5
- 内容: 在已运行的事件循环中调用 asyncio.run() 会导致错误
- 解决方案: 使用 await 或 create_task()
- 建议整合位置: 添加到 Gotchas 章节

## 注意事项 (Gotchas)

[GC-001] asyncio.sleep(0) 的误用

- 相关性评分: 4/5
- 内容: asyncio.sleep(0) 不会立即执行，只是让出控制权
- 建议整合位置: 添加到 Gotchas 章节

总计提取 7 条高价值信息。

您希望查看每条信息的详细内容吗？或者我可以直接展示整合方案？"
```

**步骤 2.3：用户确认**

```markdown
用户: "请展示整合方案"

智能体: "好的，让我制定整合方案..."
```

---

#### 阶段 3：制定整合方案

**步骤 3.1：加载整合策略**

智能体加载 `references/integration-strategies.md`，制定整合方案。

**步骤 3.2：展示整合方案**

```markdown
智能体: "## 整合方案

基于提取的信息，建议进行以下增强：

### 1. 创建新文件

- `references/exception-groups.md` (约 100 行)
  - 包含 NK-001: ExceptionGroup 完整说明
  - 包含示例代码和最佳实践
- `references/timeout-config.md` (约 60 行)
  - 包含 BP-002: 超时配置推荐值
  - 不同场景的配置建议

### 2. 更新现有文件

- `references/task-management.md`
  - 添加 TaskGroup 章节 (约 50 行)
  - 更新任务管理最佳实践
- `references/basics.md`
  - 添加命名约定章节 (约 30 行)
- `SKILL.md` 的 Gotchas 章节
  - 添加 EC-001: 嵌套事件循环问题 (约 15 行)
  - 添加 GC-001: asyncio.sleep(0) 误用 (约 10 行)

### 3. 更新 SKILL.md 引用

- 在\"何时加载详细指南\"章节添加：
  - 异常组处理 → references/exception-groups.md
  - 超时配置 → references/timeout-config.md
- 预计增加 10 行

### 统计数据

- 新增文件: 2 个
- 更新文件: 3 个
- 新增行数: 约 265 行
- SKILL.md 变化: 180 行 → 205 行 (仍在 500 行限制内)

是否执行此方案？"
```

**步骤 3.3：用户确认执行**

```markdown
用户: "方案很好，执行吧"

智能体: "好的，开始执行整合..."
```

---

#### 阶段 4：执行整合

**步骤 4.1：创建新文件**

智能体创建 `references/exception-groups.md`：

````markdown
# 异常组处理 (Exception Groups)

Python 3.11+ 引入了 ExceptionGroup 和 except\* 语法，用于同时处理多个异常。

## 基本用法

```python
try:
    async with asyncio.TaskGroup() as tg:
        tg.create_task(task1())
        tg.create_task(task2())
except* ValueError as eg:
    for exc in eg.exceptions:
        print(f"ValueError: {exc}")
except* TypeError as eg:
    for exc in eg.exceptions:
        print(f"TypeError: {exc}")
```
````

## 最佳实践

1. **使用 except\* 而非 except**：处理 TaskGroup 中的异常时必须使用 except\*
2. **分别处理不同类型**：可以为不同类型的异常设置不同的 except\* 块
3. **记录所有异常**：即使只关心某类异常，也要记录其他异常以便调试

## 示例：并行请求错误处理

[完整示例代码...]

## 参考资料

- [PEP 654](https://peps.python.org/pep-0654/)
- [Python 官方文档](https://docs.python.org/3/library/asyncio-task.html#task-groups)

````

智能体创建 `references/timeout-config.md`：

```markdown
# 超时配置指南

合理的超时配置对于异步应用的稳定性至关重要。

## 推荐配置

| 场景 | 连接超时 | 读取超时 | 写入超时 |
|------|---------|---------|----------|
| API 调用 | 5s | 30s | 30s |
| 数据库查询 | 3s | 10s | 10s |
| 文件操作 | 2s | 60s | 60s |

## 实现示例

```python
import asyncio

async def fetch_with_timeout(url, timeout=30):
    try:
        async with asyncio.wait_for(fetch_data(url), timeout=timeout):
            return result
    except asyncio.TimeoutError:
        logger.warning(f"Request to {url} timed out after {timeout}s")
        raise
````

## 注意事项

- 超时时间应根据实际网络环境和业务需求调整
- 生产环境建议通过配置文件管理超时值
- 考虑添加重试机制配合超时使用

````

**步骤 4.2：更新现有文件**

智能体更新 `references/task-management.md`，添加 TaskGroup 章节。

智能体更新 `references/basics.md`，添加命名约定章节。

智能体更新 `SKILL.md` 的 Gotchas 章节，添加两个新的注意事项。

**步骤 4.3：更新 SKILL.md 引用**

```markdown
## 何时加载详细指南

- **基础语法** → 读取 [`references/basics.md`](references/basics.md)
  - 包含 async/await 语法、协程定义等基础知识

- **任务管理** → 读取 [`references/task-management.md`](references/task-management.md)
  - 包含 create_task、gather、TaskGroup 等任务管理方法

- **异常处理** → 读取 [`references/error-handling.md`](references/error-handling.md)
  - 包含异常捕获、错误传播等

- **异常组处理** → 读取 [`references/exception-groups.md`](references/exception-groups.md)  [NEW]
  - 包含 ExceptionGroup、except* 语法、TaskGroup 异常处理

- **超时配置** → 读取 [`references/timeout-config.md`](references/timeout-config.md)  [NEW]
  - 包含推荐配置、实现示例、注意事项
````

---

#### 阶段 5：生成增强报告

智能体使用 `assets/enhancement-template.md` 生成增强报告：

```markdown
智能体: "## 增强完成！

### 变更摘要

**新增内容**:

- `references/exception-groups.md` (100 行) - ExceptionGroup 完整指南
- `references/timeout-config.md` (60 行) - 超时配置推荐

**更新内容**:

- `references/task-management.md` (+50 行) - 添加 TaskGroup 章节
- `references/basics.md` (+30 行) - 添加命名约定
- `SKILL.md` (+25 行) - 添加 Gotchas 和引用

**统计数据**:

- 新增文件: 2 个
- 更新文件: 3 个
- 总新增行数: 265 行
- SKILL.md: 180 行 → 205 行

### 增强亮点

✓ 添加了 Python 3.11+ 的最新特性支持
✓ 补充了重要的边界情况和注意事项
✓ 提供了实用的配置推荐值
✓ 保持了渐进式披露原则
✓ 所有内容都经过您的确认

### 后续建议

1. **测试验证**: 建议使用 optimize-skill 测试技能的触发率
2. **示例验证**: 运行新增的代码示例，确保可以正常执行
3. **收集反馈**: 从实际使用中收集用户反馈，持续改进

增强报告已保存到 `enhance-report-2026-04-17.md`。

需要我帮您执行其他操作吗？"
```

---

#### 案例 3 总结

通过这个案例，我们展示了：

1. **智能提取**：从技术文档中自动识别和提取有价值信息
2. **交互式确认**：向用户清晰展示提取的内容并获得确认
3. **智能整合**：根据信息类型选择最佳的整合方式
4. **保持质量**：遵循渐进式披露，保持技能结构清晰

**关键点**：

- enhance-skill 不是简单追加，而是智能整合
- 交互式确认确保只添加用户认可的内容
- 自动化分析节省大量人工整理时间
- 与 create-skill 和 optimize-skill 形成完整工作流

**总耗时**：约 30-45 分钟（相比人工整理节省 70% 时间）

**用户反馈**：

> "太方便了！以前我要花几个小时阅读文档、整理笔记、手动更新技能。现在 enhance-skill 自动帮我完成了大部分工作，我只需要确认一下就行。而且整合的质量很高，结构很清晰。"

---

## 第三部分：工作流总结

### 典型工作流程

```
需求分析
↓
create-skill（创建基础框架）
↓
enhance-skill（从外部资料增强）←┐
↓ │
optimize-skill（描述优化）←┤ 多次迭代
↓ │
optimize-skill（质量提升）←┘
↓
optimize-skill（测试验证）
↓
部署使用
↓
收集反馈
↓
├→ enhance-skill（添加新知识）
└→ optimize-skill（优化质量）

```

### 不同场景的工作流变体

#### 场景 A：从零创建新技能

**完整流程**：

```

1. 需求分析（明确目标和范围）
2. create-skill（搭建基础框架）
3. enhance-skill（从外部资料增强，可选）
4. optimize-skill（描述优化，3-5 轮）
5. optimize-skill（质量提升，应用最佳实践）
6. optimize-skill（测试验证）
7. 部署使用
8. 收集反馈，持续优化

```

**预计时间**：

- 简单技能：30-60 分钟
- 中等复杂度：2-4 小时
- 复杂技能：1-2 天

---

#### 场景 B：优化现有技能

**简化流程**：

```

1. 问题诊断（识别具体问题）
2. optimize-skill（针对性优化）
   - 触发率低 → 描述优化
   - 输出不稳 → 最佳实践
   - 需要验证 → 测试评估
3. 测试验证
4. 部署更新

```

**预计时间**：

- 简单优化：30 分钟 - 1 小时
- 全面优化：2-3 小时

---

#### 场景 B+：增强现有技能（从外部资料）

**增强流程**：

```

1. 确认目标技能和输入资料
2. enhance-skill（分析技能能力）
3. enhance-skill（提取相关信息）
4. 用户确认提取的内容
5. enhance-skill（智能整合）
6. 生成增强报告
7. （可选）optimize-skill 测试验证

```

**预计时间**：

- 简单增强：20-40 分钟
- 复杂增强：1-2 小时
- 相比人工整理节省 70% 时间

---

#### 场景 C：批量优化多个技能

**并行策略**：

```

1. 评估所有技能的现状
2. 按优先级排序（触发率最低的优先）
3. 批量执行描述优化
4. 批量应用最佳实践
5. 统一测试验证
6. 批量部署

```

**技巧**：

- 使用脚本自动化重复步骤
- 建立标准化的评估流程
- 维护共享的测试用例库

---

### 时间估算

| 技能复杂度               | create-skill | optimize-skill | 总计       |
| ------------------------ | ------------ | -------------- | ---------- |
| **简单**（单一功能）     | 15-30 分钟   | 30-60 分钟     | 30-60 分钟 |
| **中等**（多步骤工作流） | 30-60 分钟   | 1-3 小时       | 2-4 小时   |
| **复杂**（多模块、脚本） | 1-2 小时     | 3-6 小时       | 1-2 天     |

**注意**：

- 首次使用可能需要更多时间学习
- 熟练后可以显著加快速度
- 优化是迭代过程，可以分多次完成

---

### 最佳实践总结

#### 1. 命名规范要点

- 使用小写字母、数字、连字符
- 长度 1-64 字符
- 不能以连字符开头或结尾
- 目录名与 frontmatter 的 `name` 完全一致

#### 2. 描述编写技巧

- 使用祈使句："Use this skill when..."
- 关注用户意图，而非实现细节
- 包含"做什么"和"何时使用"
- 主动覆盖边界情况
- 长度控制在 1024 字符以内

#### 3. 渐进式披露原则

- SKILL.md 保持在 500 行以内
- 详细内容放入 `references/` 目录
- 在 SKILL.md 中明确说明何时加载哪些文件
- 文件引用使用相对路径

#### 4. 测试验证方法

- 设计评估查询集（应触发/不应触发）
- 使用训练/验证集划分避免过拟合
- 多次运行获得稳定结果
- 量化指标 + 主观评估结合

#### 5. 持续改进策略

- 每轮优化后都进行测试
- 记录每次改动和效果
- 收集真实用户反馈
- 定期回顾和更新

---

### 常见问题和解决方案

#### Q1: 技能创建后完全不触发怎么办？

**A**:

1. 检查 `name` 和 `description` 是否符合规范
2. 确认技能放置在正确的目录
3. 使用 `/skills` 命令确认技能已加载
4. 尝试非常明确的查询（如直接使用技能名称）
5. 如果仍不触发，使用 optimize-skill 进行描述优化

#### Q2: 优化后触发率反而下降了？

**A**:

- 可能原因：过度优化导致过拟合
- 解决方法：
  1. 回滚到上一版本
  2. 检查是否使用了训练集进行测试
  3. 使用验证集重新评估
  4. 减少描述的特异性，扩大适用范围

#### Q3: 如何平衡描述的详细程度？

**A**:

- 太短：触发率低
- 太长：可能超过 1024 字符限制，且可能引入噪音
- 建议：
  1. 从简洁开始（2-3 句话）
  2. 根据测试结果逐步扩展
  3. 优先添加高频失败的查询关键词
  4. 使用 YAML 多行字符串（`>`）提高可读性

#### Q4: 输出质量总是不稳定怎么办？

**A**:

1. 添加 Gotchas 章节，列出边界情况
2. 提供清晰的输出模板
3. 添加验证循环
4. 提供默认方案而非多个选项
5. 阅读代理执行轨迹，识别问题步骤

#### Q5: 需要多少轮优化迭代？

**A**:

- 描述优化：通常 3-5 轮
- 质量提升：通常 2-3 轮
- 测试验证：至少 1 轮，建议定期执行
- 原则：当改进趋于平缓时可以停止

#### Q6: 如何管理多个版本的技能？

**A**:

- 使用 Git 进行版本控制
- 在 frontmatter 的 `metadata` 中添加版本号
- 维护 CHANGELOG.md 记录每次改动
- 重大改动前创建分支

#### Q7: 技能之间如何协作？

**A**:

- 在 SKILL.md 中说明前置技能和后续技能
- 使用一致的输出格式便于衔接
- 避免功能重叠，明确职责边界
- 可以创建"元技能"协调多个子技能

#### Q8: 如何评估优化的 ROI（投入产出比）？

**A**:

- 量化指标：
  - 触发率提升百分比
  - 输出质量评分变化
  - 用户满意度调查
- 时间成本：
  - 优化耗时
  - 代理执行时间变化
- 决策：如果触发率已 >90% 且质量评分 >8/10，可以考虑停止优化

---

## 第四部分：进阶资源

### 参考文档索引

#### 使用指南

- [create-skill 使用指南](create-skill-usage.md) - 从零创建技能的详细指南
- [enhance-skill 使用指南](enhance-skill-usage.md) - 从外部资料增强技能的详细指南
- [optimize-skill 使用指南](optimize-skill-usage.md) - 优化技能质量的详细指南

#### create-skill 参考文档

- [framework.md](../skills/create-skill/references/framework.md) - 详细框架指南
- [skill-template.md](../skills/create-skill/assets/skill-template.md) - 标准模板

#### enhance-skill 参考文档

- [extraction-guide.md](../skills/enhance-skill/references/extraction-guide.md) - 信息提取指南
- [integration-strategies.md](../skills/enhance-skill/references/integration-strategies.md) - 整合策略指南
- [skill-analysis.md](../skills/enhance-skill/references/skill-analysis.md) - 技能能力分析指南
- [enhancement-template.md](../skills/enhance-skill/assets/enhancement-template.md) - 增强报告模板

#### optimize-skill 参考文档

- [description-optimization.md](../skills/optimize-skill/references/description-optimization.md) - 描述优化指南
- [best-practices.md](../skills/optimize-skill/references/best-practices.md) - 最佳实践应用
- [evaluation-testing.md](../skills/optimize-skill/references/evaluation-testing.md) - 评估测试指南
- [eval-script-template.sh](../skills/optimize-skill/assets/eval-script-template.sh) - 评估脚本模板

#### 官方规范

- [Agent Skills Specification](https://agentskills.io/specification) - 官方技能规范
- [skills-ref](https://github.com/agentskills/agentskills/tree/main/skills-ref) - 技能验证工具

---

### 工具和脚本

#### 评估脚本模板

位置：`../skills/optimize-skill/assets/eval-script-template.sh`

**使用方法**：

```bash
# 1. 复制模板
cp ../skills/optimize-skill/assets/eval-script-template.sh eval-my-skill.sh

# 2. 编辑脚本，填入您的测试查询
# 3. 赋予执行权限
chmod +x eval-my-skill.sh

# 4. 运行评估
./eval-my-skill.sh
```

**自定义评估方法**：

- 修改测试查询集
- 调整评分标准
- 添加自定义检查项
- 集成到 CI/CD 流程

---

### 下一步

#### 如何贡献和改进

1. **报告问题**：在 GitHub Issues 中报告 bug 或提出建议
2. **分享技能**：将您创建的优秀技能分享给社区
3. **改进文档**：帮助完善使用指南和示例
4. **开发工具**：创建辅助工具提升技能开发效率

#### 社区和资源

- **官方文档**：https://agentskills.io
- **GitHub 仓库**：https://github.com/agentskills/agentskills
- **社区论坛**：参与讨论和交流经验
- **示例技能库**：学习和参考优秀技能

#### 学习路径建议

1. **初学者**：
   - 阅读本教程的案例
   - 尝试创建一个简单技能
   - 使用 create-skill 和 optimize-skill

2. **进阶用户**：
   - 深入研究参考文档
   - 使用 enhance-skill 从外部资料增强技能
   - 创建复杂的多模块技能
   - 建立自动化测试流程

3. **专家**：
   - 贡献工具和最佳实践
   - 设计和维护技能框架
   - 培训和指导他人

---

## 结语

创建高质量的 Agent Skills 是一个迭代过程，需要：

1. **扎实的基础**：使用 create-skill 确保符合规范
2. **持续的优化**：使用 optimize-skill 不断提升质量
3. **系统的测试**：量化评估，数据驱动改进
4. **真实的反馈**：关注用户需求，解决实际问题

记住：**一个好的技能不仅要符合格式要求，更要能真正帮助代理完成任务。**

祝您创建出优秀的 Agent Skills！

---

**相关文档**：

- [create-skill 使用指南](create-skill-usage.md)
- [optimize-skill 使用指南](optimize-skill-usage.md)
- [返回 README](../README.md)
