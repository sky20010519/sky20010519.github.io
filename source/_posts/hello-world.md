---
title: hexo
top: 100
abbrlink: 21358
date: 2024-12-27 14:12:38
---

##### Hexo是一个基于 node.js的快速生成静态博客的开源框架,支持 Markdown和大多数 Octopress插件,一个命令即可部署到 Github页面、 Giteee、 Heroku等,强大的APl,可无限扩展,拥有数百个主题和插件。

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

![nodeGit](nodeGit.png)

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

![hexoV](hexoV.png)

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

![hexoFiles](hexoFiles.png)

### 4.启动服务站点

```properties
npx hexo g
npx hexo s
```

访问http://localhost:4000/ 至此hero就搭建好了。可以在本地访问了

![hexoHome](hexoHome.png)

## 三、Hexo部署站点至Github

#### 1.Github Pages简介

[Github Pages 官网](https://pages.github.com/)

[GitHub Pages](https://help.github.com/en/articles/what-is-github-pages) 是一种静态站点托管服务，旨在直接从 GitHub 存储库托管您的个人，组织或项目页面。

#### 2.创建Github Pages仓库

转到 [GitHub](https://github.com/) 并[创建](https://github.com/new)一个名为 `username.github.io` 的新仓库，其中 username 是您在 GitHub 上的用户名（或组织名称）。**如果仓库名的第一部分（username 部分）与您的用户名不完全匹配，则无法正常工作，因此请务必正确使用。**

![image-20250102110319850](image-20250102110319850.png)

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

#### 4.分支管理说明

**推荐使用两个分支进行管理，一个分支用于部署站点，一个分支用于实现源代码的版本控制。**

当新建一个仓库的时候，仓库将自动包含一个 master 分支。如果将站点部署到 Github Pages，必须配置部署到 `username.github.io` 的 master 分支，因为现在 Github Pages 已经不支持指定分支进行部署了所以对于托管到 github 的，建议将 hexo 生成的站点文件推送到 master 分支，将源代码推送到另一个分支，如 dev 分支，那么所有的写作和各种配置修改都在 dev 分支下完成，dev 分支就是我们的写作分支。

这一切是如何发生的？
当执行 hexo deploy 时，Hexo 会创建或更新另外一个用于部署的分支，这个分支就是 _config.yml 配置文件中指定的分支。Hexo 会将生成的站点文件推送至该分支下，并且完全覆盖该分支下的已有内容。值得注意的是，hexo deploy 并不会对本地或远程的写作分支进行任何操作，因此依旧需要手动推送写作分支的所有改动以实现版本控制。

##### 修改部署配置

打开站点配置文件 _config.yml，修改 deploy 配置如下：

```
deploy:
  type: git
  repository: git@github.com:username/username.github.io.git
  branch: master
```

| Setting |                         Description                          |
| :-----: | :----------------------------------------------------------: |
|  repo   |                   仓库库（Repository）地址                   |
| branch  | 分支名称。如果您使用的是 GitHub 或 GitCafe 的话，程序会尝试自动检测。 |
| message | 自定义提交信息 (默认为 Site updated:  { {  now(‘YYYY-MM-DD HH:mm:ss’) } } ) |

**请将 `username` 改成你的用户名**

**Github Pages 仅在 `master` 分支下实现**

##### 部署站点

执行下列命令生成站点文件并推送至远程仓库

```
npx hexo clean && npx hexo deploy
```

`npx hexo clean`清除站点文件，`npx hexo deploy`重新生成站点文件并将之推送到指定的仓库分支.

也可以手动生成静态文件，然后使用 git 推送 public 文件夹内的静态文件到部署分支。在执行 hexo deploy 命令后，会在项目根目录下生成一个 .deploy_git 的文件夹，其中的文件其实就是 public 文件夹的文件，同时 .deploy_git 文件夹下还生成了一个 .git 目录，表明了 .deploy_git 是一个仓库目录，可以使用 git 进行版本控制。如果我们直接推送 public 文件夹的内容，需要将 public 初始化为一个仓库，即执行 git init 命令，然后再添加远程仓库进行推送。

部署到 Github Pages 完成后，就可以在浏览器中通过网址 https://username.github.io/ 进行访问了。(username 为你的 github 用户名)

##### 提交源代码分支

###### 初次提交

1.初始化仓库

如果是初次提交，此时项目根目录是没有 `.git` 文件夹的，所以需要执行下列命令将项目文件夹初始化为一个仓库，在项目根目录下执行：

```
git init
```

2.定义忽略规则

Hexo 在执行建站命令时默认会在项目根目录下生成 `.gitignore` 文件，该文件它已经配置好了不需要 push 的文件，如果没有则需要自行创建，然后在该文件定义如下忽略规则：

```
.DS_Store
Thumbs.db
db.json
*.log
node_modules/
public/
.deploy*/
```

- `db.json`：缓存文件，不需要 push
- `node_modules/`：模块包目录，在执行 `npm install` 时会重新生成，不需要 push
- `public/`：`hexo g` 生成的静态网页，不需要 push
- `.deploy_git/`：`hexo d` 生成，不需要 push

3.重命名当前分支

在初始化仓库完成后，默认在名为 `master` 的分支下，因为我们这个分支是用于提交源代码的，所以需要另起一个分支名，以区别于远程库的用于部署站点的 `master` 分支。

```
git branch -m master dev
```

这里我们将本地 `master` 分支重命名为 `dev`，在下面我们会推送该分支作为远程库的 `dev` 分支。

4.本地提交更新

执行下列命令查看分支状态：

```
git status
```

使用下列命令跟踪新文件：

```
git add *
```

再次使用 `git status` 查看分支状态，如果某些隐藏文件未被跟踪而又需要对其进行跟踪的，例如这里需要跟踪 `.gitignore` 文件，所以还需要执行：

```
git add .gitignore
```

执行下列命令，将更新提交到本地仓库分支：

```
git commit -m "Commit Message"
```

5.推送更新至远程仓库

上面的提交更新只是本地操作，与远程库并没有任何关联，所以还需要进行以下操作将更新推送至远程库。

添加远程仓库：

```
git remote add origin git@github.com:username/username.github.io.git
```

可以使用如下命令查看已添加的远程仓库的信息，例如：

```
$ git remote -v
origin	git@github.com:sky20010519/sky20010519.github.io.git (fetch)
origin	git@github.com:sky20010519/sky20010519.github.io.git (push)
```

执行下列命令，上传当前分支到远程库，并且关联当前分支与远程分支：

```
git push -u origin dev:dev
```

可以看到 git 会为我们自动在远程仓库创建 `dev` 分支，并且关联本地的 `dev` 分支和远程的 `dev` 分支。

###### 后续提交更新

因为初次提交时我们已经关联了本地分支与远程分支，所以后续提交更新时，只需要执行下列命令即可。

跟踪新文件和修改：

```
git add *
```

提交更新：

```
git commit -m "Commit Message"
```

推送更新：

```
git push
```

#### 其他设备管理博客

当我们需要在其它电脑上管理博客时，首先需要配置相关环境。

###### 配置相关环境

- 安装 `Git`
- 安装 `Node.js`
- 配置 SSH Key

Clone源码分支

```
git clone -b dev git@github.com:username/username.github.io.git
```

`dev` 为我的源码分支名称，你应根据你的分支名称进行修改。

###### 安装 Hexo 及相关依赖

```
npm install hexo-cli -g
npm install
```

