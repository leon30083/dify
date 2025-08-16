@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ========================================
echo         Dify 服务状态检查
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

:: 检查容器状态
echo [3/4] 检查Dify容器状态...
echo.
echo 📋 容器状态详情:
echo ----------------------------------------
docker-compose ps
echo ----------------------------------------
echo.

:: 检查服务可访问性
echo [4/4] 检查服务可访问性...
echo.
echo 🌐 网络连接测试:
echo ----------------------------------------

:: 检查Web服务
echo 测试Web服务 (http://localhost)...
curl -s -o nul -w "%%{http_code}" http://localhost --connect-timeout 5
set web_status=!errorlevel!
if !web_status! equ 0 (
    echo ✅ Web服务: 可访问
) else (
    echo ❌ Web服务: 无法访问
)

:: 检查API服务
echo 测试API服务 (http://localhost/v1/health-check)...
curl -s -o nul -w "%%{http_code}" http://localhost/v1/health-check --connect-timeout 5
set api_status=!errorlevel!
if !api_status! equ 0 (
    echo ✅ API服务: 可访问
) else (
    echo ❌ API服务: 无法访问
)

echo ----------------------------------------
echo.

:: 显示资源使用情况
echo 💻 资源使用情况:
echo ----------------------------------------
docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}" | findstr dify
echo ----------------------------------------
echo.

:: 显示日志信息
echo 📝 最近日志 (最后10行):
echo ----------------------------------------
docker-compose logs --tail=10
echo ----------------------------------------
echo.

echo 📋 快速访问链接:
echo    - Web界面: http://localhost
echo    - 安装页面: http://localhost/install
echo    - API文档: http://localhost/v1/docs
echo.
echo 💡 提示: 如果服务无法访问，请使用 restart-dify.bat 重启
echo 💡 提示: 查看完整日志: docker-compose logs -f
echo.
pause