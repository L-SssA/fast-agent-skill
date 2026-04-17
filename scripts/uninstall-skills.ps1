# 卸载技能脚本 - 移除 .agents/skills 目录中的所有技能链接

Write-Host "开始卸载技能..." -ForegroundColor Green

# 定义目标目录
$TargetDir = ".\.agents\skills"

# 检查目标目录是否存在
if (-not (Test-Path $TargetDir)) {
    Write-Host "信息: 技能目录不存在，无需卸载" -ForegroundColor Yellow
    exit 0
}

# 统计卸载数量
$UninstallCount = 0

# 遍历并删除所有技能
Get-ChildItem -Path $TargetDir -Directory | ForEach-Object {
    $SkillName = $_.Name
    try {
        Remove-Item -Path $_.FullName -Recurse -Force
        Write-Host "已卸载: $SkillName" -ForegroundColor Cyan
        $UninstallCount++
    }
    catch {
        Write-Host "警告: 无法卸载 $SkillName - $_" -ForegroundColor Yellow
    }
}

Write-Host "`n技能卸载完成！" -ForegroundColor Green
Write-Host "共卸载 $UninstallCount 个技能" -ForegroundColor Cyan
