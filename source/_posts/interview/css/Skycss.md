---
title: css面试总结
categories: 
    - 面试
    - css
tags:
  - css
abbrlink: 49d38819
date: 2025-01-02 18:12:38
---

##### 本文讲述了css面试的相关问题
<!-- more -->

# CSS

## 1.让一个元素水平垂直居中，到底有多少钟方法？

![image-20250115172854424](image-20250115172854424.png)

### 水平居中

- 对于行内元素：

  ```css
  text-align:center
  ```

- 对于宽度确定的块级元素

  - width和margin实现。

    ```scss
    margin:0 auto
    ```

  - 绝对定位和margin-left:-width/2,前提是父元素position：relative

    ```scss
    position: absolute;
    margin-left:-width/2
    ```

- 对于宽度未知的块级元素

  - table标签配合margin左右auto实现水平居中。使用table标签（或直接将块级元素设值为display:table），再通过给该标签添加左右margin为auto。

    ```scss
    display:table
    margin: auto
    ```

  - inline-block实现水平居中方法。display：inline-block和text-align:center实现水平居中。

    ```css
    display：inline-block
    text-align:center
    ```

  - 绝对定位+transform+left，translateX可以移动本身元素的50%,前提是父元素position：relative

    ```scss
    position: absolute;
    left:50%
    translateX:(-50%)
    ```

  - flex布局使用justify-content:center
  
    ```scss
    display:flex
    justify-content:center
    ```

### 垂直居中

1.  利用 line-height 实现居中，这种方法适合纯文字类

   ```scss
   line-height:height
   ```

   

2. 通过设置父容器 相对定位，子级设置标签通过margin实现自适应居中

   ```scss
   --父容器
   position：relative
   ```

   ```scss
   --子容器
   position:absolute;
   top:0;
   bottom:0;
   margin:auto 0
   ```

   

3. 弹性布局flex:父级设置display:flex；子级设置margin为auto实现自适应居中

   ```scss
   --父容器
   display：flex;
   margin：auto 0
   ```

   

4. 父级设置相对定位，子级设置绝对定位，并且通过唯一transform实现

   ```scss
   --父容器
   display:relative
   ```

   ```scss
   --子容器
   display:absolute;
   top:50%;
   transform:translateY(-50%);
   ```

   

5. table布局，父级通过转换成表格形式，然后子级设置vertical-align实现（需要注意的是：vertical-align:middle使用的前提条件是内联元素以及display值为table-cell的元素）。

   ```scss
   --父容器
   display:table；
   ```

   ```scss
   --子容器
   display:table-cell
   vertical-align:middle
   ```

### 水平垂直居中

- 利用定位+margin:auto

  ```scss
  --父容器
   width:500px;
   height:300px;
   border:1px solid #0a3b98;
   position: relative;
  ```

  ```scss
  --子容器
  width:100px;
  height:40px;
  background:#f0a238;
  position:absolute;
  top:0;
  left:0;
  right:0;
  bottom:0;
  margin:auto
  ```

  父级设置为相对定位，子级对决定位，并且四个定位属性的值都设置了0，那么这时候如果子级没有设置宽高，则会被拉开到和父级一样宽高

  这里子元素设置了宽高，所以宽高会按照我们的设置来显示，但是实际上子级的虚拟占位已经撑满了整个父级，这时候再给它一个margin:auto它就可以上下左右都居中了

- 利用定位+margin:负值

  绝大多数情况下，设置父元素为相对定位，子元素移动自身50%实现水平垂直居中

  ```scss
  --父容器
  position:relative;
  width:200px;
  height:200px
  background:skybule
  ```

  ```scss
  --子容器
  position:absolute;
  top:50%;
  left:50%;
  margin-left:-50px;
  margin-right:-50px;
  width:100px;
  height:100px;
  background:red;
  ```

  整个实现思路如下所示：

  ![image-20250116111032804](image-20250116111032804.png)

  - 初始位置为方块1的位置
  - 当设置left、top为50%的时候，内部子元素为方块2的位置
  - 设置margin为负值时，使内部子元素到方块3的位置，即中间位置

  这种方案不要求父元素的高度，也就是即使父元素的高度变化了，仍然可以保持在父元素的垂直居中位置，水平方向上是一样的操作，但是该方案需要知道子元素自身的宽高，但是我们可以通过下面`transform`属性进行移动

- 利用定位+transform

  ```scss
  --父容器
  position:relative;
  width:200px;
  height:200px;
  background:skyblue;
  ```

  ```scss
  --子容器
  position:absolute;
  top:50%;
  left：50%；
  transform：translate(-50%,-50%);
  width:100px;
  height:100px;
  background:red;
  ```

  `translate(-50%, -50%)`将会将元素位移自己宽度和高度的-50%,这种方法其实和最上面被否定掉的margin负值用法一样，可以说是`margin`负值的替代方案，并不需要知道自身元素的宽高

- table布局

  设置父元素为display:table-cell,子元素设置为display:inline-block。利用vertical和text-align可以让所有的行内快元素水平居中

  ```scss
  --父容器
  dispaly: table-cell;
  width:200px;
  height:200px
  background:skyblue;
  vertical-align:middle;
  text-align:center
  ```

  ```scss
  --子容器
  display：inline-block;
  width:100px;
  height:100px;
  background: red;
  ```

- flex布局

  ```scss
  display:flex;
  justify-content:center;
  align-item:center;
  ```

- grid布局

  ```scss
  display:grid;
  align-items:center;
  justify-content:center;
  ```

## 2.浮动布局的优点？有什么缺点？清除浮动有那些方式？

> 浮动布局简介:当元素浮动以后可以向左或向右移动，直到它的外边缘碰到包含它的框或者另外一 个浮动元素的边框为止。元素浮动以后会脱离正常的文档流，所以文档的普通流中的框就变现的好 像浮动元素不存在一样

### 优点

这样做的优点就是在图文混排的时候可以很好的使文字环绕在图片周围。另外当元素浮动了起来之后， 它有着块级元素的一些性质例如可以设置宽高等，但它与inline-block还是有一些区别的，第一个就是关 于横向排序的时候，float可以设置方向而inline-block方向是固定的；还有一个就是inline-block在使用 时有时会有空白间隙的问题

### 缺点

最明显的缺点就是浮动元素一旦脱离了文档流，就无法撑起父元素，会造成父级元素高度塌陷。

### 清除浮动的方式

- 添加额外标签

  ```html
  <div class="parent">
      //添加额外标签并且添加clear属性
      <div style="clear:both"></div>
      //也可以加一个br标签
  </div>
  ```

- 父级添加overflow属性，或者设置高度

  ```html
  <div class="parent" style="overflow:hidden">//auto 也可以
  	//将父元素的overflow设置为hidden
   	<div class="f"></div>
  </div>
  ```

- 建立伪类选择器清除浮动（推荐）

  ```html
  <div class="parent">
      <div class="f"></div>
  </div>
  ```

  ```scss
  //在css中添加：after伪元素
  .parent:after{
      /* 设置添加子元素的内容是空 */
      content：'';
      /* 设置添加子元素为块级元素 */
      display: block;
      /* 设置添加的子元素的高度为0 */
      height:0;
      /* 设置添加子元素看不见 */
      visibility: hidden;
      /* 设置clear：both */
      clear: both;
  }
  ```


## 3.使用display：inline-block会产生什么问题？解决方法？

### 问题复现

问题：两个display: inline-block元素放到一起会产生一段空白。

代码：

```html
 <!DOCTYPE html>
 <html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
      .container {
        width: 800px;
        height: 200px;
      }
      .left {
        font-size: 14px;
        background: red;
        display: inline-block;
        width: 100px;
        height: 100px;
      }
      .right {
        font-size: 14px;
        background: blue;
        display: inline-block;
        width: 100px;
        height: 100px;
      }
    </style>
  </head>
  <body>
	<div class="container">
 		<div class="left">
		左
		</div>
 		<div class="right">
		右
		</div>
 	</div>
   </body>
 </html>
```

效果如下：

![image-20250116154243787](image-20250116154243787.png)

### 产生空白的原因

元素被当成行内元素排版的时候，元素之间的空白符（空格、回车换行等）都会被浏览器处理，根据 CSS中white-space属性的处理方式（默认是normal，合并多余空白），原来HTML代码中的回车换行被 转成一个空白符，在字体不为0的情况下，空白符占据一定宽度，所以inline-block的元素之间就出现了 空隙。

### 解决办法

1. 将子元素标签的结束符和下一个标签的开始符写在同一行或把所有子标签写在同一行

   ```html
   <div class="container">
    	<div class="left">
   		左
   	</div><div class="right">
   		右
   	</div>
    </div>
   ```

2. 父元素中设置font-size: 0，在子元素上重置正确的font-size

   ```scss
    .container{
    	width:800px;
    	height:200px;
    	font-size: 0;
    }
   
   ```

3. 为子元素设置float:left

   ```scss
   .left{
       float:left;
       font-size:14px;
       background:red;
       display:inline-block;
       width:100px;
       height:100px;
   }
   //right是同理
   ```

## 4.布局题：div垂直居中，左右10px，高度始终为宽度一半

> 问题描述: 实现一个div垂直居中, 其距离屏幕左右两边各10px, 其高度始终是宽度的50%。同时div 中有一个文字A，文字需要水平垂直居中

### 思路一

利用height：0；padding-bottom:50%

```html
<!DOCTYPE html>
 <html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
      *{
        margin: 0;
        padding: 0;
      }
      html, body {
        height: 100%;
        width: 100%;
      }
      .outer_wrapper {
        margin: 0 10px;
        height: 100%;
        /* flex布局让块垂直居中 */
        display: flex;
        align-items: center;
      }
      .inner_wrapper{
        background: red;
        position: relative;
        width: 100%;
        height: 0;
        padding-bottom: 50%;
      }
      .box{
        position: absolute;
        width: 100%;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 20px;
      }
    </style>
  </head>
  <body>
    <div class="outer_wrapper">
      <div class="inner_wrapper">
        <div class="box">A</div>
      </div>
    </div>
  </body>
 </html>
```

强调两点：

-  padding-bottom究竟是相对于谁的？

  答案是相对于父元素的width值。

  那么对于这个out_wrapper的用意就很好理解了。 CSS呈流式布局，div默认宽度填满，即100%大小， 给out_wrapper设置margin: 0 10px;相当于让左右分别减少了10px。

- 父元素相对定位，那绝对定位下的子元素宽高若设为百分比，是相对谁而言的

  相对于父元素的(content + padding)值, 注意不含borde

> 延伸：如果子元素不是绝对定位，那宽高设为百分比是相对于父元素的宽高，标准盒模型下是 content, IE盒模型是content+padding+border

### 思路二：

利用calc和vw

```html
 <!DOCTYPE html>
 <html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
      * {
        padding: 0;
        margin: 0;
      }
      html,
      body {
        width: 100%;
        height: 100%;
      }
      .wrapper {
        position: relative;
        width: 100%;
        height: 100%;
}
 .box {
 	margin-left: 10px;
 	/* vw是视口的宽度， 1vw代表1%的视口宽度 */
 	width: calc(100vw - 20px);
 	/* 宽度的一半 */
 	height: calc(50vw - 10px);
 	position: absolute;
 	background: red;
 	/* 下面两行让块垂直居中 */
	 top: 50%;
 	transform: translateY(-50%);
 	display: flex;
 	align-items: center;
 	justify-content: center;
 	font-size: 20px;
 }
 </style>
 </head>
 	<body>
 		<div class="wrapper">
 			<div class="box">A</div>
 		</div>
 	</body>
 </html>
```

效果图：

![image-20250116165225216](image-20250116165225216.png)

## 5.盒模型

```scss
/* 红色区域的大小是多少？200 - 20*2 - 20*2 = 120 */ 
.box {
 width: 200px; 
height: 200px; 
padding: 20px; 
margin: 20px; 
background: red; 
border: 20px solid black; 
box-sizing: border-box; }
 /* 标准模型 */ 
box-sizing:content-box; 
/*IE模型*/ 
box-sizing:border-box
```

## 6.CSS如何进行品字布局

### 第一种

```html
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>品字布局</title>
<style>
* {
	margin: 0;
	padding: 0;
}
body {
	overflow: hidden;
}
div {
	margin: auto 0;
	width: 100px;
	height: 100px;
	background: red;
	font-size: 40px;
	line-height: 100px;
	color: #fff;
	text-align: center;
}
.div1 {
	margin: 100px auto 0;
}
.div2 {
	margin-left: 50%;
	background: green;
	float: left;
	transform: translateX(-100%);
}
.div3 {
	background: blue;
	float: left;
	transform: translateX(-100%);
}
</style>
</head>
<body>
	<div class="div1">1</div>
	<div class="div2">2</div>
	<div class="div3">3</div>
</body>
</html>
```

效果：

![image-20250117112120258](image-20250117112120258.png)

### 第二种（全屏版）

```html
 <!doctype html>
 <html>
 <head>
 <meta charset="utf-8">
 <title>品字布局</title>
 <style>
 * {
 	margin: 0;
 	padding: 0;
 }
 div {
 	width: 100%;
 	height: 100px;
 	background: red;
 	font-size: 40px;
 	line-height: 100px;
 	color: #fff;
 	text-align: center;
 }
 .div1 {
	margin: 0 auto 0;
 }
 .div2 {
	background: green;
 	float: left;
 	width: 50%;
 }
 .div3 {
 	background: blue;
 	float: left;
 	width: 50%;
 }
 </style>
 </head>
 <body>
 	<div class="div1">1</div>
 	<div class="div2">2</div>
 	<div class="div3">3</div>
 </body>
 </html>
```

效果：

![image-20250117112256586](image-20250117112256586.png)

### 第三种flex

```scss
.box3{
    height: 200px;
    width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    line-height: 100px;
    color: #fff;
}
.box4{
    display: flex;
    flex-direction: row;
}
.div7{
    width: 100px;
    height: 100px;
    background: red;
}
.div8{
    width: 100px;
    height: 100px;
    background: green;
}
.div9{
    width: 100px;
    height: 100px;
    background: blue;
}
```

```html
<div class="box3">
            <div class="div7">1</div>
            <div class="box4">
                <div class="div8">2</div>
                <div class="div9">3</div>
            </div>
        </div>
```

## 7.CSS如何进行圣杯布局

圣杯布局如图：

![image-20250117135934032](image-20250117135934032.png)

而且要做到左右宽度固定，中间宽度自适应

### 利用flex布局

使用CSS3的flex布局实现三栏布局，Flex布局也称弹性布局，可以为盒 状模型提供最大的灵活性，是布局的首选方案，现已得到所有现代浏览 器的支持，此处主要是利用flex容器成员默认按照主轴排列，以及利用 flex属性即
flex-grow，flex-shrink和flex-basis的简写形式将间的 块自适应撑起。

```scss
.three1{
    display: flex;
    height: 200px;
    border: 1px solid #eee;
    .left{
        width: 200px;
        background: #19be6b;
    }
    .main{
        flex:1;
        background: #2979ff;
    }
    .right{
        width: 200px;
        background: #fa3534;
    }
}
```

```html
<div class="three1">
                    <div class="left"></div>
                    <div class="main"></div>
                    <div class="right"></div>
                </div>
```

### 利用Calc布局

通过CSS的calc可以动态计算 中间部分的长度从而做到自适应，calc可以配合 inline-block行内块级元素实现三栏布局， 注意使用行内块级元素的时候如果编写HTML时换行，这个空 白的换行也会作为元素解析从而会产生空白间隙，所以在编 写时此处不要换行，此外calc通过与float 配合实现也是可行的。

```scss
.three2{
    height: 200px;
    border: 1px solid #eee;
    .left{
        width: 200px;
        background: #19be6b;
    }
    .main{
        width: calc(100% - 400px);
        background: #2979ff;
    }
    .right{
        width: 200px;
        background: #fa3534;
    }
}
.three2 div{
    display: inline-block;
    height: 100%;
}
```

```html
<div class="three2">
                    <div class="left"></div><div class="main"></div><div class="right"></div>
                </div>
```

### 利用BFC

BFC块级格式化上下文Block Formatting Context， 是Web页面的可视CSS渲染的一部分，是块盒子的布局 过程发生的区域，也是浮动元素与其他元素交互的区域 ，是用于布局块级盒子的一块渲染区域，并且与这个区 域的外部毫无关系，是一个独立的区域，是一个环境， 在这里利用BFC区域不会与浮动元素重叠的特性实现三栏布局。

```scss
.three3 div{
    height: 100%;
}
.three3{
    height: 200px;
    border: 1px solid #eee;
    .left{
        float: left;
        width: 200px;
        background: #19be6b;
    }
    .main{
        text-align: center;
        overflow: hidden;
        background: #2979ff;
    }
    .right{
        float: right;
        width: 200px;
        background: #fa3534;
    }
}
```

```html
<div class="three3">
                    <div class="left"></div>
                    <div class="right"></div>
                    <div class="main"></div>
                </div>
```

右两侧固宽，两侧都使用浮动，中间使用margin: 左右两侧的宽度auto，轻松实现三栏自适应布局 ，故意使两侧留出空白，以便确认中间是完全宽度自适应，

```scss
.three4 div{
    height: 100%;
}
.three4{
    height: 200px;
    border: 1px solid #eee;
    .left{
        float: left;
        width: 200px;
        background: #19be6b;
    }
    .main{
        margin: 0 200px;
        background: #2979ff;
    }
    .right{
        float: right;
        width: 200px;
        background: #fa3534;
    }
}
```

```html
<div class="three4">
                    <div class="left"></div>
                    <div class="right"></div>
                    <div class="main"></div>
                </div>
```

### 利用Float

使用Float配合margin实现三栏布局，主要是margin的负值的应用。

```scss
.three5 div{
    height: 100%;
}
.three5{
    height: 200px;
    border: 1px solid #eee;
    .left{
        float: left;
        width: 200px;
        margin-left: -100%;
        background: #19be6b;
    }
    .main{
        float: left;
        width: 100%;
        background: #2979ff;
    }
    .right{
        float: right;
        width: 200px;
        margin-left: -200px;
        background-color: #fa3534;
    }
}
```

```html
<div class="three5">
                <div class="main"></div>
                <div class="left"></div>
                <div class="right"></div>
            </div>
```

### 利用table

使用Table布局即表格的样式,实现三栏布局。

```scss
.three6 div{
    display: table-cell;
}
.three6{
    display: table;
    height: 200px;
    width: 100%;
    border: 1px solid #eee;
    .left{
        width: 200px;
        background: #19be6b;
    }
    .right{
        width: 200px;
        background: #fa3534;
    }
    .main{
        background: #2979ff;
    }
}
```

```html
<div class="three6">
                <div class="left"></div>
                <div class="main"></div>
                <div class="right"></div>
            </div>
```

### 利用Grid

目前CSS布局方案中,网格布局可以算得上是最强大的布局方案了 。它可以将网页分为一个个网格，然后利用这些网格组合做出 各种各样的布局。Grid布局与Flex布局有一定的相似性，都可 以指定容器内部多个成员的位置。不同之处在于，Flex布局是 轴线布局，只能指定成员针对轴线的位置，可以看作是一维布局 。Grid布局则是将容器划分成行和列，产生单元格，然后指定成 员所在的单元格，可以看作是二维布局。

```scss
.three7{
    display: grid;
    height: 200px;
    grid-template-columns: 200px auto 200px;
    border: 1px solid #eee;
    .left{
        background: #19be6b;
    }
    .main{
        background: #2979ff;
    }
    .right{
        background: #fa3534;
    }
}
```

```html
<div class="three7">
                    <div class="left"></div>
                    <div class="main"></div>
                    <div class="right"></div>
                </div>
```

## 8.CSS如何实现双飞翼布局

![image-20250117170651109](image-20250117170651109.png)

有了圣杯布局的铺垫，双飞翼布局也就问题不大啦。这里采用经典的float布局来完成

```scss
.box6{
    width: 100%;
    height: 200px;
    .main{
        height: 200px;
        background: yellow;
        width: 100%;
        float: left;
    }
    .left{
        width: 200px;
        height: 150px;
        float: left;
        margin-left: -100%;
        background: red;
    }
    .right{
        width: 200px;
        height: 150px;
        float: right;
        margin-left: -200px;
        background: blue;
    }
}
```

```html
<div class="box6">
            <div class="main">双飞翼布局</div>
            <div class="left"></div>
            <div class="right"></div>
        </div>
```

## 9.什么是BFC？

W3C对BFC的定义如下： 浮动元素和绝对定位元素，非块级盒子的块级容器（例如 inline-blocks, table cells, 和 table-captions），以及overflow值不为"visiable"的块级盒子，都会为他们的内容创建新的 BFC（Block Fromatting Context， 即块级格式上下文）。

## 10.触发条件

一个HTML元素要创建BFC，则满足下列的任意一个或多个条件即可： 下列方式会创建块格式化上下文： 

- 根元素() 
- 浮动元素（元素的 float 不是 none） 
- 绝对定位元素（元素的 position 为 absolute 或 fixed） 
- 行内块元素（元素的 display 为 inline-block） 
- 表格单元格（元素的 display为 table-cell，HTML表格单元格默认为该值） 
- 表格标题（元素的 display 为 table-caption，HTML表格标题默认为该值） 
- 匿名表格单元格元素（元素的 display为 table、table-row、 table-row-group、table-header group、table-footer-group（分别是HTML table、row、tbody、thead、tfoot的默认属性）或  inline-table） 
- overflow 值不为 visible 的块元素 -弹性元素（display为 flex 或 inline-flex元素的直接子元素） 
- 网格元素（display为 grid 或 inline-grid 元素的直接子元素） 等等

## 11.BFC渲染规则

1. BFC垂直方向边距重叠 
2. BFC的区域不会与浮动元素的box重叠 
3. BFC是一个独立的容器，外面的元素不会影响里面的元素 
4. 计算BFC高度的时候浮动元素也会参与计算                                                                                                         

## 12应用场景

### (1).防止浮动导致的父元素高度塌陷

```css
.container {
 	border: 10px solid red;
 }
 .inner {
 	background: #08BDEB;
 	height: 100px;
 	width: 100px;
 }
```

```html
 <div class="container">
 	<div class="inner"></div>
 </div>
```

![image-20250120102819802](image-20250120102819802.png)

接下来将inner元素设为浮动：

```css
 .inner {
	float: left;
 	background: #08BDEB;
 	height: 100px;
 	width: 100px;
 }
```

会产生这样的塌陷效果:

![image-20250120104223947](image-20250120104223947.png)

但如果我们对父元素设置BFC后, 这样的问题就解决了

```css
 .container {
 	border: 10px solid red;
 	overflow: hidden;
 }
```

### (2)避免外边距折叠

两个块同一个BFC会造成外边距折叠，但如果对这两个块分别设置BFC，那么边距重叠的问题就不存在 了。 现有代码如下：

```css
 .container {
 	background-color: green;
 	overflow: hidden;
 }
 .inner {
 	background-color: lightblue;
 	margin: 10px 0;
 }
```

```html
 <div class="container">
 	<div class="inner">1</div>
 	<div class="inner">2</div>
 	<div class="inner">3</div>
 </div>
```

![image-20250120111712032](image-20250120111712032.png)

此时三个元素的上下间隔都是10px, 因为三个元素同属于一个BFC。 现在我们做如下操作

```html
 <div class="container">
 	<div class="inner">1</div>
 <div class="bfc">
	 <div class="inner">2</div>
 </div>
 	<div class="inner">3</div>
 </div>
```

```css
.bfc{
 	overflow: hidden;
 }
```

效果如下：

![image-20250120111808440](image-20250120111808440.png)

可以明显地看到间隔变大了，而且是原来的两倍，符合我们的预期。

## 13.画一个对话框

要画一个对话框，首先来学习做一个三角形。

```css
 .triangle{
 	width: 0;
 	height: 0;
 	border: 50px solid;
 	border-color: #f00 #0f0 #ccc #00f;
 }
```

```html
 <div class="triangle"></div>
```

出现如下效果：

![image-20250120140658875](image-20250120140658875.png)

已经知道border的构成原理，然后只需改一行代码：

```css
// 四个参数对应 ：上 右 下 左
border-color: transparent transparent #ccc transparent;
```

于是就只剩下面的三角形部分了

![image-20250120142851618](image-20250120142851618.png)

现在来利用三角形技术来做对话框：

```css
.dialog {
 	position: relative;
 	margin-top: 50px;
 	margin-left: 50px;
	padding-left: 20px;
 	width: 300px;
 	line-height: 2;
 	background: lightblue;
 	color: #fff;
 }
 .dialog::before {
 	content: '';
 	position: absolute;
 	border: 8px solid;
 	border-color: transparent lightblue transparent transparent;
 	left: -16px;
 	top: 8px;
 }
```

```html
 <div class="dialog">这是一个对话框鸭！</div>
```

效果如下：

![image-20250120144632758](image-20250120144632758.png)

## 14.画一个平行四边形

利用skew特性，第一个参数为x轴倾斜的角度，第二个参数为y轴倾斜的角度。

```css
 .parallel {
 	margin-top: 50px;
 	margin-left: 50px;
 	width: 200px;
 	height: 100px;
 	background: lightblue;
 	transform: skew(-20deg, 0);
 }
```

```html
 <div class="parallel"></div>
```

效果如下：

![image-20250120151947161](image-20250120151947161.png)

15.用一个div画一个五角星

![image-20250120152020896](image-20250120152020896.png)

对于这个五角星而言，我们可以拆分成三个部分，想一想是不是这样？

![image-20250120152040710](image-20250120152040710.png)

那我们现在就来实现这三个部分。 对于最上面的三角，我们在第一个部分已经实现了三角形，这个不 难。但是下面的两个如何实现呢？

 其实也非常的简单，想一想，下面这两个是不是就是一个向上的三角形旋转而来呢？明白了这一点，就 可以动手实现啦！

```css
 #star {
 	position: relative;
 	margin: 200px auto;
 	width: 0;
 	height: 0;
 	border-style: solid;
 	border-color: transparent transparent red transparent;
 	border-width: 70px 100px;
 	transform: rotate(35deg);
 }
 #star::before {
 	position: absolute;
 	content: '';
 	width: 0;
 	height: 0;
 	top: -128px;
 	left: -95px;
 	border-style: solid;
 	border-color: transparent transparent red transparent;
 	border-width: 80px 30px;
 	transform: rotate(-35deg);
 }
 #star::after {
 	position: absolute;
 	content: '';
 	width: 0;
 	height: 0;
 	top: -45px;
 	left: -140px;
 	border-style: solid;
	border-color: transparent transparent red transparent;
 	border-width: 70px 100px;
 	transform: rotate(-70deg);
 }
```

```html
 <div id="star"></div>
```

