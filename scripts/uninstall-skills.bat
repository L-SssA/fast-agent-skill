@echo off
setlocal enabledelayedexpansion
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

REM 动态遍历并卸载所有技能
set UNINSTALL_COUNT=0
for /d %%D in (.agents\skills\*) do (
    set SKILL_NAME=%%~nxD
    echo [信息] 卸载技能: !SKILL_NAME!
    rmdir /s /q ".agents\skills\!SKILL_NAME!"
    if !errorlevel! equ 0 (
        echo [成功] 已卸载: !SKILL_NAME!
        set /a UNINSTALL_COUNT+=1
    ) else (
        echo [失败] 无法卸载: !SKILL_NAME!
    )
)

echo.
echo ====================================
echo   卸载完成！
echo ====================================
echo.
echo 共卸载 %UNINSTALL_COUNT% 个技能
echo.
pause
