# 技能安装说明

## 什么是符号链接？

符号链接（Symbolic Link）是一种特殊的文件，它指向另一个文件或目录。使用符号链接的好处是：

1. **实时同步**：当你修改 `skills/` 目录中的技能文件时，`.agents/skills/` 中的链接会自动反映这些更改
2. **节省空间**：不需要复制文件，只创建链接
3. **便于开发**：在开发过程中可以即时看到更改效果

## 安装方法

### 使用统一的 Python 脚本（跨平台）

这是最简单且最可靠的方法，适用于所有平台（Windows、Linux、Mac）。

```bash
# 使用 uv 运行（推荐）
uv run scripts/manage-skills.py install

# 或者直接使用 Python
python scripts/manage-skills.py install
```

**可用命令：**

- `install` - 安装所有技能
- `uninstall` - 卸载所有技能
- `verify` - 验证技能安装状态

**可选参数：**

- `--target`, `-t` - 指定目标目录（默认：`.agents/skills`）
- `--skills`, `-s` - 指定要操作的技能名称列表（默认：所有技能）

**示例：**

```bash
# 安装所有技能到默认目录
uv run scripts/manage-skills.py install

# 安装指定技能
uv run scripts/manage-skills.py install --skills create-skill optimize-skill

# 安装到指定目录
uv run scripts/manage-skills.py install --target /path/to/skills

# 同时指定技能和目录
uv run scripts/manage-skills.py install --skills feedback-skill --target /custom/path

# 验证安装
uv run scripts/manage-skills.py verify

# 验证指定目录
uv run scripts/manage-skills.py verify --target /path/to/skills

# 卸载指定技能
uv run scripts/manage-skills.py uninstall --skills feedback-skill

# 卸载所有技能
uv run scripts/manage-skills.py uninstall
```

## 注意事项

### Windows 符号链接权限

在 Windows 上创建符号链接可能需要：

- **管理员权限**：以管理员身份运行命令提示符或 PowerShell
- **开发者模式**：在 Windows 设置中启用"开发者模式"

如果无法创建符号链接，脚本会自动降级为复制文件模式。

### 验证安装

安装完成后，可以检查链接是否正确创建：

```powershell
# Windows
dir .agents\skills

# 应该看到类似这样的输出：
# <JUNCTION> create-skill [C:\...\skills\create-skill]
# <JUNCTION> optimize-skill [C:\...\skills\optimize-skill]
```

```bash
# Linux/Mac
ls -la .agents/skills

# 应该看到类似这样的输出：
# lrwxrwxrwx create-skill -> /path/to/skills/create-skill
# lrwxrwxrwx optimize-skill -> /path/to/skills/optimize-skill
```

## 常见问题

### Q: 修改技能后需要重新安装吗？

A: 不需要！因为使用了符号链接，任何修改都会自动同步。

### Q: 如何卸载技能？

A: 使用统一脚本：`uv run scripts/manage-skills.py uninstall`

### Q: 符号链接和硬链接有什么区别？

A:

- **符号链接**：指向路径的快捷方式，可以跨文件系统
- **硬链接/目录联接**：直接指向文件的 inode，只能在同一文件系统内
- 本脚本在 Windows 上使用目录联接（Junction），在 Linux/Mac 上使用符号链接

### Q: 为什么不用直接复制？

A: 直接复制会导致两份独立的文件，修改一处不会影响另一处，不利于开发和测试。
