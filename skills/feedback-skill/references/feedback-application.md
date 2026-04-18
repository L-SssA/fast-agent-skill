# Feedback Application - 反馈应用策略

本文档提供将提取的改进建议应用到技能中的系统化方法，确保整合过程高效、准确且保持一致性。

## 整合决策树

### 决策流程

```
收到改进建议
    ↓
判断修改类型
    ├─ Description 优化 → 直接更新 SKILL.md 的 frontmatter
    ├─ Workflow 补充 → 判断长度和影响范围
    │   ├─ 简短核心步骤 (< 30 行) → 添加到 SKILL.md
    │   └─ 详细说明或复杂逻辑 → 创建/更新 references/ 文件
    ├─ 边界情况 → 创建/更新 references/ 中的 Gotchas 文档
    ├─ 示例增强 → 判断示例复杂度
    │   ├─ 简单示例 → 添加到 SKILL.md 的 Examples 章节
    │   └─ 复杂示例 → 创建 references/ 中的示例文档
    └─ References 组织 → 创建新文件或更新现有文件
         ↓
检查 SKILL.md 行数
    ├─ < 450 行 → 可以适度添加内容
    └─ ≥ 450 行 → 优先放入 references/，考虑重构
         ↓
执行修改
    ↓
更新引用关系
    ↓
验证一致性
```

### 关键决策因素

**1. 内容长度**

- 短内容 (< 30 行): 可放入 SKILL.md
- 中等内容 (30-100 行): 视重要性决定
- 长内容 (> 100 行): 放入 references/

**2. 使用频率**

- 高频使用: 优先放入 SKILL.md
- 偶尔使用: 放入 references/
- 罕见场景: 放入 references/ 的高级部分

**3. 复杂度**

- 简单明了: 可放入 SKILL.md
- 需要详细解释: 放入 references/
- 包含多个子主题: 拆分为多个 reference 文件

**4. 目标读者**

- 所有用户都需要: 放入 SKILL.md
- 高级用户才需要: 放入 references/
- 特定场景才需要: 放入 references/ 的相关章节

## SKILL.md 更新策略

### Frontmatter 更新

**Description 优化**：

```markdown
# 原始

description: Helps with data analysis

# 优化后

description: Specializes in CSV and Excel data analysis, including
cleaning, transformation, and statistical summaries. Use when working
with tabular data files. Not suitable for unstructured text or images.
```

**注意事项**：

- 保持 description 在 1024 字符以内
- 使用祈使句和用户意图导向
- 包含触发关键词和使用边界
- 测试修改后的触发效果

### Body 结构维护

**标准结构**：

```markdown
# Skill Name

简要介绍（1-2 段）

## When to Use

- 使用场景 1
- 使用场景 2
- 边界说明

## Quick Start

快速开始指南（可选）

## Workflow

1. 步骤 1
2. 步骤 2
3. 步骤 3

## Key Concepts

核心概念说明（可选）

## Examples

基本示例

## Best Practices

最佳实践（可选）

## Common Pitfalls

常见陷阱和注意事项

## Related Resources

- [详细指南](references/guide.md)
- [API 参考](references/api.md)
```

**更新原则**：

1. **保持层次清晰**：使用适当的标题层级
2. **渐进式披露**：详细内容通过链接指向 references/
3. **避免重复**：不在多处说明同一内容
4. **及时更新目录**：如果手动维护目录的话

### 章节插入位置

**新增 Workflow 步骤**：

- 插入到相关步骤之后
- 重新编号后续步骤
- 检查步骤间的逻辑连贯性

**新增 Best Practices**：

- 按重要性排序
- 与现有实践保持一致的格式
- 提供具体的理由和示例

**新增 Common Pitfalls**：

- 按严重程度或发生频率排序
- 每个陷阱包含：现象、原因、解决方案
- 使用醒目的格式（如加粗、列表）

**新增 References 链接**：

- 放在 Related Resources 章节
- 使用描述性的链接文本
- 按相关性或字母顺序排列

## Reference 文件组织

### 文件命名规范

**原则**：

- 使用小写字母和连字符
- 名称具有描述性
- 避免缩写（除非是广泛认可的）
- 与内容紧密相关

**示例**：

```
✅ data-validation.md
✅ api-integration-guide.md
✅ troubleshooting-common-errors.md

❌ validation.md (太模糊)
❌ API_Integration.md (使用了大写和下划线)
❌ misc.md (无意义)
```

### 文件组织结构

**单一主题文件**：

```markdown
# Topic Name

## Overview

简要介绍这个主题

## When This Applies

适用场景说明

## Detailed Guide

详细内容...

## Examples

相关示例

## Common Issues

常见问题和解决方案

## Related

- [相关文件 1](other-file.md)
- [返回主技能](../SKILL.md)
```

**多主题文件**（仅在主题紧密相关时）：

```markdown
# Category Name

## Subtopic 1

内容...

## Subtopic 2

内容...

## See Also

- [更详细的 Subtopic 1 指南](subtopic1-deep-dive.md)
- [更详细的 Subtopic 2 指南](subtopic2-deep-dive.md)
```

### 目录结构设计

**简单技能**：

```
skill-name/
├── SKILL.md
├── references/
│   ├── guide.md
│   └── examples.md
└── assets/
    └── template.md
```

**复杂技能**：

```
skill-name/
├── SKILL.md
├── references/
│   ├── core/
│   │   ├── workflow.md
│   │   └── concepts.md
│   ├── advanced/
│   │   ├── optimization.md
│   │   └── edge-cases.md
│   └── troubleshooting/
│       ├── common-errors.md
│       └── faq.md
├── assets/
│   ├── templates/
│   └── scripts/
└── tests/
    └── test-cases.md
```

**注意**：避免过深的嵌套，一般不超过 2 层。

## 内容去重方法

### 检测重复

**检查点**：

1. **相同信息多处出现**：
   - 在 SKILL.md 和 references/ 中都有详细说明
   - 多个 reference 文件重复同一内容

2. **相似但不完全相同**：
   - 不同文件中有重叠的内容
   - 可以合并的主题被分开

3. **过时信息**：
   - 旧版本的说明未被删除
   - 已被新方法替代的旧方法仍保留

### 去重策略

**策略 1: 单一真相源 (Single Source of Truth)**

```
问题: 数据验证规则在三个地方都有说明

解决:
1. 选择最完整的位置作为"真相源"
2. 在其他位置添加引用链接
3. 删除重复的详细说明

示例:
SKILL.md: "For data validation rules, see
[Data Validation Guide](references/data-validation.md)"

references/data-validation.md: [完整的验证规则说明]
```

**策略 2: 抽象共同部分**

```
问题: 多个文件都说明了相同的配置步骤

解决:
1. 创建共享的配置指南
2. 在各文件中引用该指南
3. 仅保留各文件的特殊配置说明

示例:
references/setup.md: [通用配置步骤]
references/advanced-config.md: "First complete the
[basic setup](setup.md), then..."
```

**策略 3: 版本管理**

```
问题: 新旧方法并存造成混淆

解决:
1. 明确标记推荐方法
2. 将旧方法移至"Legacy"章节
3. 说明为什么不推荐使用旧方法

示例:
## Recommended Approach (v2.0+)

Use the new API...

## Legacy Approach (Deprecated)

The old method is still supported but not recommended
because...
```

### 去重工具和技术

**手动检查清单**：

- [ ] 搜索关键术语，查看是否在多处出现
- [ ] 比较相似章节的内容
- [ ] 检查是否有"参见"循环引用
- [ ] 验证所有链接仍然有效

**自动化辅助**（如果可用）：

```bash
# 查找重复内容
grep -r "specific phrase" skills/skill-name/

# 检查文件大小异常
find skills/skill-name/ -name "*.md" -exec wc -l {} +

# 验证链接
# (需要使用专门的 markdown 链接检查工具)
```

## 引用关系维护

### SKILL.md 中的引用

**引用格式**：

```markdown
// 相对路径引用

- [Detailed Guide](references/guide.md)

// 带描述的引用

- For advanced usage, see the [Advanced Guide](references/advanced.md)

// 章节内引用
See the [Common Pitfalls section](#common-pitfalls) below.

// 外部资源引用

- [Official Documentation](https://example.com/docs)
```

**最佳实践**：

1. **使用相对路径**：便于移动和复制
2. **描述性链接文本**：说明链接内容的价值
3. **定期验证链接**：确保没有断链
4. **保持一致的格式**：统一的引用风格

### Reference 文件间的引用

**交叉引用**：

```markdown
// 同级文件引用
参见 [相关主题](related-topic.md)。

// 上级目录引用
返回 [主技能](../SKILL.md)。

// 下级目录引用
详情请见 [子主题](subdir/subtopic.md)。
```

**避免的问题**：

- ❌ 循环引用（A 引用 B，B 又引用 A）
- ❌ 过深的引用链（A → B → C → D → E）
- ❌ 悬空引用（引用的文件不存在）

### 引用更新检查清单

当添加或删除文件时：

- [ ] 更新 SKILL.md 中的 Related Resources
- [ ] 检查其他 reference 文件是否有引用
- [ ] 验证所有路径正确
- [ ] 测试链接是否可点击（在支持的编辑器中）
- [ ] 更新任何目录或索引文件

## 一致性验证

### 风格一致性

**检查项**：

1. **标题格式**：
   - 统一使用 Sentence case 或 Title Case
   - 标题层级合理（不跳过层级）

2. **代码块**：
   - 指定语言类型（`python, `bash）
   - 一致的缩进风格

3. **列表格式**：
   - 统一使用 `-` 或 `*`
   - 嵌套列表的缩进一致

4. **强调标记**：
   - 统一使用 `**bold**` 或 `*italic*`
   - 不混用不同的强调方式

### 术语一致性

**维护术语表**（对于复杂技能）：

```markdown
# Terminology

**Term 1**: Definition
**Term 2**: Definition
```

**检查方法**：

- 搜索术语的不同变体
- 确保全文使用统一的术语
- 首次出现时提供定义或链接

### 示例一致性

**检查项**：

- 代码示例使用相同的编程语言版本
- 变量命名风格一致
- 输出格式统一
- 示例的场景和上下文合理

## 应用工作流

### Step 1: 准备阶段

```markdown
1. 读取当前的 SKILL.md 和相关 references
2. 理解技能的当前结构和内容
3. 确认要应用的改进建议列表
4. 备份当前版本（如果使用版本控制，创建分支）
```

### Step 2: 规划修改

```markdown
1. 对每个改进建议，确定：
   - 修改的文件
   - 修改的位置
   - 是否需要新建文件
   - 是否需要更新引用

2. 评估修改之间的依赖关系
3. 确定修改的顺序
4. 预估 SKILL.md 的行数变化
```

### Step 3: 执行修改

```markdown
1. 按优先级从高到低应用改进
2. 每次修改后立即验证：
   - 语法正确
   - 链接有效
   - 格式一致

3. 批量修改同类内容
4. 实时更新引用关系
```

### Step 4: 验证和调整

```markdown
1. 检查 SKILL.md 行数（应 < 500）
2. 验证所有链接和引用
3. 阅读完整文档，检查流畅性
4. 确认没有引入新的问题
5. 必要时进行调整
```

### Step 5: 生成报告

```markdown
生成应用报告，包括：

- 应用的改进列表
- 修改的文件清单
- 新增的文件清单
- 需要注意的变化
- 建议的测试用例
```

## 特殊情况处理

### 大规模重构

**场景**：多个改进建议涉及技能的重组

**处理方法**：

1. 制定详细的重构计划
2. 分阶段执行，每阶段可独立验证
3. 保持向后兼容性（如果可能）
4. 提供迁移指南
5. 充分测试

### 冲突的改进建议

**场景**：两个改进建议相互矛盾

**处理方法**：

1. 分析冲突的根本原因
2. 与用户讨论，了解优先级
3. 寻找折中方案
4. 或者分版本实现（先实现高优先级的）
5. 记录决策和理由

### SKILL.md 接近限制

**场景**：SKILL.md 已接近 500 行限制

**处理方法**：

1. 优先将内容移至 references/
2. 精简现有内容：
   - 删除冗余说明
   - 简化示例
   - 使用链接代替详细内容
3. 考虑拆分技能（如果职责过多）
4. 重构组织结构

### 破坏性变更

**场景**：改进会改变技能的接口或行为

**处理方法**：

1. 明确标记为破坏性变更
2. 提供迁移指南
3. 如果可能，提供过渡期（同时支持新旧方式）
4. 更新所有相关文档和示例
5. 通知受影响的用户

## 应用后的验证

### 立即验证

**自动化检查**（如果可用）：

```bash
# 检查 markdown 语法
markdownlint skills/skill-name/

# 检查链接
markdown-link-check skills/skill-name/SKILL.md

# 统计行数
wc -l skills/skill-name/SKILL.md
```

**手动检查**：

- [ ] 在编辑器中预览渲染效果
- [ ] 点击所有链接验证有效性
- [ ] 检查代码块的语法高亮
- [ ] 确认格式一致性

### 功能验证

**建议用户使用 optimize-skill 进行**：

1. 触发率测试：验证 description 修改的效果
2. 输出质量测试：验证指令改进的效果
3. 边界情况测试：验证新增的边界处理
4. 综合评估：生成改进报告

### 用户反馈循环

**收集反馈**：

1. 询问用户对改进的满意度
2. 观察使用情况的变化
3. 记录新的纠正或建议
4. 持续迭代改进

## 总结

反馈应用的关键原则：

1. **系统化决策**：使用决策树确定修改位置
2. **保持简洁**：遵循渐进式披露原则
3. **避免重复**：维护单一真相源
4. **维护引用**：确保所有链接有效
5. **验证一致性**：风格、术语、格式统一
6. **持续改进**：形成反馈→应用→验证的闭环

通过规范化的应用流程，确保每一次改进都能高质量地融入技能中。
