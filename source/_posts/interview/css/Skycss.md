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

6.CSS如何进行品字布局