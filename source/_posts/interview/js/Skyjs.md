---
title: js面试总结

categories: 
    - 面试
    - js
tags:
  - js
abbrlink: d41c1e8f
date: 2025-01-02 18:12:38
---

##### 本文讲述了js面试的相关问题
<!-- more -->

# JavaScript

## 1.JS原始数据类型有哪些？引用数据类型有哪些？

在JS中，存在着7钟原始值，分别为：

- boolean
- string
- number
- undefined
- null
- sysmbol
- bigint

引用数据类型：对象Object(包含普通对象-Object,数组对象-Array,正则表达式-RegExp,日期对象-Date,数学函数-Math,函数对象-Function)

## 2.说出下面运行的结果，解释原因。

```js
function test(person) {
 	person.age = 26
 	person = {
 		name: 'hzj',
 		age: 18
 	}
 	return person
 }
 const p1 = {
 	name: 'fyq',
 	age: 19
 }
 const p2 = test(p1)
 console.log(p1) // -> ?
 console.log(p2) // -> ?
```

结果：

```js
 p1：{name: “fyq”, age: 26}
 p2：{name: “hzj”, age: 18}
```

> 原因: 在函数传参的时候传递的是对象在堆中的内存地址值，test函数中的实参person是p1对象的 内存地址，通过调用person.age = 26确实改变了p1的值，但随后person变成了另一块内存空间的 地址，并且在最后将这另外一份内存空间的地址返回，赋给了p2。

## 3.null是对象吗？为什么？

结论: null不是对象。 解释: 虽然 typeof null 会输出 object，但是这只是 JS 存在的一个悠久 Bug。在 JS 的最初版本中使用的 是 32 位系统，为了性能考虑使用低位存储变量的类型信息，000 开头代表是对象然而 null 表示为全 零，所以将它错误的判断为 object 。

## 4.'1'.toString()为什么可以调用？

其实在这个语句运行的过程中做了这样几件事情：

```js
var s = new Object('1');
 s.toString();
 s = null;
```

第一步: 创建Object类实例。注意为什么不是String ？ 由于Symbol和BigInt的出现，对它们调用new都 会报错，目前ES6规范也不建议用new来创建基本类型的包装类。 

第二步: 调用实例方法。

 第三步: 执行完方法立即销毁这个实例。 整个过程体现了 基本包装类型的性质，而基本包装类型恰恰属于基本数据类型，包括Boolean, Number 和String

## 5.0.1+0.2为什么不等于0.3？

0.1和0.2在转换成二进制后会无限循环，由于标准位数的限制后面多余的位数会被截掉，此时就已经出 现了精度的损失，相加后因浮点数小数位的限制而截断的二进制数字在转换为十进制就会变成 0.30000000000000004。

## 6.什么是BigInt?

BigInt是一种新的数据类型，用于当整数值大于Number数据类型支持的范围时。这种数据类型允许我们 安全地对 大整数执行算术操作，表示高分辨率的时间戳，使用大整数id，等等，而不需要使用库。

## 7.为什么需要BigInt

在JS中，所有的数字都以双精度64位浮点格式表示，那这会带来什么问题呢？ 这导致JS中的Number无法精确表示非常大的整数，它会将非常大的整数四舍五入，确切地说，JS中的 Number类型只能安全地表示-9007199254740991(-(2^53-1))和9007199254740991（(2^53-1)），任 何超出此范围的整数值都可能失去精度。

```js
console.log(999999999999999);  //=>10000000000000000
```

同时也会有一定的安全性问题:

```js
 9007199254740992 === 9007199254740993;    // → true 居然是true!
```

## 8.如何创建并使用BigInt

要创建BigInt,只需要在数字末尾追加n即可。

```js
console.log( 9007199254740995n );    // → 9007199254740995n
console.log( 9007199254740995 );     // → 9007199254740996 
```

另一种创建BigInt的方法是用BigInt()构造函数、

```
BigInt("9007199254740995");    
// → 9007199254740995n
```

简单使用如下：

```js
10n + 20n;    // → 30n
10n - 20n;    // → -10n 
+10n;     	  // → TypeError: Cannot convert a BigInt value to a number 
-10n;         // → -10n
10n * 20n;    // → 200n 
20n / 10n;    // → 2n   
23n % 10n;    // → 3n   
10n ** 3n;    // → 1000n    
const x = 10n;  
++x;          // → 11n 
--x;          // → 9n
 console.log(typeof x);   //"bigint"
```

### 值得警惕的点

- BigInt不支持一元加号运算符, 这可能是某些程序可能依赖于 + 始终生成 Number 的不变量，或者抛 出异常。另外，更改 + 的行为也会破坏 asm.js代码。

- 因为隐式类型转换可能丢失信息，所以不允许在bigint和 Number 之间进行混合操作。当混合使用大 整数和浮点数时，结果值可能无法由BigInt或Number精确表示。

  ```js
  10 + 10n;    // → TypeError
  ```

- 不能将BigInt传递给Web api和内置的 JS 函数，这些函数需要一个 Number 类型的数字。尝试这样 做会报TypeError错误。

  ```js
  Math.max(2n, 4n, 6n);    // → TypeError
  ```

- 当 Boolean 类型与 BigInt 类型相遇时，BigInt的处理方式与Number类似，换句话说，只要不是 0n，BigInt就被视为truthy的值。

  ```js
  if(0n){//条件判断为false
  
   }
   if(3n){//条件为true
   
   }
  ```

- 元素为BigInt的数组可以进行sort.

- BigInt可以正常地进行位运算，如|、&、<<、>>和^

### 浏览器兼容性

caniuse的结果:

![image-20250121171208839](image-20250121171208839.png)

其实现在的兼容性并不怎么好，只有chrome67、firefox、Opera这些主流实现，要正式成为规范，其 实还有很长的路要走。

## 9.typeof是否能正确判断类型？

对于原始类型来说，除了 null 都可以调用typeof显示正确的类型。

```js
 typeof 1 // 'number'
 typeof '1' // 'string'
 typeof undefined // 'undefined'
 typeof true // 'boolean'
 typeof Symbol() // 'symbol'
 typeof 9007199254740995n //'bigint'
```

但对于引用数据类型，除了函数之外，都会显示"object"。

```js
typeof [] // 'object'
typeof {} // 'object'
typeof console.log // 'function'
```

因此采用typeof判断对象数据类型是不合适的，采用instanceof会更好，instanceof的原理是基于原型 链的查询，只要处于原型链中，判断永远为true

```js
 const Person = function() {}
 const p1 = new Person()
 p1 instanceof Person // true

 var str1 = 'hello world'
 str1 instanceof String // false

 var str2 = new String('hello world')
 str2 instanceof String // true
```

## 10.instanceof能否判断基本数据类型

能。比如下面这种方式：

```js
 class PrimitiveNumber {
 	static [Symbol.hasInstance](x) {
 		return typeof x === 'number'
 	}
 }
 console.log(111 instanceof PrimitiveNumber) // true
```

其实就是自定义instanceof行为的一种方式，这里将原有的instanceof方法重定义，换成了typeof，因 此能够判断基本数据类型。