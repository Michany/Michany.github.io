---
layout: post
title: "[Ubuntu] SS服务器配置和自启动"
subtitle: "How to run and config Shadowsocks on Ubuntu Server"
author: "Michael Wang"
header-img: "img/post-bg-css.jpg"
header-mask: 0.3
tags:
  - Ubuntu
  - Python
---

## 下载安装
### 环境
Ubuntu 18.04 64bit 阿里云HK
### 安装 Python 3 pip
```sudo apt install python3-pip```
### 安装 Shadowsocks
```sudo pip3 install shadowsocks```

## 配置文件
在/etc目录下建立一个新目录：shadowsocks，并在其下创建一个配置文件：config.json
```shell
mkdir /etc/shadowsocks
vim /etc/shadowsocks/config.json
```
### 配置参考
```
{
    "server":"填写服务器ip",
    "server_port":8388,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"填写连接密码",
    "timeout":300,
    "method":"aes-256-cfb"
}
```
### 启动Shadowsocks
ssserver -c /etc/shadowsocks.json -d start

## 开机启动
阿里云服务器有些特殊，需要加很多操作才可添加开机启动，而且实测开机启动这个程序需要等2分钟左右。
### 添加开机启动项目
创建并编辑开机项  
```sudo vim /etc/rc.local```

内容如下
```
#!/bin/sh
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

touch /var/lock/subsys/local

# 启动Shadowsocks服务
sudo ssserver -c /etc/shadowsocks/config.json -d start

exit 0
```

### 添加可执行权限
```chmod +x /etc/rc.local```

重启即可查看效果。

