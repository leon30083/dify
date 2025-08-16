@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:menu
cls
echo ========================================
echo         Dify 服务管理工具
echo ========================================
echo.
echo 请选择操作:
echo.
echo [1] 🚀 启动 Dify 服务
echo [2] 🛑 停止 Dify 服务  
echo [3] 🔄 重启 Dify 服务
echo [4] 📊 查看服务状态
echo [5] 📝 查看实时日志
echo [6] 🧹 清理未使用的容器和镜像
echo [0] 🚪 退出
echo.
echo ========================================
set /p choice=请输入选项 (0-6): 

if "%choice%"=="1" goto start
if "%choice%"=="2" goto stop
if "%choice%"=="3" goto restart
if "%choice%"=="4" goto status
if "%choice%"=="5" goto logs
if "%choice%"=="6" goto cleanup
if "%choice%"=="0" goto exit

echo ❌ 无效选项，请重新选择
timeout /t 2 /nobreak >nul
goto menu

:start
echo.
echo 正在启动 Dify 服务...
call "%~dp0start-dify.bat"
goto menu

:stop
echo.
echo 正在停止 Dify 服务...
call "%~dp0stop-dify.bat"
goto menu

:restart
echo.
echo 正在重启 Dify 服务...
call "%~dp0restart-dify.bat"
goto menu

:status
echo.
echo 正在检查服务状态...
call "%~dp0status-dify.bat"
goto menu

:logs
echo.
echo 显示实时日志 (按 Ctrl+C 退出)...
echo ========================================
cd /d "%~dp0docker"
docker-compose logs -f
echo.
echo 按任意键返回主菜单...
pause >nul
goto menu

:cleanup
echo.
echo ========================================
echo           清理 Docker 资源
echo ========================================
echo.
echo ⚠️  警告: 此操作将清理未使用的Docker资源
echo 这包括:
echo   - 停止的容器
echo   - 未使用的网络
echo   - 未使用的镜像
echo   - 构建缓存
echo.
set /p confirm=确定要继续吗? (y/N): 
if /i not "%confirm%"=="y" (
    echo 操作已取消
    timeout /t 2 /nobreak >nul
    goto menu
)

echo.
echo 正在清理Docker资源...
docker system prune -f
echo ✅ 清理完成
echo.
echo 按任意键返回主菜单...
pause >nul
goto menu

:exit
echo.
echo 👋 感谢使用 Dify 服务管理工具！
echo.
exit /b 0