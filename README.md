# MiaoShowSwift
高仿喵播swift版本
## 前言:
>swift出来很长时间了，已经4.0版本了，学了一段时间，打算自己写个高仿的项目巩固一下。在简书上看到过 Monkey_ALin  大神写的OC版仿喵播[项目地址](https://www.jianshu.com/p/b8db6c142aad)，觉得挺不错，于是我打算在这基础上写个swift版的。


## 提前准备：
### 既然我们要高仿一个项目，我们肯定要知道怎么抓取项目数据

* 抓取接口数据：抓取接口数据一般都会采用 Charles,但是很尴尬新版本的喵播采用了https,抓取到的接口数据都是加密的，没办法，那就只能用 Monkey_ALin 之前抓取的接口了，好在数据没什么大的变化，不然就要高仿其它App了。[Charles教程从入门到精通](https://www.jianshu.com/p/a3f005628d07)

* 获取app资源：由于现在的ituns新版本不再支持获取ipa文件了，所以我在网上找了2种方法，一是下载低版本的ituns，另一个是用 Apple Configurator 2 软件，在App Store下载即可。1. [ituns降级](https://www.jianshu.com/p/ac81fa56b44c) 2. [Apple Configurator 2使用方法](https://www.jianshu.com/p/1e34b80a9937)

* 获取图片资源：图片资源都打包在 Assets.car 文件中，解压的时候用到了 carTool 工具，github上有 [carTool地址](https://github.com/yuedong56/Assets.carTool)

* 集成IJKMediaFramework.framework 由于IJKMediaFramework.framework超过100兆，github对于上传100M以上的大文件做了限制，我自己打包上传了百度云，[下载地址](https://pan.baidu.com/s/1i6umZnn) 提取码：tkh5 下载下来解压后直接拖到项目Frameworks文件夹下即可

### 做到这些准备工作就差不多了

## 项目结构：
### 介绍一下主要的结构：
* Tools 主要放了一些扩展，名字用的有点不好
* Defines 一些常量定义
* Common 通用的一些类
* Network 网络请求，数据解析，基于Alamofire,Moya,HandyJson的封装
* Main tabbarcontroller 自己写了一下，加了动画效果
* Base 主要放一些基类
* Home 广场模块
* My 我的模块
* Account 账户中心，集成了qq登录
* AD 广告模块
* Live 直播模块

## 完成进度：
### 现在主要完成了一些界面的搭建，数据请求，集成ijk完成直播，设计视频采集部分后面会继续完成。

*登录 ![img](http://7xt7tb.com1.z0.glb.clouddn.com/login.png)

*广告 ![img](http://7xt7tb.com1.z0.glb.clouddn.com/ad.gif)

*热门 ![img](http://7xt7tb.com1.z0.glb.clouddn.com/ho%27t.gif)

*最新 ![img](http://7xt7tb.com1.z0.glb.clouddn.com/new.gif)

*我的 ![img](http://7xt7tb.com1.z0.glb.clouddn.com/my.gif)

## 结尾：
### ，ps:录gif工具用的LICEcap,挺好用的。[项目地址](https://github.com/ZCLemo/MiaoShowSwift),希望能对大家有点帮助
