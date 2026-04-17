---
name: optimize-skill
description: 优化和改进现有 Agent Skills 的质量、描述准确性和性能。当用户需要提升技能触发率、应用最佳实践、或进行系统化测试验证时使用此技能。支持描述优化、指令改进和评估测试。
license: MIT
metadata:
  author: fast-agent-skill
  version: "1.0"
---

# Optimize Skill - 技能优化助手

本技能用于指导用户优化和改进现有的 Agent Skills，提升其质量、触发准确性和整体性能。

## 前置条件

使用本技能前，确保：

- 已有基础的技能框架（如通过 create-skill 创建）
- 技能可以正常加载和激活
- 有明确的优化目标（如提高触发率、改善输出质量等）

**如果是从零开始创建技能**，请先使用 create-skill 技能搭建基础框架。

## 使用流程

1. **了解现状**: 询问用户要优化哪个技能，当前存在什么问题
2. **选择优化方向**:
   - 优化描述 → 参考 [description-optimization.md](references/description-optimization.md)
   - 应用最佳实践 → 参考 [best-practices.md](references/best-practices.md)
   - 测试验证 → 参考 [evaluation-testing.md](references/evaluation-testing.md)
3. **执行优化**: 加载对应的参考文档，按步骤引导用户改进技能
4. **迭代改进**: 根据测试结果持续优化

## 关键能力摘要

### 描述优化

- 系统化测试和提升 description 字段的触发准确性
- 设计评估查询集（应触发/不应触发）
- 训练/验证集划分避免过拟合
- 优化循环：评估 → 识别失败 → 修订 → 重复

### 最佳实践应用

- 从真实经验出发提取模式
- 明智地使用上下文（添加代理缺乏的，省略已知的）
- 校准控制级别（自由度 vs 规定性）
- 有效指令模式（Gotchas、模板、清单、验证循环等）

### 评估测试

- 触发率评估：多次运行计算触发率
- 输出质量评估：设计测试用例、定义评分标准
- 自动化验证脚本框架
- 综合评估报告生成

### 持续改进

- 基于反馈迭代表现
- 维护测试用例集
- 跟踪技能演进历史

## 何时加载详细指南

根据用户需求判断优化方向并加载对应文档：

- **优化技能描述** → 读取 [`references/description-optimization.md`](references/description-optimization.md)
  - 包含描述优化策略、评估查询设计、训练/验证集划分、优化循环、自动化脚本

- **应用最佳实践** → 读取 [`references/best-practices.md`](references/best-practices.md)
  - 包含从真实经验出发、上下文管理、控制级别校准、有效指令模式（Gotchas、模板、清单等）

- **测试验证技能** → 读取 [`references/evaluation-testing.md`](references/evaluation-testing.md)
  - 包含触发率评估、输出质量评估、自动化脚本、综合报告、最佳实践

- **需要评估脚本模板** → 参考 [`assets/eval-script-template.sh`](assets/eval-script-template.sh)
  - 提供可定制的 Bash 评估脚本框架

## 优化检查清单

在完成优化后，确认：

- [ ] Description 使用祈使句并关注用户意图
- [ ] Description 覆盖边界情况且长度 < 1024 字符
- [ ] 进行了至少 3-5 轮描述优化迭代
- [ ] 使用了训练/验证集划分避免过拟合
- [ ] 添加了代理不知道的关键信息（Gotchas 等）
- [ ] 删除了代理已知的冗余内容
- [ ] 提供了默认方案而非菜单式选项
- [ ] 使用了适当的指令模式（模板、清单、验证循环等）
- [ ] SKILL.md 保持简洁（< 500 行）
- [ ] 进行了触发率测试和输出质量评估

## 常见优化场景

### 场景 1：技能触发率低

**问题**：技能很少被代理激活  
**解决方案**：

1. 加载 description-optimization.md
2. 设计评估查询集
3. 执行优化循环
4. 扩大描述范围或添加关键词

### 场景 2：技能误触发

**问题**：技能在不相关场景下被激活  
**解决方案**：

1. 加载 description-optimization.md
2. 识别误触发的查询模式
3. 增加描述特异性
4. 澄清技能边界

### 场景 3：输出质量不稳定

**问题**：技能产生的结果不一致或不准确  
**解决方案**：

1. 加载 best-practices.md
2. 应用有效指令模式（模板、清单、验证循环）
3. 添加 Gotchas 章节
4. 提供清晰的输出格式示例

### 场景 4：技能效率低

**问题**：代理执行任务时步骤冗余或方法不当  
**解决方案**：

1. 加载 best-practices.md
2. 提供默认方案而非多个选项
3. 捆绑可复用脚本到 scripts/
4. 优化指令减少不必要的步骤

## 工作流程示例

```
用户: "我的 CSV 分析技能触发率很低，很多相关查询都没激活"

你:
1. 了解当前 description 内容和典型失败案例
2. 加载 references/description-optimization.md
3. 帮助设计评估查询集（应触发/不应触发）
4. 指导执行优化循环
5. 建议使用 evaluation-testing.md 进行系统化测试
6. 根据测试结果进一步调整
```

记住：你的目标是帮助用户**系统化地提升技能质量**。优化是一个迭代过程，需要持续测试和改进。

## 与 create-skill 的关系

- **create-skill**：专注于从零创建符合标准的基础框架
- **optimize-skill**：专注于优化和改进现有技能的质量

**典型工作流**：

1. 使用 create-skill 创建基础框架
2. 使用 optimize-skill 优化描述和质量
3. 使用 optimize-skill 进行测试验证
4. 根据测试结果迭代改进

两个技能协同工作，覆盖技能的完整生命周期。
