---
title: hexo
top: 1
abbrlink: 21358
date: 2024-12-27 14:12:38
---

Hexo是一个基于 node.js的快速生成静态博客的开源框架,支持 Markdown和大多数 Octopress插件,一个命令即可部署到 Github页面、 Giteee、 Heroku等,强大的APl,可无限扩展,拥有数百个主题和插件。

<!-- more -->

# Hexo-零基础搭建个人博客

简单来说就是一个不用你写代码，就能搭建一套属于你自己的个人博客网站 应用（零基础小白也会）。

你可以在上面编写文章，做笔记，写日记，码代码。（一个属于你的世界！一个可供别人访问的个人世界）

## 一、环境准备

### 1.安装node.js

直接到官网上下载安装即可https://nodejs.org/en/download/

- [Node.js](http://nodejs.org/) (Node.js 版本需不低于 10.13，建议使用 Node.js 12.0 及以上版本)

- Node自带npm

### 2.安装Git

- Windows：下载并安装 [git](https://git-scm.com/download/win).
- Mac：使用 [Homebrew](http://mxcl.github.com/homebrew/), [MacPorts](http://www.macports.org/) 或者下载 [安装程序](http://sourceforge.net/projects/git-osx-installer/)。
- Linux (Ubuntu, Debian)：`sudo apt-get install git-core`
- Linux (Fedora, Red Hat, CentOS)：`sudo yum install git-core`

![](D:\study\blog\source\_posts\hello-world\nodeGit.png)

npm下载慢的话也可以下载淘宝下载源cnpm

```properties
npm install -g cnpm --registry=https://registry.npm.taobao.org
```

## 二、开始安装hexo

### 1.安装hexo

```properties
npm install -g hexo-cli
或者
cnpm install -g hexo-cli
```

安装完成可以输入npx hexo -v查看版本

![image-20241231174852695](D:\study\blog\source\_posts\hello-world\hexoV.png)

### 2.初始化hexo，新建存储博客的文件夹

```properties
hexo init BLOG
```

### 3.进入文件夹，安装一下npm

```properties
cd BLOG
npm install
```

可以看到我们的hexo站点就已经安装好了，接下来就可以直接启动他了

![iShot2021-12-03 16.55.54](D:\study\blog\source\_posts\hello-world\hexoFiles.png)

### 4.启动服务站点

```properties
npx hexo g
npx hexo s
```

访问http://localhost:4000/ 至此hero就搭建好了。可以在本地访问了

![20211203170208](D:\study\blog\source\_posts\hello-world\hexoHome.png)

## 三、Hexo部署站点至Github

#### 1.Github Pages简介

[Github Pages 官网](https://pages.github.com/)

[GitHub Pages](https://help.github.com/en/articles/what-is-github-pages) 是一种静态站点托管服务，旨在直接从 GitHub 存储库托管您的个人，组织或项目页面。

#### 2.创建Github Pages仓库

转到 [GitHub](https://github.com/) 并[创建](https://github.com/new)一个名为 `username.github.io` 的新仓库，其中 username 是您在 GitHub 上的用户名（或组织名称）。**如果仓库名的第一部分（username 部分）与您的用户名不完全匹配，则无法正常工作，因此请务必正确使用。**

![image-20250102110319850](D:\study\blog\source\_posts\hello-world\image-20250102110319850.png)

Repository name填写格式username.github.io

#### 3.配置SSH Key

SSH Key 是你的身份凭证，拥有密钥你才能向仓库推送修改，如果无需任何凭证就能推送，那么谁都可以向你的仓库推送修改。如果已经配置过了就无需再配置，如果没有配置过或者需要重新配置的，请进行以下操作。

##### 配置用户信息

初次运行 Git 前需要配置用户信息，一个是你个人的用户名称，一个是你的电子邮件地址。如果已配置则可以跳过。

```git
$ git config --global user.name your name
$ git config --global user.email your email
```

##### 检查是否已有SSH Key

```
$ cd ~/.ssh
```

执行ls或者ll

```
$ ls
id_rsa  id_rsa.pub  known_hosts
```

看是否存在 id_rsa 和 id_rsa.pub 文件（或者是其它文件名），如果存在说明已有 ssh key，可以直接跳过生成密钥，其中 id_rsa 为私钥，id_rsa.pub 为公钥。

##### 生成SSH Key

执行下列命令，三次回车确认

```
$ ssh-keygen -t rsa -C "your_email@example.com"
```

##### 添加 SSH Key 到 Github

- 登录 github，点击头像，点击 Settings 进入设置页面
- 然后点击菜单栏的 SSH Key 进入页面添加 SSH Key
- 点击 New SSH Key 按钮后进行 Key 的填写，其中 Title 随意，Key 为刚刚生成的公钥，公钥在文件 id_rsa.pub 文件中，直接 copy 文件中的内容粘贴即可

##### 测试SSH Key

```
$ ssh -T git@github.com
```

直接输入 yes 回车，如果提示以下内容说明已配置成功。

```
Hi xxx! You've successfully authenticated, but GitHub does not provide shell access.
```

