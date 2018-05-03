# Shadowsocks-libev

本仓库用于自动构建shadowsocks-libev的Docker Image。

## 如何使用

```sh
$ docker -v
Docker version 1.13.0, build 49bf474

# 编译Docker Image
#
# 编译指定版本: 
# $ VER=3.1.3 make
#
$ make

# 运行一个容器
# SERVER_PORT: ss服务端口，同时监听TCP和UDP
# PASSWORD: 连接密码
# [可选] METHOD: 加密方式，默认值可查看Dockerfile
#
$ SERVER_PORT=6011 PASSWORD=hello_ss make run
```
