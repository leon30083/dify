@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ========================================
echo           重启 Dify 服务
echo ========================================
echo.

:: 检查Docker是否运行
echo [1/5] 检查Docker服务状态...
docker version >nul 2>&1
if !errorlevel! neq 0 (
    echo ❌ 错误: Docker未运行或未安装
    echo 请确保Docker Desktop已启动
    pause
    exit /b 1
)
echo ✅ Docker服务正常

:: 切换到docker目录
echo [2/5] 切换到Dify docker目录...
cd /d "%~dp0docker"
if !errorlevel! neq 0 (
    echo ❌ 错误: 无法找到docker目录
    echo 请确保脚本位于Dify项目根目录
    pause
    exit /b 1
)
echo ✅ 目录切换成功

:: 检查配置文件
echo [3/5] 检查配置文件...
if not exist "docker-compose.yaml" (
    echo ❌ 错误: 找不到docker-compose.yaml文件
    echo 请确保在正确的Dify项目目录中
    pause
    exit /b 1
)
echo ✅ 配置文件存在

:: 停止现有服务
echo [4/5] 停止现有服务...
echo 正在停止所有容器...
docker-compose down
if !errorlevel! neq 0 (
    echo ⚠️  警告: 停止服务时出现问题，继续重启流程
)
echo ✅ 服务已停止

:: 等待一下确保完全停止
echo 等待服务完全停止...
timeout /t 3 /nobreak >nul

:: 启动服务
echo [5/5] 启动Dify服务...
echo 正在启动所有容器，请稍候...
docker-compose up -d
if !errorlevel! neq 0 (
    echo ❌ 错误: 服务启动失败
    echo 请检查Docker日志获取详细信息
    pause
    exit /b 1
)

echo.
echo ✅ Dify服务重启成功！
echo.
echo 📋 服务信息:
echo    - Web界面: http://localhost
echo    - 安装页面: http://localhost/install
echo    - API地址: http://localhost/v1
echo.
echo 💡 提示: 重启后可能需要几分钟来完全加载
echo 💡 提示: 使用 status-dify.bat 检查服务状态
echo.
pause