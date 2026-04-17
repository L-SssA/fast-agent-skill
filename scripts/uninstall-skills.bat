@echo off
chcp 65001 >nul
echo ====================================
echo   Agent Skills 卸载程序
echo ====================================
echo.

REM 检查目标目录是否存在
if not exist ".agents\skills" (
    echo [信息] 技能目录不存在，无需卸载。
    pause
    exit /b 0
)

echo [信息] 开始卸载技能...
echo.

REM 卸载 create-skill
if exist ".agents\skills\create-skill" (
    rmdir /s /q ".agents\skills\create-skill"
    echo [成功] 已卸载: create-skill
) else (
    echo [信息] create-skill 不存在
)

REM 卸载 optimize-skill
if exist ".agents\skills\optimize-skill" (
    rmdir /s /q ".agents\skills\optimize-skill"
    echo [成功] 已卸载: optimize-skill
) else (
    echo [信息] optimize-skill 不存在
)

echo.
echo ====================================
echo   卸载完成！
echo ====================================
echo.
pause
