---
layout: post
title: "[QNAP] qBittorrent配置和RSS添加"
subtitle: "How to run and config qBittorrent on QNAP NAS"
author: "Michael Wang"
header-img: "img/post-bg-css.jpg"
header-mask: 0.3
catalog: true
tags:
  - Ubuntu
  - QNAP
---


## 下载安装
### 环境
QNAP TS-453Bmini QTS 4.4.3
### 安装 qBittorrent
有多种安装方法，可docker，这里选用最简单的：
- 去[qnap club](https://www.qnapclub.eu/en)下载安装包 [qBittorrent_4.2.5_x86_64.qpkg](https://www.qnapclub.eu/en/qpkg/358)
- 在App Center上手动安装
### 默认配置
安装后，默认登录密码adminadmin。

修改默认下载路径，要加`/share`前缀，否则提示空间不足。

## 配置RSS文件
如果能打开GUI界面，那可以直接在GUI添加；
如果是连了服务器，只能打开qbittorrent-nox和Web UI，那就需要用如下命令行方式添加RSS。

在普通Linux中，文件目录位于  
`cd /home/michael/.config/qBittorrent/`

在Qnap的Linux系统中，位于  
`cd /share/CACHEDEV1_DATA/.qpkg/qBittorrent/`

修改之前可以备份一下配置
`cp [原始文件] [原始文件.bak]`
### 1. 修改 qBittorrent.conf
```shell
vim .config/qBittorrent/qBittorrent.conf
```
增加：
```
[RSS]
AutoDownloader\EnableProcessing=false
Session\EnableProcessing=false
```
### 2. 修改 feeds.json
```shell
vim .config/qBittorrent/rss/feeds.json
```
增加RSS Feed，格式为：
```
{
    "Torrents Name": {
        "url": ""
    }
}
```
### 3. 修改 download_rules.json
```shell
vim .config/qBittorrent/rss/download_rules.json
```
添加自动下载规则，格式为：
```
{
    "下载规则名称": {
        "addPaused": null,
        "affectedFeeds": [
            "同Step2中url"
        ],
        "assignedCategory": "",
        "createSubfolder": null,
        "enabled": true,
        "episodeFilter": "",
        "ignoreDays": 0,
        "lastMatch": "",
        "mustContain": "",
        "mustNotContain": "",
        "previouslyMatchedEpisodes": [
        ],
        "savePath": "保存路径",
        "smartFilter": false,
        "useRegex": false
    }
}
```

重启qbittorrent，完事。

- 已经下载过的RSS会保存在
`.local/share/data/qBittorrent/rss/articles/`目录中

- 可以在如下路径查看log文件  
  `.local/share/data/qBittorrent/logs/qbittorrent.log`
- 


