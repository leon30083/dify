# Dify 管理脚本使用说明

本项目包含了一套完整的 Dify 服务管理脚本，帮助您轻松管理 Dify 的启动、停止、重启和状态监控。

## 📁 脚本文件说明

### 🎯 主管理脚本
- **`manage-dify.bat`** - 主管理界面，提供菜单选择所有功能

### 🔧 功能脚本
- **`start-dify.bat`** - 启动 Dify 服务
- **`stop-dify.bat`** - 停止 Dify 服务
- **`restart-dify.bat`** - 重启 Dify 服务
- **`status-dify.bat`** - 检查服务状态和健康度

## 🚀 快速开始

### 方法一：使用主管理脚本（推荐）
1. 双击运行 `manage-dify.bat`
2. 根据菜单提示选择相应功能
3. 按照屏幕指示操作

### 方法二：直接运行功能脚本
- 启动服务：双击 `start-dify.bat`
- 停止服务：双击 `stop-dify.bat`
- 重启服务：双击 `restart-dify.bat`
- 查看状态：双击 `status-dify.bat`

## 📋 功能详解

### 🚀 启动服务 (start-dify.bat)
- 检查 Docker 服务状态
- 验证配置文件完整性
- 启动所有 Dify 容器
- 显示访问地址和端口信息

### 🛑 停止服务 (stop-dify.bat)
- 安全停止所有 Dify 容器
- 断开网络连接
- 保留数据卷（数据不会丢失）

### 🔄 重启服务 (restart-dify.bat)
- 先停止现有服务
- 等待完全停止后重新启动
- 适用于配置更改后的重启

### 📊 状态检查 (status-dify.bat)
- 显示所有容器运行状态
- 测试服务可访问性
- 显示资源使用情况
- 显示最近的日志信息

### 🎛️ 主管理界面 (manage-dify.bat)
- 菜单式操作界面
- 包含所有功能选项
- 实时日志查看
- Docker 资源清理

## 🌐 访问地址

启动成功后，您可以通过以下地址访问 Dify：

- **Web 界面**: http://localhost
- **安装页面**: http://localhost/install
- **API 接口**: http://localhost/v1
- **API 文档**: http://localhost/v1/docs

## ⚠️ 注意事项

### 系统要求
- Windows 10/11
- Docker Desktop 已安装并运行
- 至少 4GB 可用内存
- 至少 10GB 可用磁盘空间

### 使用建议
1. **首次启动**: 使用 `start-dify.bat` 启动服务
2. **日常管理**: 使用 `manage-dify.bat` 主界面
3. **故障排查**: 使用 `status-dify.bat` 检查状态
4. **配置更改**: 修改配置后使用 `restart-dify.bat`

### 常见问题

**Q: 脚本提示 "Docker未运行"**
A: 请确保 Docker Desktop 已启动并正常运行

**Q: 服务启动失败**
A: 检查端口是否被占用，确保 80 端口可用

**Q: 无法访问 Web 界面**
A: 等待几分钟让服务完全启动，或使用状态检查脚本诊断

**Q: 内存不足**
A: 关闭其他不必要的应用程序，或升级系统内存

## 🔧 高级功能

### 查看实时日志
```bash
# 在 docker 目录下执行
docker-compose logs -f
```

### 手动清理资源
```bash
# 清理未使用的 Docker 资源
docker system prune -f
```

### 重新构建镜像
```bash
# 在 docker 目录下执行
docker-compose build --no-cache
docker-compose up -d
```

## 📞 技术支持

如果遇到问题，请按以下步骤排查：

1. 运行 `status-dify.bat` 检查服务状态
2. 查看 Docker Desktop 是否正常运行
3. 检查系统资源使用情况
4. 查看详细日志信息

---

**提示**: 建议将这些脚本添加到桌面快捷方式，方便日常使用。