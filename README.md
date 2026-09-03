# Sun-Panel 飞牛原生应用 (FPK)

本应用基于 **[conversun/fnos-apps](https://github.com/conversun/fnos-apps)** 项目中的 Sun-Panel 适配，进行了功能增强（**自动创建 Docker socket 软链接并配置环境变量**），让你在飞牛系统中轻松管理导航面板，并集成了 Docker 管理功能。

## 功能特点

- **原生飞牛应用**：直接安装 `.fpk` 包，无缝融入飞牛应用中心。
- **Docker 管理器集成**：开箱即用，可在 Sun-Panel 中管理飞牛主机的 Docker 容器。
- **自动软链接**：安装时自动在应用数据目录创建 `docker.sock` 软链接，并设置 `DOCKER_HOST` 环境变量。
- **权限提示明确**：安装后需用户手动完成权限配置（推荐加入 `docker` 组），以保障安全性与功能可用。
- **轻量 & 高效**：直接使用官方预编译二进制，保持原版性能。

## 安装

1. 从本仓库的 [Releases](https://github.com/你的用户名/fnos-apps/releases) 下载最新 `.fpk` 文件。
2. 在飞牛 fnOS 应用中心，点击“手动安装”，上传 `.fpk` 文件。
3. 按照提示完成安装。

安装完成后，应用会自动在 `/volX/@appdata/sun-panel/` 目录下创建 `docker.sock` 软链接，指向宿主机的 `/var/run/docker.sock`，并自动设置 `DOCKER_HOST` 环境变量。

## Docker 管理器权限配置

Sun-Panel 以系统用户 `sun-panel` 运行，默认情况下没有权限访问 Docker socket。你需要**手动**完成以下任一种配置，才能使 Docker 功能正常工作。

### 推荐方案（安全，建议优先）

将 `sun-panel` 用户加入 `docker` 组，这样无需修改 socket 权限，保持系统安全性。

1. 通过 SSH 登录飞牛系统。
2. 执行以下命令：
   ```bash
   sudo usermod -aG docker sun-panel
   ```
   如果 `sudo` 不可用，先切换至 root 用户：
   ```bash
   su -
   usermod -aG docker sun-panel
   exit
   ```
3. **重启 Sun-Panel 应用**（或在飞牛应用中心停止再启动），或重启整个 NAS 使组变更生效。

### 备选方案（临时开放权限，不推荐）

如果因某些原因无法将用户加入 `docker` 组，你也可以通过修改权限临时开放访问（安全性降低，任何本地用户都能控制 Docker）。

请**同时**对以下两个文件执行 `chmod 666`：
- 宿主机 Docker socket：`/var/run/docker.sock`
- 应用数据目录下的软链接：`/volX/@appdata/sun-panel/docker.sock`（将 `volX` 替换为实际存储卷）

```bash
sudo chmod 666 /var/run/docker.sock
sudo chmod 666 /volX/@appdata/sun-panel/docker.sock
```

> **注意**：软链接的权限本身不影响访问，但为了与系统 socket 保持一致，建议同时修改。该操作在系统重启后可能失效，需重新执行。

完成配置后，刷新 Sun-Panel 页面，Docker 管理器即可正常使用。

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
