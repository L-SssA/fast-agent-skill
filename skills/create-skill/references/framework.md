# 第一阶段：基础框架构建指南

本指南帮助你从零开始创建一个符合官方标准的 Agent Skill。遵循这些步骤确保你的技能结构正确、格式合规。

## 1. 目录结构规范

### 最小结构

每个技能至少需要一个 `SKILL.md` 文件：

```
skill-name/
└── SKILL.md          # 必需：元数据 + 指令
```

### 完整结构

根据需要添加以下可选目录：

```
skill-name/
├── SKILL.md          # 必需：元数据 + 指令
├── scripts/          # 可选：可执行代码（Python、Bash、JavaScript 等）
├── references/       # 可选：详细文档（技术参考、表单模板等）
├── assets/           # 可选：静态资源（模板、图片、数据文件）
└── ...               # 其他文件或目录
```

### 命名规则

- **目录名**必须与 `SKILL.md` frontmatter 中的 `name` 字段完全一致
- 使用小写字母、数字和连字符
- 避免空格和特殊字符

## 2. Frontmatter 必填字段详解

`SKILL.md` 文件必须以 YAML frontmatter 开头，后跟 Markdown 内容。

### name 字段

**要求**：

- 长度：1-64 字符
- 允许字符：小写字母（`a-z`）、数字（`0-9`）、连字符（`-`）
- 不能以连字符开头或结尾
- 不能有连续连字符（`--`）
- 必须与父目录名完全匹配

**有效示例**：

```yaml
name: pdf-processing
name: data-analysis
name: code-review
```

**无效示例**：

```yaml
name: PDF-Processing    # 不允许大写字母
name: -pdf              # 不能以连字符开头
name: pdf--processing   # 不能有连续连字符
```

### description 字段

**要求**：

- 长度：1-1024 字符
- 必须描述"做什么"和"何时使用"
- 包含具体关键词帮助代理识别相关任务

**好的示例**：

```yaml
description: Extracts text and tables from PDF files, fills PDF forms, and merges multiple PDFs. Use when working with PDF documents or when the user mentions PDFs, forms, or document extraction.
```

**差的示例**：

```yaml
description: Helps with PDFs. # 过于宽泛，缺少具体信息
```

**基础要求**：

- 使用祈使句："Use this skill when..."
- 关注用户意图，而非实现细节
- 包含用户可能使用的关键词

**注意**：以上为基础要求。如需高级优化技巧（如主动覆盖边界情况、系统化测试触发率等），请使用 optimize-skill 技能。

## 3. Frontmatter 可选字段

### license 字段

指定技能的许可证。建议保持简短。

```yaml
license: MIT
```

或引用捆绑的许可证文件：

```yaml
license: Proprietary. LICENSE.txt has complete terms
```

### compatibility 字段

仅在技能有特定环境要求时才包含此字段。

```yaml
compatibility: Requires Python 3.14+ and uv
```

```yaml
compatibility: Requires git, docker, jq, and access to the internet
```

**注意**：大多数技能不需要此字段。

### metadata 字段

任意键值对映射，用于存储额外元数据。建议使用唯一的键名避免冲突。

```yaml
metadata:
  author: example-org
  version: "1.0"
  category: data-processing
```

### allowed-tools 字段

（实验性）预批准的工具列表，空格分隔。支持情况因代理实现而异。

```yaml
allowed-tools: Bash(git:*) Bash(jq:*) Read
```

## 4. Body 内容编写指南

Frontmatter 之后的 Markdown 内容包含技能指令。没有格式限制，编写任何能帮助代理有效执行任务的内容。

### 推荐章节

#### 4.1 分步指令

提供清晰的操作步骤：

```markdown
## 使用步骤

1. 第一步：说明要做什么
2. 第二步：说明要做什么
3. 第三步：说明要做什么
```

#### 4.2 输入输出示例

展示典型的输入和期望的输出：

````markdown
## 示例

### 输入

```
用户的请求示例
```

### 输出

```
期望的结果
```
````

#### 4.3 常见边界情况

列出需要注意的特殊情况：

```markdown
## 注意事项

- 边界情况 1：如何处理
- 边界情况 2：如何处理
- 常见错误及避免方法
```

### 文件引用

当需要引用其他文件时，使用相对于技能根目录的路径：

```markdown
查看[技术参考](references/REFERENCE.md)了解详细信息。

运行提取脚本：
scripts/extract.py
```

**最佳实践**：

- 保持文件引用一层深度（从 SKILL.md 直接引用）
- 避免深层嵌套的引用链
- 明确说明何时加载哪些文件

### 代码块

提供多平台示例以增加兼容性：

````markdown
### 生成随机数

Bash:

```bash
echo $((RANDOM % 6 + 1))
```

PowerShell:

```powershell
Get-Random -Minimum 1 -Maximum 7
```

Python:

```python
import random
print(random.randint(1, 6))
```
````

## 5. 实操示例：创建 roll-dice 技能

让我们通过一个完整示例来演示如何创建技能。

### 需求

创建一个技能，让代理能够掷骰子（生成随机数）。

### 步骤 1：创建目录结构

```
.agents/skills/roll-dice/
└── SKILL.md
```

### 步骤 2：编写 SKILL.md

````markdown
---
name: roll-dice
description: Roll dice using a random number generator. Use when asked to roll a die (d6, d20, etc.), roll dice, or generate a random dice roll.
---

To roll a die, use the following command that generates a random number from 1
to the given number of sides:

```bash
echo $((RANDOM % <sides> + 1))
```

```powershell
Get-Random -Minimum 1 -Maximum (<sides> + 1)
```

Replace `<sides>` with the number of sides on the die (e.g., 6 for a standard
die, 20 for a d20).
````

### 步骤 3：验证

检查以下几点：

- [ ] 目录名 `roll-dice` 与 frontmatter 中的 `name` 一致
- [ ] `name` 符合命名规范
- [ ] `description` 包含"做什么"和"何时使用"
- [ ] 提供了清晰的指令和示例
- [ ] 包含了多平台代码示例

## 6. 验证步骤

### 使用 skills-ref 工具验证

如果安装了 [skills-ref](https://github.com/agentskills/agentskills/tree/main/skills-ref) 参考库：

```bash
skills-ref validate ./my-skill
```

这将检查：

- Frontmatter 格式是否有效
- 命名规范是否符合要求
- 必填字段是否存在

### 手动检查清单

在部署技能前，确保：

- [ ] `SKILL.md` 存在且格式正确
- [ ] Frontmatter 使用 `---` 包裹
- [ ] `name` 和 `description` 字段存在且非空
- [ ] `name` 符合命名规范
- [ ] `description` 不超过 1024 字符
- [ ] 目录名与 `name` 字段一致
- [ ] 文件引用使用相对路径
- [ ] 代码块有正确的语言标识

### 测试技能

1. 将技能放置在代理可发现的目录中（如 `.agents/skills/`）
2. 启动代理会话
3. 使用 `/skills` 命令确认技能出现在列表中
4. 尝试触发技能的典型查询
5. 观察代理是否正确激活并遵循指令

## 7. 常见问题

### Q: SKILL.md 应该多长？

**A**: 保持在 500 行以内。如果需要更多内容，使用渐进式披露：将详细内容放入 `references/` 目录，在 SKILL.md 中说明何时加载这些文件。

### Q: 什么时候需要 scripts/ 目录？

**A**: 当技能需要执行复杂操作、数据处理或验证时。脚本应该是自包含的或清晰记录依赖关系。

### Q: 如何决定是否需要 references/ 目录？

**A**: 当有以下内容时：

- 详细的技术参考文档
- 表单模板或结构化数据格式
- 领域特定的详细说明
- API 文档或配置示例

### Q: 我的技能需要多少示例？

**A**: 至少提供一个完整的输入输出示例。对于复杂技能，提供多个示例覆盖不同场景。

## 8. 下一步

完成基础框架后：

1. **基础检查**：确认符合格式要求和命名规范
2. **优化提升**：使用 optimize-skill 技能优化描述、应用最佳实践
3. **测试验证**：使用 optimize-skill 技能进行系统化测试

记住：一个好的技能不仅要符合格式要求，更要能真正帮助代理完成任务。持续迭代和改进是关键。
