@echo off
chcp 65001 >nul
echo ====================================
echo   Agent Skills 安装验证
echo ====================================
echo.

REM 检查目标目录是否存在
if not exist ".agents\skills" (
    echo [错误] 技能目录不存在！
    echo 请先运行 install-skills.bat 安装技能。
    pause
    exit /b 1
)

echo [信息] 检查已安装的技能...
echo.

set SKILL_COUNT=0

REM 检查 create-skill
if exist ".agents\skills\create-skill" (
    echo [✓] create-skill - 已安装
    set /a SKILL_COUNT+=1
) else (
    echo [✗] create-skill - 未安装
)

REM 检查 optimize-skill
if exist ".agents\skills\optimize-skill" (
    echo [✓] optimize-skill - 已安装
    set /a SKILL_COUNT+=1
) else (
    echo [✗] optimize-skill - 未安装
)

echo.
echo ====================================
echo   验证结果
echo ====================================
echo 已安装技能数: %SKILL_COUNT%/2
echo.

if %SKILL_COUNT% equ 2 (
    echo [成功] 所有技能已正确安装！
    echo.
    echo 你可以在代理会话中使用 /skills 命令来查看可用技能。
) else (
    echo [警告] 部分技能未安装，请运行 install-skills.bat 重新安装。
)

echo.
pause
