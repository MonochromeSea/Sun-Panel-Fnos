# SakuraFrp for fnOS

每日自动同步 [SakuraFrp](https://www.natfrp.com) 最新 Docker 镜像版本并构建 `.fpk` 安装包。

## 下载

从 [Releases](https://github.com/conversun/fnos-apps/releases?q=sakurafrp) 下载最新的 `.fpk` 文件。

## 安装

1. 根据设备架构下载对应的 `.fpk` 文件
2. fnOS 应用管理 → 手动安装 → 上传
3. 安装时填写访问密钥和远程管理密码

**访问地址**: `http://<NAS-IP>:7102`（Web UI，host 网络模式）

## 说明

- 免费内网穿透服务，解决无公网 IP 的问题
- 基于 Docker 部署，使用 host 网络模式
- 支持 TCP/UDP 隧道、HTTPS 穿透
- 支持远程管理面板，无需暴露 Web UI
- 多架构支持: x86 (amd64) + ARM (arm64)

## 获取访问密钥

1. 注册 [SakuraFrp 账号](https://www.natfrp.com/)
2. 登录后在管理面板点击「查看访问密钥」
3. 复制访问密钥填入安装向导

## 本地构建

```bash
cd apps/sakurafrp && bash ../../scripts/build-fpk.sh . app.tgz
```

## Credits

- [SakuraFrp](https://www.natfrp.com)
- [natfrp/launcher](https://hub.docker.com/r/natfrp/launcher)
- Resolves [Issue #124](https://github.com/conversun/fnos-apps/issues/124)
