@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ========================================
echo           启动 Dify 服务
echo ========================================
echo.

:: 检查Docker是否运行
echo [1/4] 检查Docker服务状态...
docker version >nul 2>&1
if !errorlevel! neq 0 (
    echo ❌ 错误: Docker未运行或未安装
    echo 请确保Docker Desktop已启动
    pause
    exit /b 1
)
echo ✅ Docker服务正常

:: 切换到docker目录
echo [2/4] 切换到Dify docker目录...
cd /d "%~dp0docker"
if !errorlevel! neq 0 (
    echo ❌ 错误: 无法找到docker目录
    echo 请确保脚本位于Dify项目根目录
    pause
    exit /b 1
)
echo ✅ 目录切换成功

:: 检查docker-compose.yml文件
echo [3/4] 检查配置文件...
if not exist "docker-compose.yaml" (
    echo ❌ 错误: 找不到docker-compose.yaml文件
    echo 请确保在正确的Dify项目目录中
    pause
    exit /b 1
)
echo ✅ 配置文件存在

:: 启动服务
echo [4/4] 启动Dify服务...
echo 正在启动所有容器，请稍候...
docker-compose up -d
if !errorlevel! neq 0 (
    echo ❌ 错误: 服务启动失败
    echo 请检查Docker日志获取详细信息
    pause
    exit /b 1
)

echo.
echo ✅ Dify服务启动成功！
echo.
echo 📋 服务信息:
echo    - Web界面: http://localhost
echo    - 安装页面: http://localhost/install
echo    - API地址: http://localhost/v1
echo.
echo 💡 提示: 首次启动可能需要几分钟来初始化数据库
echo 💡 提示: 使用 status-dify.bat 检查服务状态
echo.
pause