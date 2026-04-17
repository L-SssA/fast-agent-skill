# 安装技能脚本 - 使用符号链接将 skills 目录中的技能链接到 .local/agentskills 目录

Write-Host "开始安装技能..." -ForegroundColor Green

# 定义源目录和目标目录
$SourceDir = ".\skills"
$TargetDir = ".\.agents\skills"

# 检查源目录是否存在
if (-not (Test-Path $SourceDir)) {
    Write-Host "错误: 源目录 $SourceDir 不存在" -ForegroundColor Red
    exit 1
}

# 创建目标目录（如果不存在）
if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
}

# 遍历源目录中的所有技能
Get-ChildItem -Path $SourceDir -Directory | ForEach-Object {
    $SkillName = $_.Name
    $SourcePath = $_.FullName
    $TargetPath = Join-Path $TargetDir $SkillName
    
    # 如果目标已存在，先删除
    if (Test-Path $TargetPath) {
        Remove-Item -Path $TargetPath -Recurse -Force
        Write-Host "已移除现有的 $SkillName" -ForegroundColor Yellow
    }
    
    # 创建符号链接（需要管理员权限或开发者模式）
    try {
        New-Item -ItemType SymbolicLink -Path $TargetPath -Target $SourcePath -Force | Out-Null
        Write-Host "已创建符号链接: $SkillName -> $TargetPath" -ForegroundColor Cyan
    }
    catch {
        Write-Host "警告: 无法为 $SkillName 创建符号链接，尝试使用硬链接..." -ForegroundColor Yellow
        
        # 如果符号链接失败，尝试复制目录
        Copy-Item -Path $SourcePath -Destination $TargetPath -Recurse -Force
        Write-Host "已复制目录: $SkillName -> $TargetPath" -ForegroundColor Cyan
    }
}

Write-Host "`n技能安装完成！" -ForegroundColor Green
Write-Host "技能已链接到: $TargetDir" -ForegroundColor Cyan
Write-Host "`n可用技能列表:" -ForegroundColor Cyan
Get-ChildItem -Path $TargetDir -Directory | ForEach-Object {
    Write-Host "  - $($_.Name)" -ForegroundColor White
}