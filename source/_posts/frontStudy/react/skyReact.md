# create-react-app基本使用

create-react-app：脚手架，基于它创建的项目，默认就把webpack的打包规则已经处理好了，把一些项目需要的基本文件也创建好了

安装脚手架

```nginx
npm i create-react-app -g
```

检查安装情况

```nginx
create-react-app --version
```

基于脚手架创建React工程化的项目

```
create-react-app 项目名称
```

> 项目名称要遵循npm包的命名规范：使用“数字、小写字母、_”命名

# React项目文件结构

![image-20250305092315062](image-20250305092315062.png)

目录结构：

​	|- node_modules
​	|- src：编写的代码，几乎都放在src下（打包的时候一般只对这个目录下的代码进行处理）
​		|-index.js
​	|- public：放页面模板
​		|-index.html
​	|- package.json
​	|- ...

使用npm管理react会生成node_modules和package-lock.json

如果想使用yarn管理项目，可以把node_modules和package-lock.json文件删除然后运行

```nginx
yarn
```

文件目录就会生成node_modules和yarn.lock文件

![image-20250305094116726](image-20250305094116726.png)

## .gitignore

脚手架自带的git文件可以删除

## package.json

```properties
{
  "name": "my-react-app",//项目名字
  "version": "0.1.0",//版本
  "private": true,
  "dependencies": {//项目所需要的依赖
    "@testing-library/dom": "^10.4.0",
    "@testing-library/jest-dom": "^6.6.3",
    "@testing-library/react": "^16.2.0",
    "@testing-library/user-event": "^13.5.0",
    "react": "^19.0.0",
    "react-dom": "^19.0.0",
    "react-scripts": "5.0.1",
    "web-vitals": "^2.1.4"//性能检测工具
  },
```

react：React框架的核心

react-dom：React视图渲染的核心（基于React构建WebApp（HTML页面））

react-native：构建和渲染App的

react-scripts：脚手架为了让项目目录看起来干净一些，把webpack打包的规则以及相关的插件/LOADER等都影藏在node_modules目录下，react-scripts就是脚手架用于打包命令的一种封装，基于它打包，会调用node_modules中的webpack等进行处理

```properties
"scripts": {//打包命令是基于react-scripts处理
    "start": "react-scripts start",//开发环境：在本地启动web服务器，预览打包内容
    "build": "react-scripts build",//生产环境，打包部署，打包的内容将输出到dist目录中
    "test": "react-scripts test",//单元测试
    "eject": "react-scripts eject"//暴露webpack配置规则（可以修改默认打包规则）
  },
```

```properties
"eslintConfig": {
    "extends": [
      "react-app",
      "react-app/jest"
    ]
  },
```

这一部分就是对webpack中的ESLint词法检测的相关配置：

词法检测：let var = 20(不符合标准规范)//var是关键词

符合规范，代码本身没有报错，但不符合ESLint的检查规范：const num = 20(声明变量但未使用)

```properties
"browserslist": {
    "production": [
      ">0.2%",//使用率超过0.2%的浏览器
      "not dead",不考虑IE
      "not op_mini all"不考虑op浏览器
    ],
    "development": [//不兼容低版本和IE浏览器
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ]
  }
```

如果想使用ie浏览器可以修改配置为

```properties
"browserslist": {
    "production": [
      ">0.2%",
      "not i8<=8",
    ],
    "development": [
      "last 2 version",
    ]
  }
```

## src

![image-20250305112025966](image-20250305112025966.png)

删除多余的只留下index.js

```react
import React from 'react';
import ReactDOM from 'react-dom/client';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>//React的严格语法模式，和use strict不一样
    <div>sky学react</div>
  </React.StrictMode>
);
```

public

![image-20250305112602775](image-20250305112602775.png)

删除多余的只留下index.html

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <link rel="icon" href="%PUBLIC_URL%/favicon.ico" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Sky的React</title>
  </head>
  <body>
    <div id="root"></div>
  </body>
</html>

```

