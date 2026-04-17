# 技能安装说明

## 什么是符号链接？

符号链接（Symbolic Link）是一种特殊的文件，它指向另一个文件或目录。使用符号链接的好处是：

1. **实时同步**：当你修改 `skills/` 目录中的技能文件时，`.agents/skills/` 中的链接会自动反映这些更改
2. **节省空间**：不需要复制文件，只创建链接
3. **便于开发**：在开发过程中可以即时看到更改效果

## 安装方法

### Windows 用户

#### 方法一：双击运行（最简单）

直接双击 `scripts/install-skills.bat` 文件即可。

#### 方法二：PowerShell

```powershell
.\scripts\install-skills.ps1
```

### Linux/Mac 用户

```bash
chmod +x scripts/install-skills.sh
./scripts/install-skills.sh
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

A: 运行 `scripts/uninstall-skills.bat`（Windows）或删除 `.agents/skills` 目录下的链接。

### Q: 符号链接和硬链接有什么区别？

A:

- **符号链接**：指向路径的快捷方式，可以跨文件系统
- **硬链接/目录联接**：直接指向文件的 inode，只能在同一文件系统内
- 本脚本在 Windows 上使用目录联接（Junction），在 Linux/Mac 上使用符号链接

### Q: 为什么不用直接复制？

A: 直接复制会导致两份独立的文件，修改一处不会影响另一处，不利于开发和测试。
