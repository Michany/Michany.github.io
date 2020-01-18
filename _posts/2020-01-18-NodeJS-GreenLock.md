---
layout: post
title: "使用GreenLock-Express SSL 为 NodeJS 升级 HTTPS"
subtitle: "How to use greenlock-express on NodeJS to upgrade to SSL (HTTPS)"
author: "Michael Wang"
header-img: "img/post-bg-js-version.jpg"
header-mask: 0.3
tags:
  - Ubuntu
  - JavaScript
  - NodeJS
---


## NodeJS 环境配置
### 环境
Ubuntu 18.04 64bit 阿里云HK

推荐使用管理员root账户进行NodeJS的安装配置
### 使用安装脚本
使用[Node Distribution 官方安装脚本](https://github.com/nodesource/distributions#installation-instructions)能够预先做好各种环境设置和软链接，省去很多烦心事。
```bash
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs
```

## 安装使用Greenlock-express
### Introduction
Greenlock-express基于LetsEncrypt免费提供的SSL证书，能够在常用的express建站的基础上无缝升级到HTTPS。

[**Greenlock-express主页**](https://git.coolaj86.com/coolaj86/greenlock-express.js)
### Installation&Configration
1. 安装  
``npm install --save greenlock-express@v4``
2. 初始化网站项目  
``npx greenlock init --config-dir ./greenlock.d --maintainer-email 'michael@mail.michany.xyz'``    
注意必须在当前目录下有`package.json`文件，如果没有可以参照example自己建一个。  
经过初始化后，会自动在当前目录下生成`app.js`和`server.js`两个文件（如果已经存在则不会替换，建议新手让程序自动生成），里面已经写好了正确的初始化方式。（见下文[Examples](#Examples)）
3. 添加Sites  
`npx greenlock add --subject michany.xyz --altnames michany.xyz`  
完成后，在`greenlock.d/config.json`中会多出以下配置：  
``{ "sites": [{ "subject": "michany.xyz", "altnames": ["michany.xyz"] }] }``



### Examples
Greenlock-express官方提供了[基于Express的Examples](https://git.coolaj86.com/coolaj86/greenlock-express.js/src/branch/master/examples/express)，非常方便。更方便的是，使用程序自带的[初始化脚本](#Installation&Configration)即可一键生成。
#### app.js
```js
var express = require("express");
var app = express();

// Routing
app.use(express.static(path.join(__dirname, '')));

// DO NOT DO app.listen() unless we're testing this directly
if (require.main === module) {
    app.listen(3000);
}
// Instead do export the app:
module.exports = app;
```
用`module.export`的方式暴露`app`，保证了`app`拥有`express`的基础属性，同时在`server.js`主文件中，`greenlock-express`可以对底层`express`进行修改。

#### server.js
```js
'use strict';
var app = require('./app.js');

require('greenlock-express')
    .init({
        packageRoot: __dirname,

        // contact for security and critical bug notices
        maintainerEmail: "michael@mail.michany.xyz",

        // where to look for configuration
        configDir: './greenlock.d',

        // whether or not to run at cloudscale
        cluster: false
    })
    // Serves on 80 and 443
    // Get's SSL certificates magically!
    .serve(app);

```
*上述文件可以被自动生成。*

### 后记
经过这番改造之后，网站成功拥有了小锁🔒，这样就不会提示不安全了。当然还要记得把前段html网页也升级到https，或者直接在头部添加
	
```html
<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
```

LetEncypt SSL证书虽然免费，但弊端就是网页访问速度变慢了不少，可能是需要访问外网来验证证书导致的。
