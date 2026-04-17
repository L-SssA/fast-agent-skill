@echo off
setlocal enabledelayedexpansion
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

set INSTALLED_COUNT=0
set TOTAL_COUNT=0

REM 统计源目录中的技能总数
for /d %%D in (skills\*) do (
    set /a TOTAL_COUNT+=1
)

REM 动态检查每个已安装的技能
for /d %%D in (.agents\skills\*) do (
    set SKILL_NAME=%%~nxD
    echo [✓] !SKILL_NAME! - 已安装
    set /a INSTALLED_COUNT+=1
)

echo.
echo ====================================
echo   验证结果
echo ====================================
echo 已安装技能数: %INSTALLED_COUNT%/%TOTAL_COUNT%
echo.

if %INSTALLED_COUNT% equ %TOTAL_COUNT% (
    echo [成功] 所有技能已正确安装！
    echo.
    echo 你可以在代理会话中使用 /skills 命令来查看可用技能。
) else if %INSTALLED_COUNT% gtr 0 (
    echo [警告] 部分技能未安装，请运行 install-skills.bat 重新安装。
) else (
    echo [错误] 没有安装任何技能，请运行 install-skills.bat 进行安装。
)

echo.
pause
