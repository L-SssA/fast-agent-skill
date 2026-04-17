# Agent Skills Framework

一个标准化的技能框架，用于辅助创建、维护及优化 Agent Skills。

## 已完成功能

本技能包目前已实现以下核心功能：

1. **创建/初始化技能** (`create-skill`)：根据提供的信息，结合官方标准创建一个符合官方标准的技能。
2. **优化技能** (`optimize-skill`)：对现有技能进行评估、测试和优化，提升技能性能和效果。

## 快速启动

**环境要求**：需要支持 Agent Skills 的环境。

**安装步骤**：

### 方法一：使用安装脚本（推荐）

#### Windows (双击运行)

直接双击 `scripts/install-skills.bat` 文件即可自动安装。

#### Windows (PowerShell)

```powershell
# 在项目根目录运行
.\scripts\install-skills.ps1
```

#### Linux/Mac (Bash)

```bash
# 在项目根目录运行
chmod +x scripts/install-skills.sh
./scripts/install-skills.sh
```

### 方法二：手动创建符号链接

#### Windows (需要管理员权限或开发者模式)

```powershell
# 创建目标目录
mkdir .\.agents\skills

# 为每个技能创建符号链接
New-Item -ItemType SymbolicLink -Path ".\.agents\skills\create-skill" -Target ".\skills\create-skill"
New-Item -ItemType SymbolicLink -Path ".\.agents\skills\optimize-skill" -Target ".\skills\optimize-skill"
```

#### Linux/Mac

```bash
# 创建目标目录
mkdir -p ./.agents/skills

# 为每个技能创建符号链接
ln -s $(pwd)/skills/create-skill ./.agents/skills/create-skill
ln -s $(pwd)/skills/optimize-skill ./.agents/skills/optimize-skill
```

### 方法三：直接复制

如果不支持符号链接，可以直接复制 skills 目录：

```bash
cp -r skills/* .agents/skills/
```

**验证安装**：

方法一：使用验证脚本

- Windows: 双击运行 `scripts/verify-installation.bat`
- Linux/Mac: 检查 `.agents/skills` 目录

方法二：在代理中验证
在代理会话中使用 `/skills` 命令，确认 `create-skill` 和 `optimize-skill` 出现在列表中。

**卸载技能**：

- Windows: 双击运行 `scripts/uninstall-skills.bat`
- Linux/Mac: 删除 `.agents/skills` 目录下的符号链接

**开始使用**：

快速体验创建一个简单技能：

```markdown
用户: "帮我创建一个掷骰子的技能"

智能体将引导您：

1. 确认需求（骰子类型、输出格式等）
2. 创建目录结构和 SKILL.md
3. 编写基础指令和示例
```

详细教程请查看 [完整工作流程教程](docs/workflow-examples.md)。

## 规划中的功能

以下功能正在规划或开发中：

1. **添加知识**：将提供的资料提炼出有用的信息并添加到技能包中。
2. **反馈机制**：将使用技能的对话中用户纠正智能体的内容反思是否是技能描述导致的，然后尝试更新技能。

## 目录结构

```
.
├── skills/          # 技能定义文件
│   ├── create-skill/    # 创建新技能的技能
│   └── optimize-skill/  # 优化现有技能的技能
├── scripts/         # 安装和管理脚本
├── docs/            # 文档和指南
├── README.md        # 项目说明
├── LICENSE          # 开源许可证
└── .gitignore       # Git 忽略配置
```

## 许可证

详见 [LICENSE](LICENSE) 文件
