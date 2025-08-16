@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ========================================
echo           停止 Dify 服务
echo ========================================
echo.

:: 检查Docker是否运行
echo [1/3] 检查Docker服务状态...
docker version >nul 2>&1
if !errorlevel! neq 0 (
    echo ❌ 错误: Docker未运行或未安装
    echo 请确保Docker Desktop已启动
    pause
    exit /b 1
)
echo ✅ Docker服务正常

:: 切换到docker目录
echo [2/3] 切换到Dify docker目录...
cd /d "%~dp0docker"
if !errorlevel! neq 0 (
    echo ❌ 错误: 无法找到docker目录
    echo 请确保脚本位于Dify项目根目录
    pause
    exit /b 1
)
echo ✅ 目录切换成功

:: 停止服务
echo [3/3] 停止Dify服务...
echo 正在停止所有容器，请稍候...
docker-compose down
if !errorlevel! neq 0 (
    echo ⚠️  警告: 部分服务停止时出现问题
    echo 这可能是因为某些容器已经停止
) else (
    echo ✅ Dify服务停止成功！
)

echo.
echo 📋 操作完成:
echo    - 所有Dify容器已停止
echo    - 网络连接已断开
echo    - 数据卷已保留（数据不会丢失）
echo.
echo 💡 提示: 数据和配置文件已安全保存
echo 💡 提示: 使用 start-dify.bat 重新启动服务
echo.
pause