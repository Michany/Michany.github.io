---
layout: post
title: "[Ubuntu] 部署SeaCloud私有云盘"
subtitle: "How to deploy SeaCloud Private Drive"
author: "Michael Wang"
header-img: "img/post-bg-SeaCloud.jpg"
header-mask: 0.3
tags:
  - Ubuntu
---
## 什么是SeaCloud?
SeaCloud是一个有国内团队开发的云存储解决方案。SeaCloud可以基于MySQL数据库，主要包括SeaFile和SeaHub两个模块，还可以配合Nginx进行SSL认证。  

支持的操作系统：
- Debian
- Ubuntu LTS
- CentOS
- Raspbian (Raspberry Pi)
- Docker (Linux & Windows)

*本文参考：[SeaCloud官方社区英文文档](https://seafile.readthedocs.io/en/latest/installation/seafile/)*

*本文环境：Ubuntu 18.04 64bit 阿里云HK*


## 准备环境
### MySQL-Server (必须，也可以使用其他数据库)
``apt-get update && apt-get install mysql-server``

### Python 2.7 (必须)
``apt-get install python-setuptools python-pil python-ldap python-mysqldb python-memcache python-urllib3``

### Nginx(可选)




## 下载安装SeaCloud
*以下命令默认均在root权限下进行*
### 下载安装最新版SeaCloud

最新版本号问7.0.5，可以替换  
``mkdir /opt/seafile/installed``  
``wget -P /opt/seafile/installed https://download.seadrive.org/seafile-server_7.0.5_x86-64.tar.gz``

解压  
``tar -xz -C /opt/seafile -f /opt/seafile/installed/seafile-server_*``
### 创建用户，用于配置和执行服务端程序
``mkdir /opt/seafile``   
添加名为seafserver（可以自己修改）的新用户，用户目录指定为`/opt/seafile`  
``useradd -U -m -d /opt/seafile seafserver``
### 配置SeaCloud
创建文件目录，放置网盘文件  
```mkdir /srv/seafile-data```

运行安装脚本  
``/bin/bash /opt/seafile/seafile-server-*/setup-seafile-mysql.sh``

将目录所有权授予给seafserver用户  
``chown -R seafserver:seafserver /opt/seafile  /srv/seafile-data``

切换到seafserver用户  
`su -l seafserver`

启动服务（首次启动会要求输入admin帐号密码）
```bash
seafile-server-latest/seafile.sh start
seafile-server-latest/seahub.sh start
```

### 修改关键配置
**这一步极为重要，不修改很可能出现web界面“connection refused”的问题！**
`vim /opt/seafile/conf/gunicorn.conf`

将其中一行改为，问题解决！  
`bind = "0.0.0.0:8000"`


### 后续配置
#### 使用memcached加快加载速度
`apt-get install memcached`

然后打开 `vim /opt/seafile/conf/seahub_settings.py`，在尾部添加

``` py
CACHES = {
    'default': {
        'BACKEND': 'django_pylibmc.memcached.PyLibMCCache',
        'LOCATION': '127.0.0.1:11211',
    },
    'locmem': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
    },
}
```
重启即可看到效果，载入速度明显加快。

#### 添加服务，方便启动/停止SeaCloud  
`vim /etc/systemd/system/seafile.service`
```bash
[Unit]
Description=Seafile
After=network.target mysql.service
[Service]
Type=oneshot
ExecStart=/opt/seafile/seafile-server-latest/seafile.sh start
ExecStop=/opt/seafile/seafile-server-latest/seafile.sh stop
RemainAfterExit=yes
User=seafserver
Group=seafserver
[Install]
WantedBy=multi-user.target
```

`vim /etc/systemd/system/seahub.service`
```bash
[Unit]
Description=Seafile hub
After=network.target seafile.service
[Service]
ExecStart=/opt/seafile/seafile-server-latest/seahub.sh start
ExecStop=/opt/seafile/seafile-server-latest/seahub.sh stop
User=seafserver
Group=seafserver
Type=oneshot
RemainAfterExit=yes
[Install]
WantedBy=multi-user.target
```

重新载入服务
`systemctl daemon-reload`

接下来，就可以用下列命令轻松开启/结束SeaCloud了
```bash
systemctl start seafile
systemctl start seahub

systemctl stop seahub
systemctl stop seafile
```

如果遇到报错：  
*The name org.freedesktop.PolicyKit1 was not provided by any .service files*   
手动 `apt install policykit-1` 安装即可


