@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
echo ====================================
echo   Agent Skills 安装程序
echo ====================================
echo.

REM 检查源目录是否存在
if not exist "skills" (
    echo [错误] skills 目录不存在！
    pause
    exit /b 1
)

REM 创建目标目录
if not exist ".agents\skills" (
    mkdir ".agents\skills"
    echo [信息] 已创建目标目录: .agents\skills
)

echo [信息] 开始安装技能...
echo.

REM 动态遍历 skills 目录中的所有技能
set SKILL_COUNT=0
for /d %%D in (skills\*) do (
    set SKILL_NAME=%%~nxD
    echo [信息] 处理技能: !SKILL_NAME!
    
    REM 如果目标已存在，先删除
    if exist ".agents\skills\!SKILL_NAME!" (
        echo [警告] 发现已存在的 !SKILL_NAME!，正在删除...
        rmdir /s /q ".agents\skills\!SKILL_NAME!"
    )
    
    REM 尝试创建目录联接
    mklink /J ".agents\skills\!SKILL_NAME!" "%cd%\skills\!SKILL_NAME!" >nul 2>&1
    if %errorlevel% equ 0 (
        echo [成功] 已创建目录联接: !SKILL_NAME!
        set /a SKILL_COUNT+=1
    ) else (
        echo [失败] 无法为 !SKILL_NAME! 创建联接，尝试复制...
        xcopy /E /I /Y "skills\!SKILL_NAME!" ".agents\skills\!SKILL_NAME!" >nul
        echo [成功] 已复制: !SKILL_NAME!
        set /a SKILL_COUNT+=1
    )
)

echo.
echo ====================================
echo   安装完成！
echo ====================================
echo.
echo 技能已安装到: .agents\skills
echo 共安装 %SKILL_COUNT% 个技能
echo.
echo 可用的技能:
dir /b ".agents\skills"
echo.
pause
