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
# SERVER_PORT: ss服务端口，同时监听TCP和UDP，默认值6011
# PASSWORD: 连接密码，默认值ss-libev
# METHOD: 加密方式，默认值aes-256-gcm
# DNS_ADDR: DNS解析，默认值8.8.8.8
#
$ SERVER_PORT=8888 PASSWORD=hello_world make run
```
