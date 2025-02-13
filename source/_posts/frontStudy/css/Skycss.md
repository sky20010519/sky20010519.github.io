---
title: css
categories: 
    - 前端学习
    - css
tags:
  - css
abbrlink: 78cea6d8
date: 2025-01-02 18:12:38
---

**本文讲述了css的相关教程**

<!-- more -->

# float属性

## 常规的文档流

首先要知道，div是块级元素，在页面中独占一行，自上而下排列，也就是传说中的流。如下图：

![这里写图片描述](cc73e3d9e268eb4f05bbcf9fc20ad074.png)

可以看出，即使div1的宽度很小，页面中一行可以容下div1和div2，div2也不会排在div1后边，因为div元素是独占一行的。

注意，以上这些理论，是指标准流中的div。无论多么复杂的布局，其基本出发点均是：**“如何在一行显示多个div元素”。**
显然标准流已经无法满足需求，这就要用到浮动。

## 浮动

**浮动可以理解为让某个div元素脱离标准流，漂浮在标准流之上，和标准流不是一个层次。**

例如，假设上图中的div2浮动，那么它将脱离标准流，但div1、div3、div4仍然在标准流当中，所以div3会自动向上移动，占据div2的位置，重新组成一个流。如图：

![这里写图片描述](f631cea576f0b1352c120b4e271abee0.png)

从图中可以看出，由于对div2设置浮动，因此它不再属于标准流，div3自动上移顶替div2的位置，div1、div3、div4依次排列，成为一个新的流。又因为浮动是漂浮在标准流之上的，因此div2挡住了一部分div3，div3看起来变“矮”了。

这里div2用的是左浮动(float:left;)，可以理解为漂浮起来后靠左排列，右浮动(float:right;)当然就是靠右排列。这里的靠左、靠右是说页面的左、右边缘。

如果我们把div2采用右浮动，会是如下效果：

![这里写图片描述](225f67795a829c9500fa38341e12ae03.png)

此时div2靠页面右边缘排列，不再遮挡div3，读者可以清晰的看到上面所讲的div1、div3、div4组成的流。

目前为止我们只浮动了一个div元素，多个呢？

下面我们把div2和div3都加上左浮动，效果如图

![这里写图片描述](66cc6971ca1bc34184d032b083e019bc.png)

同理，由于div2、div3浮动，它们不再属于标准流，因此div4会自动上移，与div1组成一个“新”标准流，而浮动是漂浮在标准流之上，因此div2又挡住了div4。

到重点了，当同时对div2、div3设置浮动之后，div3会跟随在div2之后，不知道读者有没有发现，一直到现在，div2在每个例子中都是浮动的，但并没有跟随到div1之后。因此，我们可以得出一个重要结论：

> 假如某个div元素A是浮动的，如果A元素上一个元素也是浮动的，那么A元素会跟随在上一个元素的后边(如果一行放不下这两个元素，那么A元素会被挤到下一行)；如果A元素上一个元素是标准流中的元素，那么A的相对垂直位置不会改变，也就是说A的顶部总是和上一个元素的底部对齐。

div的顺序是HTML代码中div的顺序决定的。
靠近页面边缘的一端是前，远离页面边缘的一端是后。

![这里写图片描述](58b193191cdc711c414b13f77b47a51d.png)

为了帮助读者理解，再举几个例子。

假如我们把div2、div3、div4都设置成**左**浮动，效果如下：

![这里写图片描述](aaa6a6b1c85061a55aeeb1053913d165.png)

先从div4开始分析，它发现上边的元素div3是浮动的，所以div4会跟随在div3之后；div3发现上边的元素div2也是浮动的，所以div3会跟随在div2之后；而div2发现上边的元素div1是标准流中的元素，因此div2的相对垂直位置不变，顶部仍然和div1元素的底部对齐。

由于是左浮动，左边靠近页面边缘，所以左边是前，因此div2在最左边。

假如把div2、div3、div4都设置成**右**浮动，效果如下：

![这里写图片描述](62a88d508ed2c83522c73655e2795653.png)

道理和左浮动基本一样，只不过需要注意一下前后对应关系。由于是右浮动，因此右边靠近页面边缘，所以右边是前，因此div2在最右边。

假如我们把div2、div4左浮动，效果图如下：

![这里写图片描述](1507847d155c9cfef2e1fd6ec7ebe8e4.png)

依然是根据结论，div2、div4浮动，脱离了标准流，因此div3将会自动上移，与div1组成标准流。div2发现上一个元素div1是标准流中的元素，因此div2相对垂直位置不变，与div1底部对齐。div4发现上一个元素div3是标准流中的元素，因此div4的顶部和div3的底部对齐，并且总是成立的，因为从图中可以看出，div3上移后，div4也跟着上移，**div4总是保证自己的顶部和上一个元素div3(标准流中的元素)的底部对齐。**

至此，恭喜读者已经掌握了添加浮动，但还有清除浮动，有上边的基础清除浮动非常容易理解。

经过上边的学习，可以看出：元素浮动之前，也就是在标准流中，是竖向排列的，而浮动之后可以理解为横向排列。

## 清除浮动

**清除浮动可以理解为打破横向排列。**

```
   清除浮动的关键字是clear，官方定义如下：



   语法：

   clear : none | left | right | both

   取值：

   none  :  默认值。允许两边都可以有浮动对象

   left   :  不允许左边有浮动对象

   right  :  不允许右边有浮动对象

   both  :  不允许有浮动对象

```

定义非常容易理解，但是读者实际使用时可能会发现不是这么回事。
定义没有错，只不过它描述的太模糊，让我们不知所措。

根据上边的基础，假如页面中只有两个元素div1、div2，它们都是左浮动，场景如下：

![这里写图片描述](2b181404c02b7cc27dbc7671d03df25c.png)

此时div1、div2都浮动，根据规则，div2会跟随在div1后边，但我们仍然希望div2能排列在div1下边，就像div1没有浮动，div2左浮动那样。

这时候就要用到清除浮动（clear），如果单纯根据官方定义，读者可能会尝试这样写：在div1的CSS样式中添加clear:right;，理解为不允许div1的右边有浮动元素，由于div2是浮动元素，因此会自动下移一行来满足规则。

其实这种理解是不正确的，这样做没有任何效果。

> 对于CSS的清除浮动(clear)，一定要牢记：这个规则只能影响使用清除的元素本身，不能影响其他元素。

怎么理解呢？就拿上边的例子来说，我们是想让div2移动，但我们却是在div1元素的CSS样式中使用了清除浮动，试图通过清除div1右边的浮动元素(clear:right;)来强迫div2下移，这是不可行的，因为这个清除浮动是在div1中调用的，它只能影响div1，不能影响div2。

要想让div2下移，就必须在div2的CSS样式中使用浮动。本例中div2的左边有浮动元素div1，因此只要在div2的CSS样式中使用clear:left;来指定div2元素左边不允许出现浮动元素，这样div2就被迫下移一行。

![这里写图片描述](d67470f7c5b3bbb7b2180dd3fe05e838.png)

那么假如页面中只有两个元素div1、div2，它们都是右浮动呢？读者此时应该已经能自己推测场景，如下：

![这里写图片描述](be221da4669ce7690f1eb2f429716a02.png)

此时如果要让div2下移到div1下边，要如何做呢？

我们希望移动的是div2，就必须在div2的CSS样式中调用浮动，因为浮动只能影响调用它的元素。

可以看出div2的右边有一个浮动元素div1，那么我们可以在div2的CSS样式中使用`clear:right;`来指定div2的右边不允许出现浮动元素，这样div2就被迫下移一行，排到div1下边。

至此，读者已经掌握了CSS+DIV浮动定位基本原理，足以应付常见的布局。

# flex布局

## flex布局是什么？

Flex 是 Flexible Box 的缩写，意为"弹性布局"，用来为盒状模型提供最大的灵活性。

任何一个容器都可以指定为 Flex 布局。

```scss
.box{
	display:flex;
}
```

行内元素也可以使用 Flex 布局。

```scss
.box{
  display: inline-flex;
}
```

Webkit 内核的浏览器，必须加上`-webkit`前缀。

```scss
.box{
  display: -webkit-flex; /* Safari */
  display: flex;
}
```

> 注意，设为 Flex 布局以后，子元素的`float`、`clear`和`vertical-align`属性将失效。

## 基本概念

采用 Flex 布局的元素，称为 Flex 容器（flex container），简称"容器"。它的所有子元素自动成为容器成员，称为 Flex 项目（flex item），简称"项目"。

![image-20250212165804120]()

容器默认存在两根轴：水平的主轴（main axis）和垂直的交叉轴（cross axis）。主轴的开始位置（与边框的交叉点）叫做`main start`，结束位置叫做`main end`；交叉轴的开始位置叫做`cross start`，结束位置叫做`cross end`。

项目默认沿主轴排列。单个项目占据的主轴空间叫做`main size`，占据的交叉轴空间叫做`cross size`。

## 容器的属性

- flex-direction
- flex-wrap
- flex-flow
- justify-content
- align-items
- align-content

### flex-direction属性

`flex-direction`属性决定主轴的方向（即项目的排列方向）。

```scss
.box {
  flex-direction: column-reverse | column | row  | row-reverse;//依次向上，向下，向右，向左
}
```

![image-20250212170632182]()

### flex-wrap属性

默认情况下，项目都排在一条线（又称"轴线"）上。`flex-wrap`属性定义，如果一条轴线排不下，如何换行。

![image-20250212170948683]()

1. nowrap(默认)：不换行。

   ![image-20250212171135773]()

2. `wrap`：换行，第一行在上方

   ![image-20250212171207022]()

3. `wrap-reverse`：换行，第一行在下方。

   ![image-20250212171237346]()

### flex-flow

`flex-flow`属性是`flex-direction`属性和`flex-wrap`属性的简写形式，默认值为`row nowrap`。

```css
.box {
  flex-flow: <flex-direction> || <flex-wrap>;
}
```

### justify-content属性

`justify-content`属性定义了项目在主轴上的对齐方式。

```css
.box {
  justify-content: flex-start | flex-end | center | space-between | space-around;
}
```

![image-20250212171511251]()

### align-items属性

`align-items`属性定义项目在交叉轴上如何对齐。

```scss
.box {
  align-items: flex-start | flex-end | center | baseline | stretch;
}
```

![image-20250213134911149]()

### align-content

`align-content`属性定义了多根轴线的对齐方式。如果项目只有一根轴线，该属性不起作用。

```css
.box {
  align-content: flex-start | flex-end | center | space-between | space-around | stretch;
}
```

![image-20250213135135247]()

## 项目的属性

### order属性

`order`属性定义项目的排列顺序。数值越小，排列越靠前，默认为0。

```css
.item {
  order: <integer>;
}
```

![image-20250213142549852]()

### flex-grow属性

`flex-grow`属性定义项目的放大比例，默认为`0`，即如果存在剩余空间，也不放大。

```css
.item {
  flex-grow: <number>; /* default 0 */
}
```

![image-20250213142744699]()

如果所有项目的`flex-grow`属性都为1，则它们将等分剩余空间（如果有的话）。如果一个项目的`flex-grow`属性为2，其他项目都为1，则前者占据的剩余空间将比其他项多一倍。

### flex-shrink属性

`flex-shrink`属性定义了项目的缩小比例，默认为1，即如果空间不足，该项目将缩小。

```css
.item {
  flex-shrink: <number>; /* default 1 */
}
```

![image-20250213143955922]()

如果所有项目的`flex-shrink`属性都为1，当空间不足时，都将等比例缩小。如果一个项目的`flex-shrink`属性为0，其他项目都为1，则空间不足时，前者不缩小。

负值对该属性无效。

### flex-basis属性

`flex-basis`属性定义了在分配多余空间之前，项目占据的主轴空间（main size）。浏览器根据这个属性，计算主轴是否有多余空间。它的默认值为`auto`，即项目的本来大小。

```css
.item {
  flex-basis: <length> | auto; /* default auto */
}
```

它可以设为跟`width`或`height`属性一样的值（比如350px），则项目将占据固定空间。

### flex属性

`flex`属性是`flex-grow`, `flex-shrink` 和 `flex-basis`的简写，默认值为`0 1 auto`。后两个属性可选。

```css
.item {
  flex: none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]
}
```

该属性有两个快捷值：`auto` (`1 1 auto`) 和 none (`0 0 auto`)。

建议优先使用这个属性，而不是单独写三个分离的属性，因为浏览器会推算相关值。

### align-self属性

`align-self`属性允许单个项目有与其他项目不一样的对齐方式，可覆盖`align-items`属性。默认值为`auto`，表示继承父元素的`align-items`属性，如果没有父元素，则等同于`stretch`。

```css
.item {
  align-self: auto | flex-start | flex-end | center | baseline | stretch;
}
```

![image-20250213163629868]()
