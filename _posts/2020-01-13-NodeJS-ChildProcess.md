---
layout: post
title: "如何正确地结束NodeJS子进程 - 避坑"
subtitle: "How to Kill NodeJS Child Process on Linux"
author: "Michael Wang"
header-img: "img/post-bg-js-version.jpg"
header-mask: 0.3
tags:
  - Ubuntu
  - JavaScript
  - Process
---

## 子进程 child_process
在NodeJS服务器端可以使用``child_process``模块来控制子进程，从而根据网页的请求创建和结束其他软件。[child_process - NodeJS官方文档](https://www.nodeapp.cn/child_process.html#child_process_subprocess_kill_signal)

NodeJS中创建子进程主要由两种方法：exec和spwan，以下将分别讲述和比较。
### exec
`exec`是一种较为高级的子进程封装，将子进程的输出和报错信息全都缓存在buffer中（如果达到MaxBufferSize则子进程被动结束），直到子进程结束后才会一次性释放出来。
```js
var exec = require('child_process').exec;

exec("ls -l", function(error, stdout, stderr) {   // 获取命令执行的输出
    if (error) {console.log("[error]"+error)};
    console.log("[stdout]"+stdout);
    console.log("[stderr]"+stderr);
});
```
上述代码创建了一个简单的子进程，并且子进程的错误信息、命令行输出都会被捕获到，当子进程结束后会在终端打印出来。

### spwan
事实上，根据官方文档介绍，`exec`方法实际上是对`spwan`的封装，而`spwan`**具有很多更加底层的属性可供使用**，因此应该首推使用它！

```js
const { spawn } = require('child_process');
child_process.spawn(command[, args][, options])
```
## 如何正确的结束子进程
在实际使用中，子进程往往还会产生出子进程（孙进程）。
![Child Process](/img/in-post/process_tree.png)
而这时子进程的子进程往往无法被子进程handler的`kill`方法直接结束掉。
```js
child_process.kill() // Does not work for the grand_child_process
```
上面的代码是官方文档提供的标准方法，理论上能够结束子进程。但是在实际使用中，我发现只是将子进程单独结束掉，而子进程的子进程树仍然没有结束，被挪了出来单独变为一个进程树。
这个问题困扰了我很久，在百度谷歌上搜了很久，尝试了一整天，终于依照[一篇博文](https://azimi.me/2014/12/31/kill-child_process-node-js.html)亲测成功结束了子进程树。
```js
const { spawn } = require('child_process');
const out = fs.openSync('./out.log', 'a'); // Capture output stream
const err = fs.openSync('./out.log', 'a');
var subprocess; 
subprocess = spawn('/home/michael/xuexiqiangguo', ['--headless', '--multi-user'], {detached: true, stdio: [ 'ignore', out, err ]}); // Detachable
subprocess.unref(); // detach from parent process

process.kill(-subprocess.pid) // kill the child process and its children
```
其中很重要的一点是增加了`detached: true`这一属性，使得子进程在一开始就和父进程分离。然后使用`process.kill(-subprocess.pid)`这一内置命令：其中`-`号表示结束以`pid`为首的整个进程树。
