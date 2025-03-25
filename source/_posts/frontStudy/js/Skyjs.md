---
title: js
categories: 
  - 前端学习
  - js
tags:
  - js
abbrlink: 17c7b154
date: 2025-01-02 18:12:38
---

**本文讲述了js的相关教程**

<!-- more -->

# 数组方法

| 顺序 |    方法名     |                             功能                             |                       返回值                       | 是否改变原数组 | 版本 |
| :--: | :-----------: | :----------------------------------------------------------: | :------------------------------------------------: | :------------: | ---- |
|  1   |    push()     |                (在结尾)向数组添加一或多个元素                |                   返回新数组长度                   |       Y        | ES5- |
|  2   |   unshift()   |               （在开头)向数组添加一或多个元素                |                   返回新数组长度                   |       Y        | ES5- |
|  3   |     pop()     |                      删除数组的最后一位                      |                  返回被删除的数据                  |       Y        | ES5- |
|  4   |    shift()    |                       移除数组的第一项                       |                  返回被删除的数据                  |       Y        | ES5- |
|  5   |   reverse()   |                       反转数组中的元素                       |                   返回反转后数组                   |       Y        | ES5- |
|  6   |    sort()     |         以字母顺序(字符串Unicode码点)对数组进行排序          |                     返回新数组                     |       Y        | ES5- |
|  7   |   splice()    | 在指定位置删除指定个数元素再增加任意个数元素 （实现数组任意位置的增删改) |             返回删除的数据所组成的数组             |       Y        | ES5- |
|  8   |   concat()    |           通过合并（连接）现有数组来创建一个新数组           |                 返回合并之后的数组                 |       N        | ES5- |
|  9   |    join()     |         用特定的字符,将数组拼接形成字符串 (默认",")          |                 返回拼接后的字符串                 |       N        | ES5- |
|  10  |    slice()    |                      裁切指定位置的数组                      |               被裁切的元素形成的数组               |       N        | ES5- |
|  11  |  toString()   |                      将数组转换为字符串                      |                       字符串                       |       N        | ES5- |
|  12  |   valueOf()   |                        查询数组原始值                        |                    数组的原始值                    |       N        | ES5- |
|  13  |   indexOf()   |             查询某个元素在数组中第一次出现的位置             |         存在该元素,返回下标,不存在 返回 -1         |       N        | ES5- |
|  14  | lastIndexOf() |         反向查询数组某个元素在数组中第一次出现的位置         |         存在该元素,返回下标,不存在 返回 -1         |       N        | ES5- |
|  15  |   forEach()   |         (迭代) 遍历数组,每次循环中执行传入的回调函数         |                   无/(undefined)                   |       N        | ES5- |
|  16  |     map()     | (迭代) 遍历数组, 每次循环时执行传入的回调函数,根据回调函数的返回值,生成一个新的数组 |                     有/自定义                      |       N        | ES5- |
|  17  |   filter()    | (迭代) 遍历数组, 每次循环时执行传入的回调函数,回调函数返回一个条件,把满足条件的元素筛选出来放到新数组中 |             满足条件的元素组成的新数组             |       N        | ES5- |
|  18  |    every()    |         (迭代) 判断数组中所有的元素是否满足某个条件          |    全都满足返回true 只要有一个不满足 返回false     |       N        | ES5- |
|  19  |    some()     |         (迭代) 判断数组中是否存在,满足某个条件的元素         | 只要有一个元素满足条件就返回true,都不满足返回false |       N        | ES5- |
|  20  |   reduce()    | (归并)遍历数组, 每次循环时执行传入的回调函数,回调函数会返回一个值,将该值作为初始值prev,传入到下一次函数中 |                   最终操作的结果                   |       N        | ES5- |
|  21  | reduceRight() |             (归并)用法同reduce,只不过是从右向左              |                      同reduce                      |       N        | ES5- |
|  22  |  includes()   |              判断一个数组是否包含一个指定的值.               |               是返回 true，否则false               |       N        | ES6  |
|  23  | Array.from()  |                 接收伪数组,返回对应的真数组                  |                    对应的真数组                    |       N        | ES6  |
|  24  |    find()     | 遍历数组,执行回调函数,回调函数执行一个条件,返回满足条件的第一个元素,不存在返回undefined |        满足条件第一个元素/否则返回undefined        |       N        | ES6  |
|  25  |  findIndex()  | 遍历数组,执行回调函数,回调函数接受一个条件,返回满足条件的第一个元素下标,不存在返回-1 |         满足条件第一个元素下标,不存在=>-1          |       N        | ES6  |
|  26  |    fill()     |                     用给定值填充一个数组                     |                       新数组                       |       Y        | ES6  |
|  27  |    flat()     |           用于将嵌套的数组“拉平”，变成一维的数组。           |                   返回一个新数组                   |       N        | ES6  |
|  28  |   flatMap()   | flat()和map()的组合版 , 先通过map()返回一个新数组,再将数组拉平( 只能拉平一次 ) |                     返回新数组                     |       N        | ES6  |

## 方法详解

### push

功能: 在数组**最后一位***添加*一个或多个元素,并返回新数组的长度,改变原数组.(添加多个元素用逗号隔开)

```js
 var arr = [1, 2, "c"];
 var rel = arr.push("A", "B");
 console.log(arr); // [1, 2, "c", "A", "B"]
 console.log(rel); //  5  (数组长度)
```

### unshift

功能: 在数组**第一位***添加*一个或多个元素，并返回新数组的长度，改变原数组。(添加多个元素用逗号隔开)

```js
 var arr = [1, 2, "c"];
 var rel = arr.unshift("A", "B");
 console.log(arr); // [ "A", "B",1, 2, "c"]
 console.log(rel); //  5  (数组长度)
```

### pop

功能：删除数组的最后一位，并且返回删除的数据，会改变原来的数组。（该方法不接受参数，且每次只能删除最后一个）

```js
   var arr = [1, 2, "c"];
   var rel = arr.pop();
   console.log(arr); // [1, 2]
   console.log(rel); // c
```

### shift

功能：删除数组的第一位数据，并且返回被删除的数据,会改变原来的数组。（该方法同pop();一样不接受参数，且每次只能删除数组第一个）

```js
    var arr = ["a","b", "c"];
    var rel = arr.shift();
    console.log(arr); // ['b', "c"]
    console.log(rel); // a
```

### reverse

功能：将数组的数据进行反转，并且返回反转后的数组，会改变原数组

```js
  var arr = [1, 2, 3, "a", "b", "c"];
  var rel = arr.reverse();
  console.log(arr); //    [1, 2, 3, "a", "b", "c"]
  console.log(rel); //    ["c", "b", "a", 3, 2, 1]
```

### sort

sort() 方法是最强大的数组方法之一。

sort()：方法用于对数组的元素进行排序，返回数组。默认排序是根据字符串Unicode码点

```js
  var arr1 = [10, 1, 5, 2, 3];
  arr1.sort();
  console.log(arr1);
```

结果

```js
[1,10,2,3,5]
```

结果并不是我们想要的排序结果，因为他是根据unicode编码来排序的，这也显示了其不稳定性。

语法：arr.sort(function(a,b))

参数：function可选，用来指定某种顺序进行排列的函数。如果省略，元素按照转换为字符串的Unicode位点进行排序。

具体用法：

- 如果function(a,b){return: a-b}, => a-b>0,那么a会被排序到b之前；（从小到大排序）
- 如果function(a,b){return: b-a}, => b-a>0,那么b会被排序到a之前；（从大到小排序）

注：js的sort排序函数a-b>0两数就交换位置，=0不换

那么我们就可以修改一下上面的sort

```js
    var arr = [10, 1, 5, 2, 3];
    arr.sort(function (a, b) {
      return a - b;
    });
    console.log(arr);//[1,2,3,5,10]
```

当元素为对象时（可按其中某个属性来排序）：

```js
  var arr1 = [
      { name: "老八", age: "38" },
      { name: "赵日天", age: "28" },
      { name: "龙傲天", age: "48" },
    ];
    arr1.sort(function (a, b) {
      console.log(a, b);
      return b.age - a.age;
    });
    console.log(arr1);
```

打印结果：（按照age排序（大到小））

![image-20250321111309301](image-20250321111309301.png)

### splice

功能：想数组中添加，或从数组删除，或替换数组中的元素，然后返回被删除/替换的元素组成的数组，可以实现数组的增删改；

语法：arrayObject.splice(index,howmany,item1,...,itemX)

参数:

- index:必须，整数，规定添加/删除项目的位置（元素下标），使用负数可以从数组结尾规定位置。
- howmany:必须。要删除的项目数量，如果设置为，则不会删除项目。
- item1....itemx:可选向数组里添加的新项目。

列如，删除arr()中第三个元素并添加'add1','add2'元素

```
 var arr = ["a", "b", "c", 2, 3, 6];
 var rel = arr.splice(2, 1, "add1", "add2");
 console.log(arr);   //原数组
 console.log(rel);	//新数组 
```

![image-20250321112615376](image-20250321112615376.png)

### concat

功能：数组的拼接（将多个数组或元素拼接形成一个新的数组），不改变原数组

如果拼接的是数组，则将数组展开，之后将数组中的每一个元素放在新数组中。

如果是其他类型，直接放在新的数组中，另外，如果不给该方法任何参数，将返回一个和原数组一样的数组（复制数组）

```js
    var arr1 = [1, 2, 3];
    var arr2 = ["a", "b", "c"];
    var arr3 = ["A", "B", "C"];
    var rel = arr1.concat(arr2, arr3);
    console.log(arr1); //原数组
    console.log(rel); //新数组
```

![image-20250321114915069](image-20250321114915069.png)

### join

功能：用特定的字符，将数组拼接形成字符串（默认","）

```js
   var list = ["a", "b", "c", "d"]; // "a-b-c-d"
   var result = list.join("-");     //"a-b-c-d"
   var result = list.join("/");     //"a/b/c/d"
   var result = list.join("");      //"abcd"
   var result = list.join();        //  a,b,c,d
   console.log(result);

```

### slice

功能：裁切指定位置的数组，返回值为被裁切的元素形成的新数组，不改变原数组同concat()方法和slice()方法如果不传参数，会使用默认值，得到一个与原数组相同的新数组（复制数组）

语法：arr[].slice(startIndex,endIndex)

参数：

- startIndex起始下标，默认值0；
- endIndex终止下标默认值length，可以接收负数,（倒着数）

注：起始下标和终止的区间层，左闭右开[a,b)能取到起始，取不到终止

```js
  var list = ["a", "b", "c", "d"];
  var result = list.slice(1, 3);
  console.log(result);  // ["b", "c"]
```

### toString

功能：直接将数组转化为字符串，并且返回转换后的新数组，不改变原数组，与join()；方法不添加任何参数相同

```js
 var list = ["a", "b", "c", "d"];
 var rel = list.toString();
 console.log(rel);   // a,b,c,d   (字符串类型)
```

### valueOf

功能：返回数组的原始值（一般情况为数组本身）

```js
   var list = [1, 2, 3, 4];
   var rel = list.valueOf();
   console.log(list); // [1, 2, 3, 4]
   console.log(rel); // [1, 2, 3, 4]
```

### indexOf

功能：查询某个元素在数组第一次出现的位置存在该元素，返回下标，不存在返回-1（可以通过返回值，变相的判断是否存在该元素）

```js
 var list = [1, 2, 3, 4];
 var index = list.indexOf(4); //3
 var index = list.indexOf("4"); //-1
 console.log(index);
```

### lastIndexOf

功能：查询某个元素在数组中最后一次出现的位置（或者理解为反向查询第一次出现的位置）存在该元素，返回下标，不存在返回-1（可以通过返回值，变相的判断是否存在该元素）

```js
    var list = [1, 2, 3, 4];
    var index = list.lastIndexOf(4); //3
    var index = list.lastIndexOf("4"); //-1
    console.log(index);
```

### forEach

功能：遍历数组，每次循环中执行传入的回调函数。（注意：forEach()对于空数组是不会执行回调函数的）没有返回值，或理解为返回值为undefined，不改变原数组

语法：

```js
arr[].forEach(value,index,array){
	//do something
}
```

参数：

- value每次循环的当前元素，
- index当前的索引，
- array原始数组

数组中有几项，那么传递进去的匿名函数就需要执行几次

```js
 var list = [32, 93, 77, 53, 38, 87];
 var res = list.forEach(function (item, index, array) {
    console.log(item, index, array);
 });
 console.log(res);

```

![image-20250325112126902](image-20250325112126902.png)

```js
    var list = [32, 93, 77, 53, 38, 87];
    var sum = 0;
    list.forEach(function (item) {
      console.log(item);
      sum += item;
    });
    console.log(sum);
```

![image-20250325112155699](image-20250325112155699.png)

### map

功能：遍历数组每次循环时执行传入的回调函数的返回值，生成一个新的数组，同forEach()方法，但是map()方法有返回值，可以return出来，

语法：

```js
arr[].map(function(item,index,array){
　　//do something
　　return XXX
})
```

参数：

- item每次循环的当前元素
- index当前索引
- array原始数组

```js
    var list = [32, 93, 77, 53, 38, 87];
    var res = list.map(function (item, index, array) {
      return item + 5 * 2;
    });
    console.log("原数组", list);
    console.log("新数组", res);
```

![image-20250325113700807](image-20250325113700807.png)

### filter

功能：遍历数组，每次循环时执行传入的回调函数，回调函数返回一个条件，把满足条件的元素筛选出来放到新数组中

语法：

```js
arr[].filter(function(item,index,array){
　　//do something
　　return XXX //条件
})
```

参数：

- item每次循环的当前元素
- index当前索引
- array原始数组

```js
   var list = [32, 93, 77, 53, 38, 87];
    var resList = list.filter(function (item, index, array) {
      return item >= 60; // true || false
    });
    console.log(resList);
```

![image-20250325114401956](image-20250325114401956.png)

### every

功能：遍历数组，每次循环执行传入的回调函数，回调函数返回一个条件，全部满足返回true只要有一个不满足返回false=>判断数组中所有的元素是否满足某个条件

```js
 var list = [32, 93, 77, 53, 38, 87];
 var result = list.every(function (item, index, array) {
     console.log(item, index, array);
     return item >= 50;
 });
 console.log(result);
```

结果为false

### some

功能：遍历数组，每次循环时执行传入的回调函数，回调函数返回一个条件，只要有一个元素满足条件就返回true,都不满足返回false=>判断数组中是否存在满足某个条件的元素

```js
    var list = [32, 93, 77, 53, 38, 87];
    var result = list.some(function (item, index, array) {
      return item >= 50;
    });
    console.log(result);
```

结果true

### reduce

功能：遍历数组，每次循环时执行传入的回调函数，回调函数会返回一个值，将该值作为初始值pre，传入到下一个函数中，返回最总操作的结果

语法：arr.reduce( function(**prev**,**item**,**index**,**array**){} , **initVal**)

参数：

- pre:回调初始（类似求和时sum=0)可以设置初始值（参数），如果不设置初始值默认是数组中的第一个元素，遍历时从第二个元素遍历
- item:每次循环的当前元素
- index:每次循环的当前下标
- arrary:原数组

```js
    var arr = [2, 3, 4, 5];
    var sum = arr.reduce(function (prev, item, index, array) {
      console.log(prev, item, index, array);
      return prev + item;
    });
    console.log(arr, sum);
```

![image-20250325143838671](image-20250325143838671.png)

解析：

第一次循环: prev = 2 ; item(当前循环元素) = 3 ; index(当前循环元素下标) = 1;原数组 =array;
因为没有给prev设置初始值,所以prev 的值为数组中第一个元素,遍历从第二个元素开始
第二次循环:prev = 5; item(当前循环元素) = 4 ; index(当前循环元素下标) = 2;原数组 =array;
prev = 2+3(上次循环的元素) = 5 ;
…
最终prev = 14 ; arr中有四个元素 共循环三次;(因为没设置初始值跳过第一次循环prev默认等于第一个值)

```js
   	var arr = [2, 3, 4, 5];
    var sum = arr.reduce(function (prev, item, index, array) {
      console.log(prev, item, index, array);
      return prev + item;
    }, 0);
    console.log(arr, sum);
```

![image-20250325143924849](image-20250325143924849.png)

解析: 可以看到与上一次设置初始值相比,最终的结果相同,但是多循环的一次,因为设置了prev的初始值为0,所以循环遍历从第一个元素开始,而不设置初始值,循环从第一个元素开始.

#### reduce的深入使用

累计求和：

```js
// 1.一组数求和
let total = [1, 2, 3, 4, 5].reduce((acc, cur) => acc + cur, 0)    
// 2.数组对象种某一个参数累加   
let total = [{id: 1}, {id: 2}, {id: 3}].reduce((acc, cur) => acc + cur.id, 0)
```

把二维数组变一维数组

```js
  let flattened = [[1, 2],[3, 4],[5, 6]].reduce((acc, cur) => acc.concat(cur), [])
  console.log(flattened)  // [1，2，3，4，5，6]
```

计算每个元素出现的次数

```js
 const names = ['Alice', 'Bob', 'Bob', 'Tiff', 'Bruce', 'Alice'];
    let countedNames = names.reduce((allnames, name) => {
      name in allnames ? allnames[name]++ : allnames[name] = 1
      return allnames
    }, {})
    console.log(countedNames)
```

数组去重

```js
let arr = [0, 1, 2, 3, 4, 4, 1]
    let newarr = arr.reduce((acc, cur) => {
      return acc.includes(cur) ? acc : acc.concat(cur)
    }, [])
    console.log(newarr)
```

### reduceRight

功能：用法同reduce，只不过是从右向左

### includes

功能：用于判断一个数组是否包含一个指定的值，如果是返回true,否则返回false

```js
let site = ['runoob', 'google', 'taobao'];
site.includes('runoob'); 
// true 
site.includes('baidu'); 
// false
```

Arrary.from

功能：将一个类数组对象或者可遍历对象转成一个真正的数组

> 讲一个类数组对象转换为一个真正的数组，必须具备以下条件

- 该 伪数组 / 类数组 对象必须具有length属性，用于指定数组的长度。如果没有length属性，那么转换后的数组是一个空数组。
- 该 伪数组 / 类数组 对象的属性名必须为数值型或字符串型的数字

```js
    var all = {
      0: "张飞",
      1: "28",
      2: "男",
      3: ["率土", "鸿图", "三战"],
      length: 4,
    };
    var list = Array.from(all);
    console.log(all);
    console.log(list, Array.isArray(list));
```

![image-20250325165507896](image-20250325165507896.png)

### find

功能：遍历数组每次循环执行回调函数，回调函数接受一个条件，返回满足条件的第一个元素，不存在则返回undefined

参数：

- item:必须 , 循环当前元素
- index:可选 , 循环当前下标
- array:可选 , 当前元素所属的数组对象

```js
    var list = [55, 66, 77, 88, 99, 100];
    var res= list.find(function (item, index, array) {
      return item > 60;
    });
    console.log(res); //66
```

```js
      let arr = [{ id: 1, name: 'coco' }, { id: 2, name: 'dudu' }]
      let res = arr.find(item => item.id == 1)
      console.log('res', res)  //res {id: 1, name: "coco"}
```

### findIndex

功能：遍历数组，执行回调函数，回调函数接受一个条件，返回满足条件的第一个元素下标，不存在则返回-1

参数：

- item:必须 , 循环当前元素
- index:可选 , 循环当前下标
- array:可选 , 当前元素所属的数组对象

> findIndex();和indexOf();不同 (刚接触时乍一看和indexOf()怎么一模一样,仔细看了下才发现大有不同)
> indexOf是传入一个值.找到了也是返回索引,没有找到也是返回-1 ,属于ES5
> findIndex是传入一个测试条件,也就是函数,找到了返回当前项索引,没有找到返回-1. 属于ES6

```js
   var list = [55, 66, 77, 88, 99, 100];
    var index = list.findIndex(function (item, index, array) {
      console.log(item, index, array);
      return item > 60;
    });
    console.log(index); // 1
```

```js
      let arr = [{ id: 1, name: 'coco' }, { id: 2, name: 'dudu' }]
      let res = arr.findIndex(item => item.id == 1)
      console.log('res', res)  //res 0
```

### fill

功能：用给定值填充一个数组

参数：

- value 必需。填充的值。
- start 可选。开始填充位置。
- end 可选。停止填充位置 (默认为 array.length)

```js
 var result = ["a", "b", "c"].fill("填充", 1, 2);
```

![image-20250325173705982](image-20250325173705982.png)

### flat

功能：用于将嵌套的数组“拉平”，变成一位的数组。该方法返回一个新数组，对原数据没有影响。

> 默认拉平一次 如果想自定义拉平此处 需要手动传参 ,如果想全都拉平 传 Infinity

```js
    var list = [1, 2, [3, 4, [5]]];
    var arr = list.flat(); // 默认拉平一次
    console.log("拉平一次", arr);
    var arr = list.flat(2); // 拉平2次
    console.log("拉平两次", arr);
```

![image-20250325174201526](image-20250325174201526.png)

### flatMap

功能：flat()和map()的组合版 , 先通过map()返回一个新数组,再将数组拉平( **只能拉平一次** )

```js
    var list = [55, 66, 77, 88, 99, 100];
    var newArr = list.map(function (item, index) {
      return [item, index];
    });
    console.log("Map方法:", newArr);
    var newArr = list.flatMap(function (item, index) {
      return [item, index];
    });
    console.log("flatMap方法:", newArr);
```

![image-20250325174209019](image-20250325174209019.png)
