# Sun-Panel 飞牛原生应用 (FPK)

本应用基于 **[conversun/fnos-apps](https://github.com/conversun/fnos-apps)** 项目中的 Sun-Panel 适配，进行了功能增强（如自动处理 Docker socket 权限），让你在飞牛系统中轻松管理导航面板，并集成了 Docker 管理功能。

## 功能特点

- **原生飞牛应用**：直接安装 `.fpk` 包，无缝融入飞牛应用中心。
- **Docker 管理器集成**：开箱即用，可在 Sun-Panel 中管理飞牛主机的 Docker 容器。
- **自动软链接**：安装时自动在应用数据目录创建 `docker.sock` 软链接，并设置 `DOCKER_HOST` 环境变量。
- **权限智能处理**：默认开放 Docker socket 权限（`chmod 666`）以简化使用，同时提供更安全的手动配置方案。
- **轻量 & 高效**：直接使用官方预编译二进制，保持原版性能。

## 安装

1. 从本仓库的 [Releases](https://github.com/你的用户名/fnos-apps/releases) 下载最新 `.fpk` 文件（或从原项目获取）。
2. 在飞牛 fnOS 应用中心，点击“手动安装”，上传 `.fpk` 文件。
3. 按照提示完成安装。

安装完成后，应用会自动在 `/volX/@appdata/sun-panel/` 目录下创建 `docker.sock` 软链接，指向宿主机的 `/var/run/docker.sock`，并自动设置 `DOCKER_HOST` 环境变量。

## Docker 管理器权限说明

Sun-Panel 以系统用户 `sun-panel` 运行，默认情况下没有权限访问 Docker socket。

- **自动方案（默认）**：本应用在安装脚本中自动执行 `chmod 666 /var/run/docker.sock`，开放所有用户的读写权限。这能保证开箱即用，但会降低系统安全性（任何本地用户均可控制 Docker）。  
  *建议在内网环境或可信设备上使用。*

- **推荐方案（更安全）**：你可以通过 SSH 登录飞牛，手动将 `sun-panel` 用户加入 `docker` 组，然后重启应用，即可移除 `666` 权限，改用更严格的 `660` 权限：
  ```bash
  sudo usermod -aG docker sun-panel
  # 然后重启 Sun-Panel 应用或重启 NAS
  ```
  恢复 socket 默认权限：
  ```bash
  sudo chmod 660 /var/run/docker.sock
  ```

## 手动更新

如需更新到新版本，只需在飞牛应用中心卸载旧版，再安装新版 `.fpk` 即可（应用数据会保留在 `/volX/@appdata/sun-panel/` 中）。

## 源码构建

如果你希望自行打包：

1. 克隆本仓库（或原项目）：
   ```bash
   git clone https://github.com/conversun/fnos-apps.git
   cd fnos-apps/apps/sun-panel
   ```
   *如果你有自己的 fork，可替换为你的仓库地址。*
2. 运行整合脚本（下载官方二进制并合并飞牛适配层）：
   ```bash
   ./update_sun-panel.sh
   ```
3. 使用 `fnpack` 打包：
   ```bash
   fnpack build
   ```
   生成的 `.fpk` 文件会在当前目录。

## 反馈与支持

- 本应用基于 Sun-Panel 官方项目，如有使用问题请参考 [Sun-Panel 文档](https://github.com/hslr-s/sun-panel)。
- 关于飞牛打包适配的问题，欢迎在本仓库提交 Issue，或向原项目 [conversun/fnos-apps](https://github.com/conversun/fnos-apps) 反馈。

## 致谢

- [Sun-Panel](https://github.com/hslr-s/sun-panel) 开发团队
- [conversun/fnos-apps](https://github.com/conversun/fnos-apps) 提供基础适配
- [飞牛 fnOS](https://www.fnnas.com/) 团队

---

**注意**：本应用仅供非商业用途使用，Sun-Panel 高级功能（如 Docker 管理器）可能需要遵守其闭源协议。
