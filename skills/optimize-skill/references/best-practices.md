# 最佳实践应用指南

本指南提供从真实经验中提取的有效指令模式，帮助提升技能的质量和可靠性。

## 1. 从真实经验出发

### 常见陷阱

仅依赖 LLM 的通用知识生成技能，导致模糊、通用的程序（"适当处理错误"、"遵循身份验证最佳实践"），而非具体的 API 模式、边界情况和项目约定。

### 有效方法

#### 从实际任务中提取

与代理完成真实任务时，注意：

- **成功的步骤**：导致成功的操作序列
- **做出的修正**：你纠正代理的地方（"使用库 X 而非 Y"、"检查边界情况 Z"）
- **输入输出格式**：数据的实际样子
- **提供的上下文**：代理不知道的项目特定事实、约定或约束

然后提取可复用模式到技能中。

#### 从现有项目工件综合

当有现成知识库时，将其提供给 LLM 并请求综合成技能。

**优质素材来源**：

- 内部文档、运行手册、风格指南
- API 规范、模式、配置文件
- 代码审查意见和问题跟踪器
- 版本控制历史，特别是补丁和修复
- 真实失败案例及其解决方案

**关键**：使用项目特定材料，而非通用参考资料。

## 2. 通过真实执行精炼

初稿通常需要改进。针对真实任务运行技能，然后将结果（不仅是失败）反馈到创建过程中。

**询问**：

- 什么触发了误报？
- 什么被遗漏了？
- 什么可以删减？

即使单次"执行-修订"循环也能显著提升质量，复杂领域通常需要多次迭代。

**阅读代理执行轨迹**，不仅看最终输出。如果代理在无成效的步骤上浪费时间，常见原因：

- 指令太模糊（代理尝试多种方法才找到可行的）
- 指令不适用于当前任务（代理仍然遵循）
- 提供了太多选项但没有明确的默认方案

## 3. 明智地使用上下文

技能激活后，完整的 `SKILL.md` 主体会加载到代理的上下文窗口中，与会话历史、系统上下文和其他活动技能竞争注意力。

### 添加代理缺乏的内容

专注于没有你的技能代理就不知道的内容：

- 项目特定约定
- 领域特定程序
- 非显而易见的边界情况
- 要使用的特定工具或 API

### 省略代理已知的内容

不需要解释：

- PDF 是什么
- HTTP 如何工作
- 数据库迁移的作用

**自问**："没有这条指令代理会做错吗？"

- 如果答案是否定的 → 删除它
- 如果不确定 → 测试它
- 如果代理没有技能也能很好地处理整个任务 → 技能可能没有增加价值

### 对比示例

````markdown
<!-- 过于冗长 — 代理已经知道 PDF 是什么 -->

## Extract PDF text

PDF (Portable Document Format) files are a common file format that contains
text, images, and other content. To extract text from a PDF, you'll need to
use a library. pdfplumber is recommended because it handles most cases well.

<!-- 更好 — 直接进入代理独自不知道的内容 -->

## Extract PDF text

Use pdfplumber for text extraction. For scanned documents, fall back to
pdf2image with pytesseract.

```python
import pdfplumber

with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```
````

## 4. 设计连贯单元

决定技能涵盖什么类似于决定函数应该做什么：封装一个连贯的工作单元，能与其他技能良好组合。

- **范围太窄**：单个任务需要加载多个技能，导致开销和冲突指令的风险
- **范围太宽**：难以精确激活
- **适度范围**：查询数据库并格式化结果可能是一个连贯单元，而同时涵盖数据库管理的技能可能做得太多

## 5. 适度详细

过于全面的技能可能弊大于利：

- 代理难以提取相关内容
- 可能追求由不适用指令触发的无成效路径

**简洁的分步指导 + 工作示例** 通常优于详尽的文档。

当你发现自己在覆盖每个边界情况时，考虑大多数是否最好由代理自己的判断来处理。

## 6. 校准控制级别

并非技能的每个部分都需要相同级别的规范性。将指令的特异性与任务的脆弱性匹配。

### 给予自由度

当多种方法有效且任务容错时：

```markdown
## Code review process

1. Check all database queries for SQL injection (use parameterized queries)
2. Verify authentication checks on every endpoint
3. Look for race conditions in concurrent code paths
4. Confirm error messages don't leak internal details
```

对于灵活的指令，解释**为什么**比刚性指令更有效——理解指令背后目的的代理能做出更好的上下文相关决策。

### 规定性强

当操作脆弱、一致性重要或必须遵循特定顺序时：

````markdown
## Database migration

Run exactly this sequence:

```bash
python scripts/migrate.py --verify --backup
```

Do not modify the command or add additional flags.
````

大多数技能都有混合。独立校准每个部分。

### 提供默认值，而非菜单

当多个工具或方法可行时，选择一个默认值并简要提及替代方案，而不是将它们呈现为平等选项。

````markdown
<!-- 太多选项 -->

You can use pypdf, pdfplumber, PyMuPDF, or pdf2image...

<!-- 清晰的默认值加逃生舱口 -->

Use pdfplumber for text extraction:

```python
import pdfplumber
```

For scanned PDFs requiring OCR, use pdf2image with pytesseract instead.
````

## 7. 有效指令模式

这些是可重用的技术来构建技能内容。不是每个技能都需要所有这些——使用适合你任务的。

### 7.1 Gotchas 章节

许多技能中价值最高的内容是 gotchas 列表——违反合理假设的环境特定事实。

```markdown
## Gotchas

- The `users` table uses soft deletes. Queries must include
  `WHERE deleted_at IS NULL` or results will include deactivated accounts.
- The user ID is `user_id` in the database, `uid` in the auth service,
  and `accountId` in the billing API. All three refer to the same value.
- The `/health` endpoint returns 200 as long as the web server is running,
  even if the database connection is down. Use `/ready` to check full
  service health.
```

将 gotchas 放在 `SKILL.md` 中，让代理在遇到情况前读到它们。

**提示**：当代理犯了你必须纠正的错误时，将纠正添加到 gotchas 部分。这是迭代改进技能最直接的方法之一。

### 7.2 输出格式模板

当你需要代理以特定格式产生输出时，提供模板。这比用散文描述格式更可靠。

**短模板**可以内联在 `SKILL.md` 中；**长模板**存储在 `assets/` 中并从 `SKILL.md` 引用。

````markdown
## Report structure

Use this template, adapting sections as needed:

```markdown
# [Analysis Title]

## Executive summary

[One-paragraph overview of key findings]

## Key findings

- Finding 1 with supporting data
- Finding 2 with supporting data

## Recommendations

1. Specific actionable recommendation
2. Specific actionable recommendation
```
````

### 7.3 多步骤工作流清单

显式清单帮助代理跟踪进度并避免跳过步骤。

```markdown
## Form processing workflow

Progress:

- [ ] Step 1: Analyze the form (run `scripts/analyze_form.py`)
- [ ] Step 2: Create field mapping (edit `fields.json`)
- [ ] Step 3: Validate mapping (run `scripts/validate_fields.py`)
- [ ] Step 4: Fill the form (run `scripts/fill_form.py`)
- [ ] Step 5: Verify output (run `scripts/verify_output.py`)
```

### 7.4 验证循环

指示代理在继续前验证自己的工作。

```markdown
## Editing workflow

1. Make your edits
2. Run validation: `python scripts/validate.py output/`
3. If validation fails:
   - Review the error message
   - Fix the issues
   - Run validation again
4. Only proceed when validation passes
```

### 7.5 计划-验证-执行

对于批量或破坏性操作，让代理以结构化格式创建中间计划，对照真实来源验证，然后才执行。

```markdown
## PDF form filling

1. Extract form fields: `python scripts/analyze_form.py input.pdf` → `form_fields.json`
2. Create `field_values.json` mapping each field name to its intended value
3. Validate: `python scripts/validate_fields.py form_fields.json field_values.json`
4. If validation fails, revise `field_values.json` and re-validate
5. Fill the form: `python scripts/fill_form.py input.pdf field_values.json output.pdf`
```

关键要素是第 3 步：验证脚本对照真实来源检查计划。错误信息给代理足够的信息来自我纠正。

### 7.6 捆绑可复用脚本

当迭代技能时，比较测试用例间的代理执行轨迹。如果你注意到代理每次运行时独立重新发明相同的逻辑，这是一个信号，应该编写一个经过测试的脚本一次并捆绑在 `scripts/` 中。

**优势**：

- 减少代理的上下文负担
- 提高一致性和可靠性
- 简化技能指令
- 便于维护和更新

**⚠️ 重要提醒：何时应该生成脚本**

并非所有技能都需要脚本。仅在以下情况才建议创建脚本：

1. **重复性复杂逻辑**：代理多次独立实现相同的复杂流程
   - ✅ 好例子：PDF 表单字段分析、数据验证、格式转换
   - ❌ 坏例子：读取单个 CSV 文件、简单的文本替换

2. **高可靠性要求**：任务容易出错，需要精确执行
   - ✅ 好例子：数据库迁移、批量 API 调用、事务处理
   - ❌ 坏例子：查询单个记录、显示帮助信息

3. **多场景复用**：脚本能在 2+ 个不同测试用例中使用
   - ✅ 好例子：通用数据清洗、报告生成模板
   - ❌ 坏例子：针对特定文件的临时处理

4. **显著简化指令**：脚本能将冗长的步骤压缩为简单命令
   - ✅ 好例子：将 50 行详细步骤变为 `python analyze.py`
   - ❌ 坏例子：创建一个脚本来执行单行命令

**脚本质量检查清单**：

在创建脚本前，确认：

- [ ] 脚本解决了实际问题，而非"为了有脚本而有脚本"
- [ ] 脚本至少能在 2+ 个不同场景中复用
- [ ] 脚本有清晰的输入输出和错误处理
- [ ] 脚本比直接在 SKILL.md 中描述更高效
- [ ] 脚本名称清晰表达其用途（如 `analyze_form.py` 而非 `script1.py`）
- [ ] 脚本有必要的注释和使用说明
- [ ] 已在 SKILL.md 中明确说明何时使用该脚本

**常见反模式（避免）**：

````markdown
<!-- ❌ 不要这样做：脚本太简单，无实际价值 -->

## 数据处理

运行脚本处理数据：

```bash
python scripts/process.py
```
````

脚本内容：

```python
import pandas as pd
df = pd.read_csv('data.csv')
print(df.head())
```

**问题**：这个脚本只做了代理可以轻松完成的事情，增加了不必要的复杂度。

````

```markdown
<!-- ✅ 正确做法：脚本解决复杂问题 -->

## 复杂表单分析

对于包含多个字段类型的 PDF 表单，使用专用分析脚本：

```bash
python scripts/analyze_form.py input.pdf > form_fields.json
````

该脚本会：

- 自动检测所有表单字段类型（文本框、复选框、下拉列表等）
- 提取字段的坐标、大小和约束条件
- 处理嵌套表单和动态字段
- 输出标准化的 JSON 格式供后续处理

**为什么需要脚本**：PDF 表单结构复杂，手动解析容易遗漏边界情况（如隐藏字段、条件显示字段）。此脚本经过多次迭代优化，能可靠处理各种复杂表单。

```

**决策流程**：

```

需要生成脚本吗？
├─ 任务是否复杂且容易出错？
│ ├─ 是 → 继续
│ └─ 否 → ❌ 不需要脚本，直接在 SKILL.md 中描述
├─ 脚本能否在多个场景中复用？
│ ├─ 是 → 继续
│ └─ 否 → ❌ 不需要脚本，这是一次性任务
├─ 脚本是否显著简化了指令？
│ ├─ 是 → 继续
│ └─ 否 → ❌ 不需要脚本，直接描述更清晰
└─ ✅ 应该生成脚本

```

## 8. 最佳实践检查清单

应用最佳实践后，确认：

- [ ] 从真实经验出发，而非通用知识
- [ ] 通过真实执行进行了精炼
- [ ] 添加了代理缺乏的内容
- [ ] 删除了代理已知的冗余内容
- [ ] 技能范围适中（不太窄也不太宽）
- [ ] 指令详细程度适当
- [ ] 控制级别与任务脆弱性匹配
- [ ] 提供了默认方案而非菜单
- [ ] 使用了适当的指令模式（Gotchas、模板、清单等）
- [ ] **如生成脚本，已确认其必要性和质量**（参见 7.6 节）

## 9. 下一步

应用最佳实践后：

1. **测试验证**：使用 [evaluation-testing.md](evaluation-testing.md) 评估技能性能
2. **收集反馈**：从真实使用中获取反馈
3. **持续改进**：根据反馈迭代优化

记住：最佳实践不是一次性应用的规则，而是持续改进的指导原则。随着使用场景的变化，技能也需要相应调整。
```
