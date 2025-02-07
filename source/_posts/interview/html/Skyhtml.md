---
title: html面试总结
categories: 
    - 面试
    - html
tags:
  - html
abbrlink: d9d45835
date: 2025-01-15 18:12:38
---

**本文讲述了html面试的相关问题**

<!-- more -->



## html语义化

意义：根据内容的结构化（内容语义化），选择合适的标签（代码语义化）便于开发者阅读和写出更优 雅的代码的同时让浏览器的爬虫和机器很好地解析。

注意：

- 尽可能少的使用无语义的标签 div 和 span； 
- 在语义不明显时，既可以使用 div 或者 p 时，尽量用 p, 因为 p 在默认情况下有上下间距，对兼容 特殊终端有利；
- 不要使用纯样式标签，如：b、font、u 等，改用 css 设置。
- 需要强调的文本，可以包含在 strong 或者 em 标签中（浏览器预设样式，能用CSS 指定就不用他 们），strong 默认样式是加粗（不要用 b），em 是斜体（不用i）；
- 使用表格时，标题要用 caption，表头用 thead，主体部分用 tbody 包围，尾部用 tfoot 包围。表 头和一般单元格要区分开，表头用 th，单元格用 td； 
- 表单域要用 fieldset 标签包起来，并用 legend 标签说明表单的用途；
- 每个 input 标签对应的说明文本都需要使用 label 标签，并且通过为 input 设置id 属性，在 lable  标签中设置 for=someld 来让说明文本和相对应的 input 关联起来。

新标签

![image-20250115162122475](image-20250115162122475.png)

## canvas相关

使用前需要获得上下文环境，暂不支持 3 d

常用的api:

- fillRect(x,y,width,height)实心矩形
- strokeRect(x,y,width,height)空心矩形
- fillText( "Hello world" , 200 , 200 );实心文字
- strokeText( "Hello world" , 200 , 300 )空心文字

新标签兼容低版本

- ie9 之前版本通过 createElement 创建 html5 新标签
- 引入 html5shiv.js

## svg和canvas的区别？

- canvas是h5提供的新的绘图方法 ；
- svg已经有了十多年的历史 canvas画图基于像素点，是位图，如果进行放大或缩小会失真 ；svg基于图形，用html标签描绘形 状，放大缩小不会失真 canvas需要在js中绘制 ；
- svg在html绘制 canvas支持颜色比svg多  canvas无法对已经绘制的图像进行修改、操作 ；
- svg可以获取到标签进行操作

## html5有那些新特性

HTML5主要是关于图像，位置，存储，多任务等功能的增加。

- 拖拽释放(Drag and drop) API 
- 语义化更好的内容标签（header,nav,footer,aside,article,section） 
- 音频、视频API(audio,video) 
- 画布(Canvas) API 
- 地理(Geolocation) API 
- 本地离线存储 localStorage 长期存储数据，浏览器关闭后数据不丢失； 
- sessionStorage 的数据在浏览器关闭后自动删除 
- 表单控件，calendar、date、time、email、url、search

## 如何处理HTML新标签的浏览器兼容问题

IE8/IE7/IE6支持通过document.createElement方法产生的标签，可以利用这一特性让这些浏览器支持 HTML5新标签，当然最好的方式是直接使用成熟的框架、使用最多的是html5shim框架

## 说说title和alt属性

- 两个属性都是当鼠标滑动到元素上的时候显示 
- alt 是 img 的特有属性，是图片内容的等价描述，图片无法正常显示时候的替代文字。 
- title 属性可以用在除了base，basefont，head，html，meta，param，script和title之外的所有标签，是对dom元素的一种类似注释说明

## HTML全局属性（global attribute）有哪些

- class :为元素设置类标识 
- data-* : 为元素增加自定义属性 
- draggable : 设置元素是否可拖拽 
- id : 元素 id ，文档内唯一 
- lang : 元素内容的的语言 
- style : 行内 css 样式 
- title : 元素相关的建议信息