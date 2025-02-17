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

# grid布局

## 概述

网格布局（Grid）是最强大的 CSS 布局方案。

它将网页划分成一个个网格，可以任意组合不同的网格，做出各种各样的布局。以前，只能通过复杂的 CSS 框架达到的效果，现在浏览器内置了。

![image-20250214092503137]()

上图这样的布局，就是 Grid 布局的拿手好戏。

Grid 布局与 [Flex 布局](http://www.ruanyifeng.com/blog/2015/07/flex-grammar.html)有一定的相似性，都可以指定容器内部多个项目的位置。但是，它们也存在重大区别。

Flex 布局是轴线布局，只能指定"项目"针对轴线的位置，可以看作是**一维布局**。Grid 布局则是将容器划分成"行"和"列"，产生单元格，然后指定"项目所在"的单元格，可以看作是**二维布局**。Grid 布局远比 Flex 布局强大。

## 基本概念

### 容器和项目

采用网格布局的区域，称为"容器"（container）。容器内部采用网格定位的子元素，称为"项目"（item）。

```html
<div>
  <div><p>1</p></div>
  <div><p>2</p></div>
  <div><p>3</p></div>
</div>
```

上面代码中，最外层的`<div>`元素就是容器，内层的三个`<div>`元素就是项目。

注意：项目只能是容器的顶层子元素，不包含项目的子元素，比如上面代码的`<p>`元素就不是项目。Grid 布局只对项目生效。

### 行和列

容器里面的水平区域称为"行"（row），垂直区域称为"列"（column）。

![image-20250214103939208]()

上图中，水平的深色区域就是"行"，垂直的深色区域就是"列"。

### 单元格

行和列的交叉区域，称为"单元格"（cell）。

正常情况下，`n`行和`m`列会产生`n x m`个单元格。比如，3行3列会产生9个单元格。

### 网格线

划分网格的线，称为"网格线"（grid line）。水平网格线划分出行，垂直网格线划分出列。

正常情况下，`n`行有`n + 1`根水平网格线，`m`列有`m + 1`根垂直网格线，比如三行就有四根水平网格线。

![image-20250214104220598]()

上图是一个 4 x 4 的网格，共有5根水平网格线和5根垂直网格线。

## 容器属性

Grid 布局的属性分成两类。一类定义在容器上面，称为容器属性；另一类定义在项目上面，称为项目属性。这部分先介绍容器属性。

### display 属性

`display: grid`指定一个容器采用网格布局。

```css
div {
  display: grid;
}
```

![image-20250214104451618]()

上图是`display: grid`的[效果](https://jsbin.com/guvivum/edit?html,css,output)。

默认情况下，容器元素都是块级元素，但也可以设成行内元素。

```css
div {
  display: inline-grid;
}
```

上面代码指定`div`是一个行内元素，该元素内部采用网格布局。

![image-20250214104528759]()

图是`display: inline-grid`的[效果](https://jsbin.com/qatitav/edit?html,css,output)。

> 注意，设为网格布局以后，容器子元素（项目）的`float`、`display: inline-block`、`display: table-cell`、`vertical-align`和`column-*`等设置都将失效。

### grid-template-columns 属性， grid-template-rows 属性

容器指定了网格布局以后，接着就要划分行和列。`grid-template-columns`属性定义每一列的列宽，`grid-template-rows`属性定义每一行的行高。

```css
.container {
  display: grid;
  grid-template-columns: 100px 100px 100px;
  grid-template-rows: 100px 100px 100px;
}
```

[上面代码](https://jsbin.com/qiginur/edit?css,output)指定了一个三行三列的网格，列宽和行高都是`100px`。

![image-20250214142252090]()

除了使用绝对单位，也可以使用百分比。

```css
.container {
  display: grid;
  grid-template-columns: 33.33% 33.33% 33.33%;
  grid-template-rows: 33.33% 33.33% 33.33%;
}
```

#### repeat()

有时候，重复写同样的值非常麻烦，尤其网格很多时。这时，可以使用`repeat()`函数，简化重复的值。上面的代码用`repeat()`改写如下。

```css
.container {
  display: grid;
  grid-template-columns: repeat(3, 33.33%);
  grid-template-rows: repeat(3, 33.33%);
}
```

`repeat()`接受两个参数，第一个参数是重复的次数（上例是3），第二个参数是所要重复的值。

`repeat()`重复某种模式也是可以的。

```css
grid-template-columns: repeat(2, 100px 20px 80px);
```

[上面代码](https://jsbin.com/cokohu/edit?css,output)定义了6列，第一列和第四列的宽度为`100px`，第二列和第五列为`20px`，第三列和第六列为`80px`。

![image-20250214171002920]()

#### auto-fill 关键字

有时，单元格的大小是固定的，但是容器的大小不确定。如果希望每一行（或每一列）容纳尽可能多的单元格，这时可以使用`auto-fill`关键字表示自动填充。

```css
.container {
  display: grid;
  grid-template-columns: repeat(auto-fill, 100px);
}
```

[上面代码](https://jsbin.com/himoku/edit?css,output)表示每列宽度`100px`，然后自动填充，直到容器不能放置更多的列。

![image-20250217145257668]()

除了`auto-fill`，还有一个关键字`auto-fit`，两者的行为基本是相同的。只有当容器足够宽，可以在一行容纳所有单元格，并且单元格宽度不固定的时候，才会有[行为差异](https://css-tricks.com/auto-sizing-columns-css-grid-auto-fill-vs-auto-fit/)：`auto-fill`会用空格子填满剩余宽度，`auto-fit`则会尽量扩大单元格的宽度。

#### fr 关键字

为了方便表示比例关系，网格布局提供了`fr`关键字（fraction 的缩写，意为"片段"）。如果两列的宽度分别为`1fr`和`2fr`，就表示后者是前者的两倍。

```css
.container {
  display: grid;
  grid-template-columns: 1fr 1fr;
}
```

[上面代码](https://jsbin.com/hadexek/edit?html,css,output)表示两个相同宽度的列。

![image-20250217145440478]()

`fr`可以与绝对长度的单位结合使用，这时会非常方便。

```css
.container {
  display: grid;
  grid-template-columns: 150px 1fr 2fr;
}
```

[上面代码](https://jsbin.com/remowec/edit?html,css,output)表示，第一列的宽度为150像素，第二列的宽度是第三列的一半。

![image-20250217145511871]()

#### minmax()

`minmax()`函数产生一个长度范围，表示长度就在这个范围之中。它接受两个参数，分别为最小值和最大值。

```css
grid-template-columns: 1fr 1fr minmax(100px, 1fr);
```

上面代码中，`minmax(100px, 1fr)`表示列宽不小于`100px`，不大于`1fr`。

#### auto关键字

`auto`关键字表示由浏览器自己决定长度。

```css
grid-template-columns: 100px auto 100px;
```

上面代码中，第二列的宽度，基本上等于该列单元格的最大宽度，除非单元格内容设置了`min-width`，且这个值大于最大宽度。

#### 网格线的名称

`grid-template-columns`属性和`grid-template-rows`属性里面，还可以使用方括号，指定每一根网格线的名字，方便以后的引用。

```css
.container {
  display: grid;
  grid-template-columns: [c1] 100px [c2] 100px [c3] auto [c4];
  grid-template-rows: [r1] 100px [r2] 100px [r3] auto [r4];
}
```

上面代码指定网格布局为3行 x 3列，因此有4根垂直网格线和4根水平网格线。方括号里面依次是这八根线的名字。

网格布局允许同一根线有多个名字，比如`[fifth-line row-5]`。

布局实例

`grid-template-columns`属性对于网页布局非常有用。两栏式布局只需要一行代码。

```css
.wrapper {
  display: grid;
  grid-template-columns: 70% 30%;
}
```

上面代码将左边栏设为70%，右边栏设为30%。

传统的十二网格布局，写起来也很容易。

```css
grid-template-columns: repeat(12, 1fr);
```

### grid-row-gap 属性， grid-column-gap 属性， grid-gap 属性

`grid-row-gap`属性设置行与行的间隔（行间距），`grid-column-gap`属性设置列与列的间隔（列间距）。

```css
.container {
  grid-row-gap: 20px;
  grid-column-gap: 20px;
}
```

[上面代码](https://jsbin.com/mezufab/edit?css,output)中，`grid-row-gap`用于设置行间距，`grid-column-gap`用于设置列间距。

![image-20250217151654462]()

`grid-gap`属性是`grid-column-gap`和`grid-row-gap`的合并简写形式，语法如下。

```css
grid-gap: <grid-row-gap> <grid-column-gap>;
```

因此，上面一段 CSS 代码等同于下面的代码。

```css
.container {
  grid-gap: 20px 20px;
}
```

如果`grid-gap`省略了第二个值，浏览器认为第二个值等于第一个值。

> 根据最新标准，上面三个属性名的`grid-`前缀已经删除，`grid-column-gap`和`grid-row-gap`写成`column-gap`和`row-gap`，`grid-gap`写成`gap`。

### grid-template-areas属性

网格布局允许指定"区域"（area），一个区域由单个或多个单元格组成。`grid-template-areas`属性用于定义区域。

```css
.container {
  display: grid;
  grid-template-columns: 100px 100px 100px;
  grid-template-rows: 100px 100px 100px;
  grid-template-areas: 'a b c'
                       'd e f'
                       'g h i';
}
```

上面代码先划分出9个单元格，然后将其定名为`a`到`i`的九个区域，分别对应这九个单元格。

多个单元格合并成一个区域的写法如下。

```css
grid-template-areas: 'a a a'
                     'b b b'
                     'c c c';
```

上面代码将9个单元格分成`a`、`b`、`c`三个区域。

下面是一个布局实例。

```css
grid-template-areas: "header header header"
                     "main main sidebar"
                     "footer footer footer";
```

上面代码中，顶部是页眉区域`header`，底部是页脚区域`footer`，中间部分则为`main`和`sidebar`。

如果某些区域不需要利用，则使用"点"（`.`）表示。

```css
grid-template-areas: 'a . c'
                     'd . f'
                     'g . i';
```

上面代码中，中间一列为点，表示没有用到该单元格，或者该单元格不属于任何区域。

> 注意，区域的命名会影响到网格线。每个区域的起始网格线，会自动命名为`区域名-start`，终止网格线自动命名为`区域名-end`。
>
> 比如，区域名为`header`，则起始位置的水平网格线和垂直网格线叫做`header-start`，终止位置的水平网格线和垂直网格线叫做`header-end`。

### grid-auto-flow属性

划分网格以后，容器的子元素会按照顺序，自动放置在每一个网格。默认的放置顺序是"先行后列"，即先填满第一行，再开始放入第二行，即下图数字的顺序。

![image-20250217154852533]()

这个顺序由`grid-auto-flow`属性决定，默认值是`row`，即"先行后列"。也可以将它设成`column`，变成"先列后行"。

```css
grid-auto-flow: column;
```

[上面代码](https://jsbin.com/xutokec/edit?css,output)设置了`column`以后，放置顺序就变成了下图。

![image-20250217154928070]()

`grid-auto-flow`属性除了设置成`row`和`column`，还可以设成`row dense`和`column dense`。这两个值主要用于，某些项目指定位置以后，剩下的项目怎么自动放置。

[下面的例子](https://jsbin.com/wapejok/edit?css,output)让1号项目和2号项目各占据两个单元格，然后在默认的`grid-auto-flow: row`情况下，会产生下面这样的布局。

![image-20250217155042782]()

上图中，1号项目后面的位置是空的，这是因为3号项目默认跟着2号项目，所以会排在2号项目后面。

现在修改设置，设为`row dense`，表示"先行后列"，并且尽可能紧密填满，尽量不出现空格。

```css
grid-auto-flow: row dense;
```

[上面代码](https://jsbin.com/helewuy/edit?css,output)的效果如下。

![image-20250217155153485]()

上图会先填满第一行，再填满第二行，所以3号项目就会紧跟在1号项目的后面。8号项目和9号项目就会排到第四行。

如果将设置改为`column dense`，表示"先列后行"，并且尽量填满空格。

```css
grid-auto-flow: column dense;
```

[上面代码](https://jsbin.com/pupoduc/1/edit?html,css,output)的效果如下。

![image-20250217155219584]()

上图会先填满第一列，再填满第2列，所以3号项目在第一列，4号项目在第二列。8号项目和9号项目被挤到了第四列。

### justify-items 属性， align-items 属性， place-items 属性

`justify-items`属性设置单元格内容的水平位置（左中右），`align-items`属性设置单元格内容的垂直位置（上中下）。

```css
.container {
  justify-items: start | end | center | stretch;
  align-items: start | end | center | stretch;
}
```

这两个属性的写法完全相同，都可以取下面这些值。

- start：对齐单元格的起始边缘。
- end：对齐单元格的结束边缘。
- center：单元格内部居中。
- stretch：拉伸，占满单元格的整个宽度（默认值）。

```css
.container {
  justify-items: start;
}
```

[上面代码](https://jsbin.com/gijeqej/edit?css,output)表示，单元格的内容左对齐，效果如下图。

![image-20250217160910410]()

```css
.container {
  align-items: start;
}
```

[上面代码](https://jsbin.com/tecawur/edit?css,output)表示，单元格的内容头部对齐，效果如下图。

![image-20250217160931167]()

`place-items`属性是`align-items`属性和`justify-items`属性的合并简写形式。

```css
place-items: <align-items> <justify-items>;
```

下面是一个例子。

```css
place-items: start end;
```

如果省略第二个值，则浏览器认为与第一个值相等。

### justify-content 属性， align-content 属性， place-content 属性

`justify-content`属性是整个内容区域在容器里面的水平位置（左中右），`align-content`属性是整个内容区域的垂直位置（上中下）。

```css
.container {
  justify-content: start | end | center | stretch | space-around | space-between | space-evenly;
  align-content: start | end | center | stretch | space-around | space-between | space-evenly;  
}
```

这两个属性的写法完全相同，都可以取下面这些值。（下面的图都以`justify-content`属性为例，`align-content`属性的图完全一样，只是将水平方向改成垂直方向。）

- start - 对齐容器的起始边框。

![image-20250217162759722]()

- end - 对齐容器的结束边框。

![image-20250217162821049]()

- center - 容器内部居中。

![image-20250217162839507]()

- stretch - 项目大小没有指定时，拉伸占据整个网格容器。

![image-20250217162856767]()

- space-around - 每个项目两侧的间隔相等。所以，项目之间的间隔比项目与容器边框的间隔大一倍。

![image-20250217162920567]()

- space-between - 项目与项目的间隔相等，项目与容器边框之间没有间隔。

![image-20250217163249048]()

- space-evenly - 项目与项目的间隔相等，项目与容器边框之间也是同样长度的间隔。

![image-20250217163319883]()

`place-content`属性是`align-content`属性和`justify-content`属性的合并简写形式。

```css
place-content: <align-content> <justify-content>
```

下面是一个例子。

```css
place-content: space-around space-evenly;
```

如果省略第二个值，浏览器就会假定第二个值等于第一个值。

### grid-auto-columns 属性， grid-auto-rows 属性

有时候，一些项目的指定位置，在现有网格的外部。比如网格只有3列，但是某一个项目指定在第5行。这时，浏览器会自动生成多余的网格，以便放置项目。

`grid-auto-columns`属性和`grid-auto-rows`属性用来设置，浏览器自动创建的多余网格的列宽和行高。它们的写法与`grid-template-columns`和`grid-template-rows`完全相同。如果不指定这两个属性，浏览器完全根据单元格内容的大小，决定新增网格的列宽和行高。

[下面的例子](https://jsbin.com/sayuric/edit?css,output)里面，划分好的网格是3行 x 3列，但是，8号项目指定在第4行，9号项目指定在第5行。

```css
.container {
  display: grid;
  grid-template-columns: 100px 100px 100px;
  grid-template-rows: 100px 100px 100px;
  grid-auto-rows: 50px; 
}
```

上面代码指定新增的行高统一为50px（原始的行高为100px）。

![image-20250217163707189]()

### grid-template 属性， grid 属性

`grid-template`属性是`grid-template-columns`、`grid-template-rows`和`grid-template-areas`这三个属性的合并简写形式。

`grid`属性是`grid-template-rows`、`grid-template-columns`、`grid-template-areas`、 `grid-auto-rows`、`grid-auto-columns`、`grid-auto-flow`这六个属性的合并简写形式。

从易读易写的角度考虑，还是建议不要合并属性，所以这里就不详细介绍这两个属性了。

## 项目属性

### grid-column-start 属性， grid-column-end 属性， grid-row-start 属性， grid-row-end 属性

项目的位置是可以指定的，具体方法就是指定项目的四个边框，分别定位在哪根网格线。

- `grid-column-start`属性：左边框所在的垂直网格线
- `grid-column-end`属性：右边框所在的垂直网格线
- `grid-row-start`属性：上边框所在的水平网格线
- `grid-row-end`属性：下边框所在的水平网格线

```css
.item-1 {
  grid-column-start: 2;
  grid-column-end: 4;
}
```

[上面代码](https://jsbin.com/yukobuf/edit?css,output)指定，1号项目的左边框是第二根垂直网格线，右边框是第四根垂直网格线。

![image-20250217173421290]()

上图中，只指定了1号项目的左右边框，没有指定上下边框，所以会采用默认位置，即上边框是第一根水平网格线，下边框是第二根水平网格线。

除了1号项目以外，其他项目都没有指定位置，由浏览器自动布局，这时它们的位置由容器的`grid-auto-flow`属性决定，这个属性的默认值是`row`，因此会"先行后列"进行排列。读者可以把这个属性的值分别改成`column`、`row dense`和`column dense`，看看其他项目的位置发生了怎样的变化。

[下面的例子](https://jsbin.com/nagobey/edit?html,css,output)是指定四个边框位置的效果。

```css
.item-1 {
  grid-column-start: 1;
  grid-column-end: 3;
  grid-row-start: 2;
  grid-row-end: 4;
}
```

![image-20250217173910635]()

这四个属性的值，除了指定为第几个网格线，还可以指定为网格线的名字。

```css
.item-1 {
  grid-column-start: header-start;
  grid-column-end: header-end;
}
```

上面代码中，左边框和右边框的位置，都指定为网格线的名字。

这四个属性的值还可以使用`span`关键字，表示"跨越"，即左右边框（上下边框）之间跨越多少个网格。

```css
.item-1 {
  grid-column-start: span 2;
}
```

![image-20250217174235083]()

这与[下面的代码](https://jsbin.com/mujihib/edit?html,css,output)效果完全一样。

```css
.item-1 {
  grid-column-end: span 2;
}
```

使用这四个属性，如果产生了项目的重叠，则使用`z-index`属性指定项目的重叠顺序。

### grid-column 属性， grid-row 属性

`grid-column`属性是`grid-column-start`和`grid-column-end`的合并简写形式，`grid-row`属性是`grid-row-start`属性和`grid-row-end`的合并简写形式。

```css
.item {
  grid-column: <start-line> / <end-line>;
  grid-row: <start-line> / <end-line>;
}
```

下面是一个例子。

```css
.item-1 {
  grid-column: 1 / 3;
  grid-row: 1 / 2;
}
/* 等同于 */
.item-1 {
  grid-column-start: 1;
  grid-column-end: 3;
  grid-row-start: 1;
  grid-row-end: 2;
}
```

上面代码中，项目`item-1`占据第一行，从第一根列线到第三根列线。

这两个属性之中，也可以使用`span`关键字，表示跨越多少个网格。

```css
.item-1 {
  background: #b03532;
  grid-column: 1 / 3;
  grid-row: 1 / 3;
}
/* 等同于 */
.item-1 {
  background: #b03532;
  grid-column: 1 / span 2;
  grid-row: 1 / span 2;
```

[上面代码](https://jsbin.com/volugow/edit?html,css,output)中，项目`item-1`占据的区域，包括第一行 + 第二行、第一列 + 第二列。

![image-20250217180424244]()

斜杠以及后面的部分可以省略，默认跨越一个网格。

```css
.item-1 {
  grid-column: 1;
  grid-row: 1;
}
```

上面代码中，项目`item-1`占据左上角第一个网格。

### grid-area 属性

`grid-area`属性指定项目放在哪一个区域。

```css
.item-1 {
  grid-area: e;
}
```

[上面代码](https://jsbin.com/qokexob/edit?css,output)中，1号项目位于`e`区域，效果如下图。

![image-20250217181459802]()

`grid-area`属性还可用作`grid-row-start`、`grid-column-start`、`grid-row-end`、`grid-column-end`的合并简写形式，直接指定项目的位置。

```css
item {
  grid-area: <row-start> / <column-start> / <row-end> / <column-end>;
}
```

下面是一个[例子](https://jsbin.com/duyafez/edit?css,output)。

```css
.item-1 {
  grid-area: 1 / 1 / 3 / 3;
}
```

### justify-self 属性， align-self 属性， place-self 属性

`justify-self`属性设置单元格内容的水平位置（左中右），跟`justify-items`属性的用法完全一致，但只作用于单个项目。

`align-self`属性设置单元格内容的垂直位置（上中下），跟`align-items`属性的用法完全一致，也是只作用于单个项目。

```css
.item {
  justify-self: start | end | center | stretch;
  align-self: start | end | center | stretch;
}
```

这两个属性都可以取下面四个值。

- start：对齐单元格的起始边缘。
- end：对齐单元格的结束边缘。
- center：单元格内部居中。
- stretch：拉伸，占满单元格的整个宽度（默认值）。

下面是`justify-self: start`的例子。

![image-20250217192221824]()

`place-self`属性是`align-self`属性和`justify-self`属性的合并简写形式。

```css
place-self: <align-self> <justify-self>;
```

下面是一个例子。

```css
place-self: center center;
```

如果省略第二个值，`place-self`属性会认为这两个值相等。
