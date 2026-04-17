# create-skill 使用指南

## 技能概述

**create-skill** 是一个用于从零创建符合官方标准的 Agent Skills 的辅助技能。

### 功能定位

- 帮助用户搭建技能的基础框架
- 确保目录结构和文件格式符合规范
- 提供标准化的模板和最佳实践指导

### 适用场景

- 需要新建技能时
- 搭建技能基础框架
- 编写初始描述和指令
- 学习 Agent Skills 标准规范

### 核心能力

- 目录结构规范指导
- Frontmatter 字段详解
- 基础模板提供
- 命名规范验证
- 渐进式披露原则应用

## 使用方法

### 基本用法

当您需要创建一个新技能时，只需向智能体描述您的需求：

```markdown
用户: "我想创建一个处理 CSV 数据的技能"

智能体自动激活 create-skill，引导完成：

1. 需求确认 - 了解数据类型、处理方式、输出格式等
2. 目录结构搭建 - 创建正确的文件夹结构
3. Frontmatter 编写 - 设置 name、description 等元数据
4. 基础指令编写 - 编写 SKILL.md 的核心内容
```

### 关键参数

在使用 create-skill 时，准备好以下信息可以帮助智能体更好地协助您：

- **技能名称和用途**：清晰描述技能要做什么
- **目标场景和用户群体**：谁会使用这个技能，在什么情况下使用
- **主要功能和输出格式**：技能的核心功能和期望的输出形式
- **技术栈要求**（可选）：如果需要特定的编程语言或工具

### 交互示例

```markdown
用户: "帮我创建一个 PDF 文本提取技能"

智能体:

1. 确认需求细节：
   - 需要提取纯文本还是包含表格？
   - 是否需要处理扫描版 PDF（OCR）？
   - 输出格式有什么要求？

2. 加载 references/framework.md，开始指导创建：
   - 创建目录：pdf-text-extraction/
   - 编写 frontmatter
   - 设计基础指令结构
   - 添加多平台代码示例

3. 完成后建议：
   "基础框架已创建完成。如需优化描述以提高触发率，或应用更多最佳实践，
   建议使用 optimize-skill 进行进一步优化和测试。"
```

## 参考资源

create-skill 技能包包含以下参考文档：

- **[framework.md](../skills/create-skill/references/framework.md)** - 详细框架指南
  - 目录结构规范
  - Frontmatter 必填字段详解
  - Body 内容编写指南
  - 实操示例（roll-dice 技能）
  - 验证步骤和常见问题

- **[skill-template.md](../skills/create-skill/assets/skill-template.md)** - 标准模板
  - 完整的技能模板结构
  - 所有必要章节
  - 推荐的内容组织方式

## 输出成果

使用 create-skill 后，您将获得：

### 1. 完整的技能目录结构

```
your-skill-name/
├── SKILL.md          # 必需：元数据 + 指令
├── scripts/          # 可选：可执行代码
├── references/       # 可选：详细文档
└── assets/           # 可选：静态资源
```

### 2. 符合规范的 SKILL.md 文件

包含：

- 正确的 YAML frontmatter（name、description 等）
- 清晰的指令和步骤
- 实用的示例和边界情况说明

### 3. 基础的 frontmatter 和 body 内容

- `name`：符合命名规范（小写、连字符、1-64 字符）
- `description`：包含"做什么"和"何时使用"（1-1024 字符）
- 分步指令、示例、注意事项等基础内容

## 后续步骤

create-skill 创建的是**符合标准的基础框架**。为了获得更高质量的技能，建议：

### 1. 使用 optimize-skill 优化描述和质量

- 提升 description 的触发准确性
- 应用最佳实践（Gotchas、模板、清单等）
- 优化指令模式

### 2. 进行测试验证

- 触发率评估（是否容易被激活）
- 输出质量评估（结果是否准确稳定）
- 系统化测试（使用评估脚本）

### 3. 部署到生产环境

- 将技能放置到代理可发现的目录
- 使用 `/skills` 命令验证
- 收集实际使用反馈
- 持续迭代改进

## 常见问题

### Q: 什么时候应该使用 create-skill？

**A**: 当您从零开始创建一个新技能时使用。如果您已有基础技能框架但需要优化，请直接使用 optimize-skill。

### Q: create-skill 和 optimize-skill 的区别？

**A**:

- **create-skill**：专注于从零创建符合标准的基础框架，确保格式正确、结构完整
- **optimize-skill**：专注于优化和改进现有技能的质量，提升触发率和输出效果

典型工作流：先用 create-skill 创建基础，再用 optimize-skill 优化提升。

### Q: 创建完成后如何验证？

**A**:

1. **手动检查**：
   - 目录名与 frontmatter 中的 `name` 一致
   - `name` 符合命名规范
   - `description` 包含"做什么"和"何时使用"
   - SKILL.md 行数 < 500

2. **实际测试**：
   - 将技能放置到 `.agents/skills/` 目录
   - 启动代理会话，使用 `/skills` 确认技能出现
   - 尝试典型查询，观察是否正确激活

3. **使用工具验证**（如果安装了 skills-ref）：
   ```bash
   skills-ref validate ./your-skill
   ```

### Q: SKILL.md 应该写多长？

**A**: 保持在 500 行以内。如果需要更多内容，使用渐进式披露原则：将详细内容放入 `references/` 目录，在 SKILL.md 中说明何时加载这些文件。

### Q: 我需要添加 scripts 或 references 目录吗？

**A**: 根据实际需求：

- **scripts/**：当技能需要执行复杂操作、数据处理或验证时
- **references/**：当有详细的技术参考、表单模板或领域特定说明时
- **assets/**：当需要静态资源如模板文件、图片、数据文件时

create-skill 会帮助您判断是否需要这些目录。

## 最佳实践提示

1. **从真实需求出发**：基于实际任务提取模式，而非通用知识
2. **提供默认方案**：选择一个默认方法，简要提及替代方案
3. **聚焦代理不知道的内容**：添加项目约定、领域特定程序
4. **使用渐进式披露**：SKILL.md 保持简洁，详细内容放在 references/
5. **包含具体示例**：至少提供一个完整的输入输出示例

---

**下一步**：查看 [完整工作流程教程](workflow-examples.md) 了解如何结合 create-skill 和 optimize-skill 创建高质量技能。
