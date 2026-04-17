# 验证技能安装脚本 - 检查 .agents/skills 目录中的技能安装状态

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "  Agent Skills 安装验证" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# 定义源目录和目标目录
$SourceDir = ".\skills"
$TargetDir = ".\.agents\skills"

# 检查目标目录是否存在
if (-not (Test-Path $TargetDir)) {
    Write-Host "[错误] 技能目录不存在！" -ForegroundColor Red
    Write-Host "请先运行 install-skills.ps1 安装技能。" -ForegroundColor Yellow
    exit 1
}

Write-Host "[信息] 检查已安装的技能..." -ForegroundColor Green
Write-Host ""

# 统计源目录中的技能总数
$TotalCount = 0
if (Test-Path $SourceDir) {
    $TotalCount = (Get-ChildItem -Path $SourceDir -Directory).Count
}

# 统计已安装的技能数量
$InstalledCount = 0
$InstalledSkills = Get-ChildItem -Path $TargetDir -Directory

foreach ($Skill in $InstalledSkills) {
    Write-Host "[✓] $($Skill.Name) - 已安装" -ForegroundColor Green
    $InstalledCount++
}

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "  验证结果" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "已安装技能数: $InstalledCount/$TotalCount" -ForegroundColor White
Write-Host ""

if ($InstalledCount -eq $TotalCount) {
    Write-Host "[成功] 所有技能已正确安装！" -ForegroundColor Green
    Write-Host ""
    Write-Host "你可以在代理会话中使用 /skills 命令来查看可用技能。" -ForegroundColor Cyan
}
elseif ($InstalledCount -gt 0) {
    Write-Host "[警告] 部分技能未安装，请运行 install-skills.ps1 重新安装。" -ForegroundColor Yellow
}
else {
    Write-Host "[错误] 没有安装任何技能，请运行 install-skills.ps1 进行安装。" -ForegroundColor Red
}

Write-Host ""
