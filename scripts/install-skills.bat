@echo off
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

REM 安装 create-skill
if exist ".agents\skills\create-skill" (
    echo [警告] 发现已存在的 create-skill，正在删除...
    rmdir /s /q ".agents\skills\create-skill"
)
mklink /J ".agents\skills\create-skill" "%cd%\skills\create-skill" >nul 2>&1
if %errorlevel% equ 0 (
    echo [成功] 已创建目录联接: create-skill
) else (
    echo [失败] 无法为 create-skill 创建联接，尝试复制...
    xcopy /E /I /Y "skills\create-skill" ".agents\skills\create-skill" >nul
    echo [成功] 已复制: create-skill
)

REM 安装 optimize-skill
if exist ".agents\skills\optimize-skill" (
    echo [警告] 发现已存在的 optimize-skill，正在删除...
    rmdir /s /q ".agents\skills\optimize-skill"
)
mklink /J ".agents\skills\optimize-skill" "%cd%\skills\optimize-skill" >nul 2>&1
if %errorlevel% equ 0 (
    echo [成功] 已创建目录联接: optimize-skill
) else (
    echo [失败] 无法为 optimize-skill 创建联接，尝试复制...
    xcopy /E /I /Y "skills\optimize-skill" ".agents\skills\optimize-skill" >nul
    echo [成功] 已复制: optimize-skill
)

echo.
echo ====================================
echo   安装完成！
echo ====================================
echo.
echo 技能已安装到: .agents\skills
echo.
echo 可用的技能:
dir /b ".agents\skills"
echo.
pause
