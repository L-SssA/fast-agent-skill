# 技能安装工具包

本目录包含用于安装、卸载和验证 Agent Skills 的工具脚本。

## 文件说明

### 安装脚本

1. **install-skills.bat** (Windows)
   - 双击即可运行的批处理文件
   - 使用目录联接（Junction）创建符号链接
   - 如果无法创建链接，自动降级为复制模式
   - 支持中文输出

2. **install-skills.ps1** (Windows PowerShell)
   - PowerShell 版本的安装脚本
   - 尝试创建符号链接，失败则复制文件
   - 提供彩色输出

3. **install-skills.sh** (Linux/Mac)
   - Bash 脚本
   - 使用 `ln -s` 创建符号链接
   - 适用于 Unix-like 系统

### 卸载脚本

4. **uninstall-skills.bat** (Windows)
   - 删除已安装的技能链接或副本
   - 简单快捷的卸载方式

### 验证脚本

5. **verify-installation.bat** (Windows)
   - 检查技能是否正确安装
   - 显示安装状态和统计信息

### 文档

6. **INSTALL.md**
   - 详细的安装说明
   - 常见问题解答
   - 符号链接相关知识

## 快速开始

### Windows 用户

1. **安装**: 双击 `scripts/install-skills.bat`
2. **验证**: 双击 `scripts/verify-installation.bat`
3. **卸载**: 双击 `scripts/uninstall-skills.bat`

### Linux/Mac 用户

```bash
# 安装
chmod +x scripts/install-skills.sh
./scripts/install-skills.sh

# 验证
ls -la .agents/skills

# 卸载
rm -rf .agents/skills/*
```

## 工作原理

这些脚本会将 `skills/` 目录中的技能通过符号链接的方式安装到 `.agents/skills/` 目录中。

**优势：**

- ✅ 实时同步：修改源文件会立即反映在安装位置
- ✅ 节省空间：不复制文件，只创建链接
- ✅ 便于开发：开发和测试更加便捷

**注意：**

- `.agents/` 目录应在 `.gitignore` 中，不会被提交到 Git
- Windows 上可能需要管理员权限或启用开发者模式才能创建符号链接

## 故障排除

### Windows: 无法创建符号链接

**解决方案 1**: 以管理员身份运行

- 右键点击 `scripts/install-skills.bat`
- 选择“以管理员身份运行”

**解决方案 2**: 启用开发者模式

- 打开 Windows 设置
- 进入"更新和安全" > "开发者选项"
- 启用"开发者模式"

**解决方案 3**: 使用复制模式

- 脚本会自动降级为复制模式
- 虽然不能实时同步，但可以正常工作

### 技能未出现在代理中

1. 运行 `scripts/verify-installation.bat` 检查安装状态
2. 确认代理配置指向正确的技能目录
3. 重启代理会话

## 更多信息

详细文档请查看 [INSTALL.md](INSTALL.md)
