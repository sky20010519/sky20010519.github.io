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

**本文讲述了js面试的相关问题**

<!-- more -->

## JS原始数据类型有哪些？引用数据类型有哪些？

在JS中，存在着7钟原始值，分别为：

- boolean
- string
- number
- undefined
- null
- sysmbol
- bigint

引用数据类型：对象Object(包含普通对象-Object,数组对象-Array,正则表达式-RegExp,日期对象-Date,数学函数-Math,函数对象-Function)

## 说出下面运行的结果，解释原因。

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

## null是对象吗？为什么？

结论: null不是对象。 解释: 虽然 typeof null 会输出 object，但是这只是 JS 存在的一个悠久 Bug。在 JS 的最初版本中使用的 是 32 位系统，为了性能考虑使用低位存储变量的类型信息，000 开头代表是对象然而 null 表示为全零，所以将它错误的判断为 object 。

## '1'.toString()为什么可以调用？

其实在这个语句运行的过程中做了这样几件事情：

```js
var s = new Object('1');
 s.toString();
 s = null;
```

第一步: 创建Object类实例。注意为什么不是String ？ 由于Symbol和BigInt的出现，对它们调用new都 会报错，目前ES6规范也不建议用new来创建基本类型的包装类。 

第二步: 调用实例方法。

 第三步: 执行完方法立即销毁这个实例。 整个过程体现了 基本包装类型的性质，而基本包装类型恰恰属于基本数据类型，包括Boolean, Number 和String

## 0.1+0.2为什么不等于0.3？

0.1和0.2在转换成二进制后会无限循环，由于标准位数的限制后面多余的位数会被截掉，此时就已经出 现了精度的损失，相加后因浮点数小数位的限制而截断的二进制数字在转换为十进制就会变成 0.30000000000000004。

## 什么是BigInt?

BigInt是一种新的数据类型，用于当整数值大于Number数据类型支持的范围时。这种数据类型允许我们 安全地对 大整数执行算术操作，表示高分辨率的时间戳，使用大整数id，等等，而不需要使用库。

## 为什么需要BigInt

在JS中，所有的数字都以双精度64位浮点格式表示，那这会带来什么问题呢？ 这导致JS中的Number无法精确表示非常大的整数，它会将非常大的整数四舍五入，确切地说，JS中的 Number类型只能安全地表示-9007199254740991(-(2^53-1))和9007199254740991（(2^53-1)），任 何超出此范围的整数值都可能失去精度。

```js
console.log(999999999999999);  //=>10000000000000000
```

同时也会有一定的安全性问题:

```js
 9007199254740992 === 9007199254740993;    // → true 居然是true!
```

## 如何创建并使用BigInt

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

## typeof是否能正确判断类型？

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

## instanceof能否判断基本数据类型

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

## 能不能手动实现一下instanceof的功能

核心：原型链的向上查找

```js
function myInstanceof(left,right){
    //基本数据类型直接返回false
    if(typeof left !== 'object' || left === null) return false
    //getProtypeOf是Object对象自带的一个方法
    let proto = object.getPrototypeOf(left)
    while(true){
        //查找到尽头，还没找到
        if(proto == null) return null
        //找到相同的原型对象
        if(proto == right.prototype) retnrn true
        proto = Object.getPrototypeOf(proto)
    }
}
```

测试：

```js
 console.log(myInstanceof("111", String)); //false
 console.log(myInstanceof(new String("111"), String));//true
```

## Object.is和===的区别？

Object在严格等于的基础上修复了一些特殊情况下的失误，具体来说就是+0和-0，NaN和NaN。 源码如 下：

```js
function is(x, y) {
 if (x === y) {
 	//运行到1/x === 1/y的时候x和y都为0，但是1/+0 = +Infinity， 1/-0 = -Infinity, 是不一样的
	return x !== 0 || y !== 0 || 1 / x === 1 / y;
 } else {
 	//NaN===NaN是false,这是不对的，我们在这里做一个拦截，x !== x，那么一定是 NaN, y 同理
//两个都是NaN的时候返回true
 	return x !== x && y !== y;
 }
```

## [] == ![]结果是什么？为什么？

解析：== 中，左右两边都需要转换为数字然后进行比较。 []转换为数字为0。 ![] 首先是转换为布尔值，由于[]作为一个引用类型转换为布尔值为true, 因此![]为false，进而在转换成数字，变为0。 0 == 0 ， 结果为true

## JS中类型转换有哪几种？

JS中，类型转换只有三种

- 转化成数字
- 转化成布尔值
- 转化成字符串

转换具体规则如下:

> 注意"Boolean 转字符串"这行结果指的是 true 转字符串的例子

![image-20250123161459144](image-20250123161459144.png)

## ==和===有什么区别？

> ===叫做严格相等，是指：左右两边不仅值要相等，类型也要相等，例如'1'===1的结果是false，因为一边 是string，另一边是number。

==不像===那样严格，对于一般情况，只要值相等，就返回true，但==还涉及一些类型转换，它的转换 规则如下：

- 两边的类型是否相同，相同的话就比较值的大小，例如1==2，返回false 
- 判断的是否是null和undefined，是的话就返回true 
- 判断的类型是否是String和Number，是的话，把String类型转换成Number，再进行比较 
- 判断其中一方是否是Boolean，是的话就把Boolean转换成Number，再进行比较 
- 如果其中一方为Object，且另一方为String、Number或者Symbol，会将Object转换成字符串，再进行比较

```js
console.log({a: 1} == true);//false 
console.log({a: 1} == "[object Object]");//true
```

## 对象转原始类型是根据什么流程运行的？

对象转原始类型，会调用内置的[ToPrimitive]函数，对于该函数而言，其逻辑如下：

1. 如果Symbol.toPrimitive()方法，优先调用再返回
2. 调用valueOf(),如果转换为原始类型，则返回
3. 调用toString()，如果转换为原始类型，则返回
4. 如果都没有返回原始类型，会报错

```js
var obj = {
 	value: 3,
 	valueOf() {
 	return 4;
   },
 	toString() {
	 return '5'
   },
 	[Symbol.toPrimitive]() {
 	return 6
   }
 }
 console.log(obj + 1); // 输出7
```

## 如何让if(a == 1&& a == 2)条件成立？

```js
var a = {
	value:0,
	valueof:function(){
		this.value++;
		return this.value;
	}
};
console.log(a == 1 && a == 2);//true
```

## 什么是闭包？

红宝书上对于闭包的定义：闭包是指有权访问另外一个函数作用域中的变量的函数， MDN 对闭包的定义为：闭包是指那些能够访问自由变量的函数。 （其中自由变量，指在函数中使用的，但既不是函数参数arguments也不是函数的局部变量的变量，其 实就是另外一个函数作用域中的变量。）

## 闭包产生的原因？

首先要明白作用域链的概念，其实很简单，在ES5中只存在两种作用域————全局作用域和函数作用 域，当访问一个变量时，解释器会首先在当前作用域查找标示符，如果没有找到，就去父作用域找，直 到找到该变量的标示符或者不在父作用域中，这就是作用域链，值得注意的是，每一个子函数都会拷贝 上级的作用域，形成一个作用域的链条。 比如:

```js
var a = 1;
function f1(){
	var a = 2
	function f2(){
		var a = 3;
		console.log(a);//3
	}
}
```

在这段代码中，f1的作用域指向有全局作用域(window)和它本身，而f2的作用域指向全局作用域 (window)、f1和它本身。而且作用域是从最底层向上找，直到找到全局作用域window为止，如果全局 还没有的话就会报错。就这么简单一件事情！ 闭包产生的本质就是，当前环境中存在指向父级作用域的引用。还是举上面的例子:

```js
function f1(){
	var a = 2
	function f2(){
		console.log(a);//2
	}
	return f2;
}
var x = f1();
x()
```

这里x会拿到父级作用域中的变量，输出2。因为在当前环境中，含有对f2的引用，f2恰恰引用了 window、f1和f2的作用域。因此f2可以访问到f1的作用域的变量。 那是不是只有返回函数才算是产生了闭包呢？、 回到闭包的本质，我们只需要让父级作用域的引用存在即可，因此我们还可以这么做：

```js
var f3;
function f1() {
	var a = 2
	f3 = function() {
	  console.log(a);
	}
}
f1();
f3();
```

让f1执行，给f3赋值后，等于说现在f3拥有了window、f1和f3本身这几个作用域的访问权限，还是自底 向上查找，最近是在f1中找到了a,因此输出2。 在这里是外面的变量f3存在着父级作用域的引用，因此产生了闭包，形式变了，本质没有改变。

## 闭包有哪些表现形式？

在真实的场景中，究竟在哪些地方能体现闭包的存在？

- 返回一个函数。刚刚已经举例。

- 作为函数参数传递

  ```js
  var a = 1;
  function foo(){
  	var a = 2;
  	function baz(){
  	  console.log(a);
  	}
  	bar(baz)
  }
  function bar(fn){
  	//这就是闭包
  	fn();
  }
  //输出2，而不是1
  foo();
  ```

- 在定时器、事件监听、Ajax请求、跨窗口通信、Web Workers或者任何异步中，只要使用了回调函 数，实际上就是在使用闭包。

  ```js
  //定时器
  function outer() {
      let num = 1;
      setTimeout(() => {
          console.log(num); 
      }, 1000);
  }
  outer();
  //事件监听
  function outerFunction() {
      let count = 0;
      const button = document.createElement('button');
      button.textContent = 'Click me';
      button.addEventListener('click', function () {
          console.log(++count); 
      });
      document.body.appendChild(button);
  }
  outerFunction();
  ```


## 如何解决下面的循环输出问题？

```js
for(var i = 1; i <= 5; i ++){
 	setTimeout(function timer(){
 		console.log(i)
 	}, 0)
 }
```

为什么会全部输出6？如何改进，让它输出1，2，3，4，5？(方法越多越好) 

因为setTimeout为宏任务，由于JS中单线程eventLoop机制，在主线程同步任务执行完后才去执行宏任 务，因此循环结束后setTimeout中的回调才依次执行，但输出i的时候当前作用域没有，往上一级再找， 发现了i,此时循环已经结束，i变成了6。因此会全部输出6。

解决方法：

1. 利用IIFE(立即执行函数表达式)当每次for循环时，把此时的i变量传递到定时器中

   ```js
   for(var i = 1;i <= 5;i++){
   	(function(j){
   	  setTimeout(function timer(){
   		console.log(j)
   	  }, 0)
   	})(i)
   }
   ```

2. 给定时器传入第三个参数, 作为timer函数的第一个函数参数

   ```js
   for(var i=1;i<=5;i++){
     setTimeout(function timer(j){
   	console.log(j)
     }, 0, i)
   }
   ```

3. 使用ES6中的let

   ```js
    for(let i = 1; i <= 5; i++){
      setTimeout(function timer(){
    	console.log(i)
      },0)
    }
   ```

    let使JS发生革命性的变化，让JS有函数作用域变为了块级作用域，用let后作用域链不复存在。代码的作 用域以块级为单位，以上面代码为例:

   ```js
    // i = 1
    {
      setTimeout(function timer(){
    	console.log(1)
      },0)
    }
    // i = 2
    {
      setTimeout(function timer(){
    	console.log(2)
      },0)
    }
    // i = 3
    ...
   ```

因此能够输出正确的结果.

## 原型对象和构造函数有何关系？

在JavaScript中，每当定义一个函数数据类型(普通函数、类)时候，都会天生自带一个prototype属性， 这个属性指向函数的原型对象。 当函数经过new调用时，这个函数就成为了构造函数，返回一个全新的实例对象，这个实例对象有一个 proto属性，指向构造函数的原型对象。

![image-20250124154046203](image-20250124154046203.png)

## 能不能描述一下原型链

JavaScript对象通过proto 指向父类对象，直到指向Object对象为止，这样就形成了一个原型指向的链 条, 即原型链。

![image-20250124163547811]()

- 对象的 hasOwnProperty() 来检查对象自身中是否含有该属性 
- 使用 in 检查对象中是否含有某个属性时，如果对象中没有但是原型链中有，也会返回 true

## JS如何实现继承？

### 第一种：借助call

```js
function Parent1(){
    this.name = 'parent1'
}
function Child1(){
    Parent1.call(this);
    this.type = 'child'
}
console.log(new Child1);
```

这样写的时候子类虽然能够拿到父类的属性值，但问题是父类原型对象一旦存在方法那么子类无法继承，那么引出下面的方法。

### 第二种：借助原型链

```js
function Parent2() {
  this.name = 'parent2';
  this.play = [1, 2, 3]
}
function Child2() {
  this.type = 'child2';
}
Child2.prototype = new Parent2();
console.log(new Child2());
```

看似没有问题，父类的方法和属性都能够访问，但实际上有一个潜在的不足。举个例子：

```js
var s1 = new Child2();
var s2 = new Child2();
s1.play.push(4);
console.log(s1.play,s2.play);
```

可以看到控制台：

![image-20250206140827431]()

明明我只改变了s1的play属性，为什么s2也跟着变了呢？很简单，因为两个实例使用的是同一个原型对象。那么还有更好的方式么？

### 第三种：将前两种组合

```js
function Parent3(){
  this.name = 'parent3';
  this.play = [1,2,3];
}
function Child3(){
  Parent3.call(this);
  this.type = 'child3';
}
Child3.prototype = new Parent3();
var s3 = new Child3()
var s4 = new Child3()
s3.play.push(4);
console.log(4);
console.log(s3.play, s4.play);
```

可以看到控制台：![image-20250206141036067](image-20250206141036067.png)

之前的问题都得以解决。但是这里又徒增了一个新问题，那就是Parent3的构造函数会多执行了一次（Child3.prototype = new Parent3();）。这是我们不愿看到的。那么如何解决这个问题？

### 第四种：组合继承的优化1

```js
function Parent4 () {
  this.name = 'parent4';
  this.play = [1, 2, 3];
}
  function Child4() {
  Parent4.call(this);
  this.type = 'child4';
}
Child4.prototype = Parent4.prototype;
```

这里让将父类原型对象直接给到子类，父类构造函数只执行一次，而且父类属性和方法均能访问，但是我们来测试一下：

```js
var s3 = new Child4();
var s4 = new Child4();
console.log(s3)
```

![image-20250206141821433](image-20250206141821433.png)

子类实例的构造函数是Parent4，显然这是不对的，应该是Child4。

### 第五种(最推荐使用)：组合继承的优化1

```js
function Parent5 () {
  this.name = 'parent5';
  this.play = [1, 2, 3];
}
function Child5() {
  Parent5.call(this);
  this.type = 'child5';
}
Child5.prototype = Object.create(Parent5.prototype);
Child5.prototype.constructor = Child5;
```

这是最推荐的一种方式，接近完美的继承，它的名字也叫做寄生组合继承。

### ES6的extends被编译后的JavaScript代码

ES6的代码最后都是要在浏览器上能够跑起来的，这中间就利用了babel这个编译工具，将ES6的代码编译成ES5让一些不支持新语法的浏览器也能运行。

那最后编译成了什么样子呢？

```js
function _possibleConstructorReturn(self, call) {
	// ...
	return call && (typeof call === 'object' || typeof call === 'function') ?
call : self;
}
function _inherits(subClass, superClass) {
	// ...
	//看到没有
	subClass.prototype = Object.create(superClass && superClass.prototype, {
		constructor: {
			value: subClass,
			enumerable: false,
			writable: true,
			configurable: true
		}
	});
	if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass,
superClass) : subClass.__proto__ = superClass;
}
var Parent = function Parent() {
	// 验证是否是 Parent 构造出来的 this
	_classCallCheck(this, Parent);
};
var Child = (function (_Parent) {
	_inherits(Child, _Parent);
	function Child() {
		_classCallCheck(this, Child);
		return _possibleConstructorReturn(this, (Child.__proto__ ||
Object.getPrototypeOf(Child)).apply(this, arguments));
	}
	return Child;
}(Parent));
```

核心是_inherits函数，可以看到它采用的依然也是第五种方式————寄生组合继承方式，同时证明了

这种方式的成功。不过这里加了一个Object.setPrototypeOf(subClass, superClass)，这是用来干啥的呢？

答案是用来继承父类的静态方法。这也是原来的继承方式疏忽掉的地方。

```
追问: 面向对象的设计一定是好的设计吗？
```

不一定。从继承的角度说，这一设计是存在巨大隐患的。

### 从设计思想上谈谈继承本身的问题

假如现在有不同品牌的车，每辆车都有drive、music、addOil这三个方法。

```js
class Car{
  constructor(id) {
	this.id = id;
  }
  drive(){
	console.log("wuwuwu!");
  }
  music(){
	console.log("lalala!")
 }
  addOil(){
	console.log("哦哟！")
  }
}
class otherCar extends Car{}
```

现在可以实现车的功能，并且以此去扩展不同的车。但是问题来了，新能源汽车也是车，但是它并不需要addOil(加油)。如果让新能源汽车的类继承Car的话，也是有问题的，俗称"大猩猩和香蕉"的问题。大猩猩手里有香蕉，但是我现在明明只需要香蕉，却拿到了一只大猩猩。也就是说加油这个方法，我现在是不需要的，但是由于继承的原因，也给到子类了。

> 继承的最大问题在于：无法决定继承哪些属性，所有属性都得继承。

当然你可能会说，可以再创建一个父类啊，把加油的方法给去掉，但是这也是有问题的，一方面父类是无法描述所有子类的细节情况的，为了不同的子类特性去增加不同的父类，代码势必会大量重复，另一方面一旦子类有所变动，父类也要进行相应的更新，代码的耦合性太高，维护性不好。

那如何来解决继承的诸多问题呢？用组合，这也是当今编程语法发展的趋势，比如golang完全采用的是面向组合的设计方式。顾名思义，面向组合就是先设计一系列零件，然后将这些零件进行拼装，来形成不同的实例或者类。

```js
function drive(){
  console.log("wuwuwu!");
}
function music(){
  console.log("lalala!")
}
function addOil(){
  console.log("哦哟！")
}
let car = compose(drive, music, addOil);
let newEnergyCar = compose(drive, music);
```

代码干净，复用性也很好。这就是面向组合的设计方式。

## 函数的arguments为什么不是数组？如何转化数组？

因为arguments本身并不能调用数组方法，它是一个另外一种对象类型，只不过属性从0开始排，依次为0，1，2...最后还有callee和length属性。我们也把这样的对象称为类数组。

常见的类数组还有：

- 用getElementsByTagName/ClassName()获得的HTMLCollection

- 用querySelector获得的nodeList

那这导致很多数组的方法就不能用了，必要时需要我们将它们转换成数组，有哪些方法呢？

### Array.prototype.slice.call()

```js
function sum(a, b) {
  let args = Array.prototype.slice.call(arguments);
  console.log(args.reduce((sum, cur) => sum + cur));//args可以调用数组原生的方法啦
}
sum(1, 2);//3
```

### Array.from()

```js
function sum(a,b){
    let args = Array.from(arguments);
    console.log(args.reduce((sum, cur) => sum + cur));//args可以调用数组原生的方法啦
}
```

这种方法也可以用来转换Set和Map哦！

### ES6展开运算符

```js
function sum(a, b) {
  let args = [...arguments];
  console.log(args.reduce((sum, cur) => sum + cur));//args可以调用数组原生的方法啦
}
sum(1, 2);//3
```

### 利用concat+apply

```js
function sum(a, b) {
  let args = Array.prototype.concat.apply([], arguments);//apply方法会把第二个参数展
开
  console.log(args.reduce((sum, cur) => sum + cur));//args可以调用数组原生的方法啦
}
sum(1, 2);//3
```

当然，最原始的方法就是再创建一个数组，用for循环把类数组的每个属性值放在里面，过于简单，就不浪费篇幅了。

## forEach中return有效果吗？如何中断forEach循环？

在forEach中用return不会返回，函数回继续执行

```js
let nums = [1,2,3]
nums.forEach((item,index)) => {
	return;//无效
})
```

中断方法：

- 使用try监视代码块，在需要中断的地方抛出异常
- 官方推荐方法（替换方法）：用every和some替代forEach函数。every在碰到return false的时候， 中止循环。some在碰到return true的时候，中止循环

## js判断数组中是否包含某个值

### 方法一：array.indexOf

> 此方法判断数组中是否存在某个值，如果存在，则返回数组元素的下标，否则返回-1。

```js
var arr = [1,2,3,4];
var index = arr.indexof(3);
console.log(index);//2
```

### 方法二：array.includes(searcElement[,fromIndex])

> 此方法判断数组中是否存在某个值，如果存在返回true，否则返回false

```js
var arr = [1,2,3,4];
if(arr.includes(3))
	console.log('存在');
else
	console.log('不存在')
```

### 方法三：array.find(callback[,thisArg])

> 返回数组中满足条件的第一个元素的值，如果没有，返回undefined

```js
var arr=[1,2,3,4];
var result = arr.find(item =>{
    return item > 3
});
console.log(result);
```

### 方法四：array.findeIndex(callback[,thisArg])

> 返回数组中满足条件的第一个元素的下标，如果没有找到，返回 -1

```js
var arr=[1,2,3,4];
var result = arr.findIndex(item =>{
    return item > 3
});
console.log(result);
```

当然，for循环当然是没有问题的，这里讨论的是数组方法，就不再展开了。

## js中flat---数组扁平化

对于前端项目开发过程中，偶尔会出现层叠数据结构的数组，我们需要将多层级数组转化为一级数组 （即提取嵌套数组元素最终合并为一个数组），使其内容合并且展开。那么该如何去实现呢？

 需求:多维数组=>一维数组

```js
let ary = [1, [2, [3, [4, 5]]], 6];// -> [1, 2, 3, 4, 5, 6]
let str = JSON.stringify(ary);
```

### 调用ES6中的flat方法

```js
arr = arr.flat(Infinity)
```

### replace+split

```js
arr = str.replace(/(\[|\])/g,'').split(',')
```

### replace+JSON.parse

```js
str = str.replace(/(\[|\])/g, '');
str = '[' + str + ']';
ary = JSON.parse(str);
```

### 普通递归

```js
let result = [];
let fn = function(ary){
    for(let i=0; i< ary.length; i++){
        let item = ary[i];
        if(Array.isArray(item)){
            fn(item)
        } else {
            result.push(item);
        }
    }
}
```

### 利用reduce函数迭代

```js
function flatten(ary){
    return ary.reduce((pre,cur) => {
        return pre.concat(Array.isArray(cur) ? flatten(cur) : cur);
    },[])
}
```

### 扩展运算符

```js
//只要有一个元素有数组，那么循环继续
while(ary.some(Array.isArray)){
    ary = [].concat(...ary)
}
```

## 什么是高阶函数

概念非常简单，如下：

> 一个函数就可以接收另一个函数作为参数或者返回值为一个函数，这种函数就称之为高阶函数

## 数组中的高阶

### map

- 参数:接受两个参数，一个是回调函数，一个是回调函数的this值(可选)。 其中，回调函数被默认传入三个值，依次为当前元素、当前索引、整个数组。
- 创建一个新数组，其结果是该数组中的每个元素都调用一个提供的函数后返回的结果
- 对原来的数组没有影响

```js
let nums = [1, 2, 3];
let obj = {val: 5};
let newNums = nums.map(function(item,index,array){
    return item + index + array[index] + this.val;
    //对第一个元素，1 + 0 + 1 + 5 = 7
    //对第二个元素，2 + 1 + 2 + 5 = 10
    //对第三个元素，3 + 2 + 3 + 5 = 13
})
```

当然，后面的参数都是可选的，不用的话可以省略。

### reduce

- 参数: 接收两个参数，一个为回调函数，另一个为初始值。回调函数中四个默认参数，依次为积累值、当前值、当前索引和整个数组。

```js
let nums = [1, 2, 3];
// 多个数的加和
let newNums = nums.reduce(function(preSum,curVal,currentIndex,array) {
  return preSum + curVal; 
}, 0);
console.log(newNums);//6

```

不传默认值会怎样？ 不传默认值会自动以第一个元素为初始值，然后从第二个元素开始依次累计。

### filter

- 参数：一个函数参数。这个函数接受一个默认参数，就是当前元素。这个作为参数的函数返回值为一个布尔类型，决定元素是否保留。

- filter方法返回值为一个新的数组，这个数组里面包含参数里面所有被保留的项。

```js
let nums = [1, 2, 3];
// 保留奇数项
let oddNums = nums.filter(item => item % 2);
console.log(oddNums);
```

### sort

参数：一个用于比较的函数，它有两个默认参数，分别是代表比较的两个元素。

举个例子：

```js
let nums = [2, 3, 1];
//两个比较的元素分别为a, b
nums.sort(function(a, b) {
  if(a > b) return 1;
  else if(a < b) return -1;
  else if(a == b) return 0;
})
```

```js
//可以简写为
nums.sort((a,b)=>{
    return a-b
})
```

当比较函数返回值大于0，则 a 在 b 的后面，即a的下标应该比b大。 反之，则 a 在 b 的后面，即 a 的下标比 b 小。 整个过程就完成了一次升序的排列。 当然还有一个需要注意的情况，就是比较函数不传的时候，是如何进行排序的？

> 答案是将数字转换为字符串，然后根据字母unicode值进行升序排序，也就是根据字符串的比较规 则进行升序排序。

## 谈谈你对js中this的理解

其实JS中的this是一个非常简单的东西，只需要理解它的执行规则就OK。 在这里不想像其他博客一样展示太多的代码例子弄得天花乱坠， 反而不易理解。 call/apply/bind可以显式绑定, 这里就不说了。 主要这些场隐式绑定的场景讨论:

- 全文上下文
- 直接调用函数
- 对象.方法的形式调用
- DOM事件绑定（特殊）
- new构造函数绑定
- 箭头函数

### 全局上下文

全局上下文默认this指向window, 严格模式下指向undefined。

### 直接调用函数

比如：

```js
let obj = {
  a: function() {
    console.log(this);
 }
}
let func = obj.a;
func();
```

这种情况是直接调用。this相当于全局上下文的情况。

### 对象.方法的形式调用

还是刚刚的例子，我如果这样写：

```js
obj.a();
```

这就是对象.方法的情况，this指向这个对象

### DOM事件绑定

onclick和addEventerListener中 this 默认指向绑定事件的元素。 IE比较奇异，使用attachEvent，里面的this默认指向window。

### new+构造函数

此时构造函数中的this指向实例对象。

### 箭头函数？

箭头函数没有this, 因此也不能绑定。里面的this会指向当前最近的非箭头函数的this，找不到就是 window(严格模式是undefined)。比如:

```js
let obj = {
  a: function() {
    let do = () => {
      console.log(this);
   }
    do();
 }
}
obj.a(); // 找到最近的非箭头函数a，a现在绑定着obj, 因此箭头函数中的this是obj
```

> 优先级: new > call、apply、bind > 对象.方法 > 直接调用。

## js中浅拷贝的手段有哪些

### 重要：什么是拷贝？

首先来直观的感受一下什么是拷贝。

```js
let arr = [1,2,3];
let newArr = arr;
newArr[0] = 100;

console.log(arr);//[100,2,3]
```

这是直接赋值的情况，不涉及任何拷贝。当改变newArr的时候，由于是同一引用，arr指向的值也跟着改变，

现在进行浅拷贝：

```js
let arr = [1, 2, 3];
let newArr = arr.slice();
newArr[0] = 100;

console.log(arr);//[1, 2, 3]
```

当修改newArr的时候，arr的值并不改变。什么原因?因为这里newArr是arr浅拷贝后的结果，newArr和 arr现在引用的已经不是同一块空间啦！这就是浅拷贝！ 

但是这又会带来一个潜在的问题:

```js
let arr = [1, 2, {val: 4}];
let newArr = arr.slice();
newArr[2].val = 1000;
console.log(arr);//[ 1, 2, { val: 1000 } ]
```

不是已经不是同一块空间的引用了吗？为什么改变了newArr改变了第二个元素的val值，arr也跟着变 了。 这就是浅拷贝的限制所在了。它只能拷贝一层对象。如果有对象的嵌套，那么浅拷贝将无能为力。但幸 运的是，深拷贝就是为了解决这个问题而生的，它能 解决无限极的对象嵌套问题，实现彻底的拷贝。当然，这是我们下一篇的重点。 现在先让大家有一个基本的概念。 接下来，来研究一下JS中实现浅拷贝到底有多少种方式？

### 手动实现

```js
const shallowClone = (target) =>{
    if(typeof target === 'object' && target !== null){
        const newTarget = Array.isArray(target) ? [] : {};
        for(let prop in target){
            if(target.hasOwnProperty(prop)){
                newTarget[prop] = target[prop]
            }
        }
        return newTarget
    }else{
        return target
    }
}
```

### Object.assign

但是需要注意的是，Object.assgin() 拷贝的是对象的属性的引用，而不是对象本身。

```js
let obj = { name: 'sy', age: 18 };
const obj2 = Object.assign({}, obj, {name: 'sss'});
console.log(obj2);//{ name: 'sss', age: 18 }
```

### concat浅拷贝数组

```js
let arr = [1, 2, 3];
let newArr = arr.concat();
newArr[1] = 100;
console.log(arr);//[ 1, 2, 3 ]
```

### slice浅拷贝

```js
let arr = [1, 2, 3];
let newArr = arr.slice();
newArr[0] = 100;

console.log(arr);//[1, 2, 3]
```

### ...展开运算符

```
let arr = [1,2,3]
let newArr = [..arr]//跟arr.slice()是一样的效果
```

## 能不能写一个完整的深拷贝？

### 简易版及问题

```js
JSON.parse(JSON.stringify());
```

估计这个api能覆盖大多数的应用场景，没错，谈到深拷贝，我第一个想到的也是它。但是实际上，对于 某些严格的场景来说，这个方法是有巨大的坑的。问题如下：

> 无法解决循环引用的问题。举个例子

```js
const a = {val:2};
a.target = a;
```

拷贝a会出现系统栈溢出，因为出现了 无限递归 的情况

> 无法拷贝一写 特殊的对象 ，诸如 RegExp, Date, Set, Map等。

> 无法拷贝 函数 (划重点)。

因此这个api先pass掉，我们重新写一个深拷贝，简易版如下:

```js
const deepClone = (target) => {
  if (typeof target === 'object' && target !== null) {
    const cloneTarget = Array.isArray(target) ? []: {};
    for (let prop in target) {
      if (target.hasOwnProperty(prop)) {
          cloneTarget[prop] = deepClone(target[prop]);
     }
   }
    return cloneTarget;
 } else {
    return target;
 }
}
```

现在，我们以刚刚发现的三个问题为导向，一步步来完善、优化我们的深拷贝代码。

### 解决循环引用

现在问题如下:

```js
let obj = {val : 100};
obj.target = obj;
deepClone(obj);//报错: RangeError: Maximum call stack size exceeded
```

这就是循环引用。我们怎么来解决这个问题呢？ 创建一个Map。记录下已经拷贝过的对象，如果说已经拷贝过，那直接返回它行了。

```js
const isObject = (target) => (typeof target === 'object' || typeof target === 
'function') && target !== null;
const deepClone = (target, map = new Map()) => { 
  if(map.get(target))  
    return target; 
 
 
  if (isObject(target)) { 
    map.set(target, true); 
    const cloneTarget = Array.isArray(target) ? []: {}; 
    for (let prop in target) { 
      if (target.hasOwnProperty(prop)) { 
          cloneTarget[prop] = deepClone(target[prop],map); 
     } 
   } 
    return cloneTarget; 
 } else { 
    return target; 
 } 
}
```

现在来试一试：

```js
const a = {val:2};
a.target = a;
let newA = deepClone(a);
console.log(newA)//{ val: 2, target: { val: 2, target: [Circular] } }
```

好像是没有问题了, 拷贝也完成了。但还是有一个潜在的坑, 就是map 上的 key 和 map 构成了 强引用关 系 ，这是相当危险的。我给你解释一下与之相对的弱引用的概念你就明白了：

> 在计算机程序设计中，弱引用与强引用相对

是指不能确保其引用的对象不会被垃圾回收器回收的引用。 一个对象若只被弱引用所引用，则被认为是 不可访问（或弱可访问）的，并因此可能在任何时刻被回收。 --百度百科 

大白话解释一下，被弱引用的对象可以在任何时候被回收，而对于强引用来说，只要这个强引用还在， 那么对象无法被回收。拿上面的例子说，map 和 a一直是强引用的关系， 在程序结束之前，a 所占的内 存空间一直不会被释放。 

怎么解决这个问题？ 

很简单，让 map 的 key 和 map 构成 弱引用 即可。ES6给我们提供了这样的数据结构，它的名字叫 WeakMap ，它是一种特殊的Map, 其中的键是 弱引用 的。其键必须是对象，而值可以是任意的。 稍微改造一下即可:

```js
const deepClone = (target, map = new WeakMap()) => {
  //...
}
```

### 拷贝特殊对象

#### 可继续遍历

对于特殊的对象，我们使用以下方式来鉴别:

```js
Object.prototype.toString.call(obj);
```

梳理一下对于可遍历对象会有什么结果：

```js
["object Map"]
["object Set"]
["object Array"]
["object Object"]
["object Arguments"]
```

好，以这些不同的字符串为依据，我们就可以成功地鉴别这些对象。

```js
const getType = (target) => Object.prototype.toString.call(target);
const canTraverse = {
    '[object Map]': true,
    '[object Set]': true,
    '[object Array]': true,
    '[object Object]': true,
    '[object Arguments]': true,
};
const mapTag = '[object Map]';
const setTag = '[object Set]';
const deepClone = (target, map = new WeakMap()) => {
    if (!isObject(target))
        return target;
    let type = getType(target);
    let cloneTarget;
    if (!canTraverse[type]) {
        // 处理不能遍历的对象
        return;
    } else {
        // 这波操作相当关键，可以保证对象的原型不丢失！
        let ctor = target.constructor;
        cloneTarget = new ctor();
    }
    if (map.get(target))
        return target;
    map.put(target, true);
    if (type === mapTag) {
        //处理Map
        target.forEach((item, key) => {
            cloneTarget.set(deepClone(key), deepClone(item));
        })
    }

    if (type === setTag) {
        //处理Set
        target.forEach(item => {
            cloneTarget.add(deepClone(item));
        })
    }
    // 处理数组和对象
    for (let prop in target) {
        if (target.hasOwnProperty(prop)) {
            cloneTarget[prop] = deepClone(target[prop]);
        }
    }
    return cloneTarget;
}

```

#### 不可遍历的对象

```js
const boolTag = '[object Boolean]';
const numberTag = '[object Number]';
const stringTag = '[object String]';
const dateTag = '[object Date]';
const errorTag = '[object Error]';
const regexpTag = '[object RegExp]';
const funcTag = '[object Function]';
```

对于不可遍历的对象，不同的对象有不同的处理。

```js
const handleRegExp = (target) => {
const { source, flags } = target;
  return new target.constructor(source, flags);
}
const handleFunc = (target) => {
  // 待会的重点部分
}
const handleNotTraverse = (target, tag) => {
  const Ctor = targe.constructor;
  switch(tag) {
    case boolTag:
    case numberTag:
    case stringTag:
    case errorTag: 
    case dateTag:
      return new Ctor(target);
    case regexpTag:
      return handleRegExp(target);
    case funcTag:
      return handleFunc(target);
    default:
      return new Ctor(target);
 }
}

```

#### 拷贝函数

虽然函数也是对象，但是它过于特殊，我们单独把它拿出来拆解。

 提到函数，在JS种有两种函数，一种是普通函数，另一种是箭头函数。每个普通函数都是 Function的实 例，而箭头函数不是任何类的实例，每次调用都是不一样的引用。那我们只需要 处理普通函数的情况， 箭头函数直接返回它本身就好了。 

那么如何来区分两者呢？

 答案是: 利用原型。箭头函数是不存在原型的。 

代码如下:

```js
const handleFunc = (func) => {
  // 箭头函数直接返回自身
  if(!func.prototype) return func;
  const bodyReg = /(?<={)(.|\n)+(?=})/m;
  const paramReg = /(?<=\().+(?=\)\s+{)/;
  const funcString = func.toString();
  // 分别匹配 函数参数 和 函数体
  const param = paramReg.exec(funcString);
  const body = bodyReg.exec(funcString);
  if(!body) return null;
  if (param) {
    const paramArr = param[0].split(',');
    return new Function(...paramArr, body[0]);
 } else {
    return new Function(body[0]);
 }
}
```

到现在，我们的深拷贝就实现地比较完善了。不过在测试的过程中，我也发现了一个小小的bug。

#### 小小bug

如下所示:

```js
const target = new Boolean(false);
const Ctor = target.constructor;
new Ctor(target); // 结果为 Boolean {true} 而不是 false。

```

对于这样一个bug，我们可以对 Boolean 拷贝做最简单的修改， 调用valueOf: new  target.constructor(target.valueOf())。 

但实际上，这种写法是不推荐的。因为在ES6后不推荐使用【new 基本类型()】这 样的语法，所以es6中 的新类型 Symbol 是不能直接 new 的，只能通过 new Object(SymbelType)。 

因此我们接下来统一一下:

```js
const handleNotTraverse = (target, tag) => {
  const Ctor = targe.constructor;
  switch(tag) {
    case boolTag:
      return new Object(Boolean.prototype.valueOf.call(target));
    case numberTag:
      return new Object(Number.prototype.valueOf.call(target));
    case stringTag:
      return new Object(String.prototype.valueOf.call(target));
    case errorTag: 
    case dateTag:
      return new Ctor(target);
    case regexpTag:
      return handleRegExp(target);
    case funcTag:
      return handleFunc(target);
    default:
      return new Ctor(target);
 }
}
```

### 完整代码展示

```js
const getType = obj => Object.prototype.toString.call(obj);
const isObject = (target) => (typeof target === 'object' || typeof target === 'function') && target !== null;
const canTraverse = {
    '[object Map]': true,
    '[object Set]': true,
    '[object Array]': true,
    '[object Object]': true,
    '[object Arguments]': true,
};
const mapTag = '[object Map]';
const setTag = '[object Set]';
const boolTag = '[object Boolean]';
const numberTag = '[object Number]';
const stringTag = '[object String]';
const symbolTag = '[object Symbol]';
const dateTag = '[object Date]';
const errorTag = '[object Error]';
const regexpTag = '[object RegExp]';
const funcTag = '[object Function]';

// 处理正则表达式
const handleRegExp = (target) => {
    const { source, flags } = target;
    return new target.constructor(source, flags);
}

// 处理函数
const handleFunc = (func) => {
    // 箭头函数直接返回自身
    if (!func.prototype) return func;
    // 对于普通函数，直接返回原函数，因为无法安全地复制其作用域
    return func;
}

// 处理不能遍历的数据类型
const handleNotTraverse = (target, tag) => {
    const Ctor = target.constructor;
    switch (tag) {
        case boolTag:
            return Boolean(target);
        case numberTag:
            return Number(target);
        case stringTag:
            return String(target);
        case symbolTag:
            // 符号不能直接复制，返回原符号
            return target;
        case errorTag:
        case dateTag:
            return new Ctor(target);
        case regexpTag:
            return handleRegExp(target);
        case funcTag:
            return handleFunc(target);
        default:
            return new Ctor(target);
    }
}

// 深度克隆函数
const deepClone = (target, map = new WeakMap()) => {
    // 如果不是对象，直接返回
    if (!isObject(target)) return target;
    const type = getType(target);
    let cloneTarget;
    // 处理不能遍历的数据类型
    if (!canTraverse[type]) {
        return handleNotTraverse(target, type);
    }
    // 创建克隆对象，保证原型不丢失
    const ctor = target.constructor;
    cloneTarget = new ctor();
    // 处理循环引用
    if (map.get(target)) return target;
    map.set(target, true);
    // 处理 Map
    if (type === mapTag) {
        target.forEach((value, key) => {
            cloneTarget.set(deepClone(key, map), deepClone(value, map));
        });
    }
    // 处理 Set
    if (type === setTag) {
        target.forEach(value => {
            cloneTarget.add(deepClone(value, map));
        });
    }
    // 处理数组和对象
    for (const prop in target) {
        if (target.hasOwnProperty(prop)) {
            cloneTarget[prop] = deepClone(target[prop], map);
        }
    }
    return cloneTarget;
}
```

## 数据是如何存储的？

基本数据类型用栈存储，引用数据类型用堆存储。

看起来没有错误，但实际上是有问题的。可以考虑一下闭包的情况，如果变量存在栈中，那函数调用完 栈顶空间销毁 ，闭包变量不就没了吗？

其实还是需要补充一句:

> 闭包变量是存在堆内存中的。

具体而言，以下数据类型存储在栈中:

- boolean
- null
- undefined
- number
- string
- symbol
- bigint

而所有的对象数据类型存放在堆中。 值得注意的是，对于 赋值 操作，原始类型的数据直接完整地复制变量值，对象数据类型的数据则是复制 引用地址。 因此会有下面的情况:

```js
let obj = { a: 1 };
let newObj = obj;
newObj.a = 2;
console.log(obj.a);//变成了2
```

之所以会这样，是因为 obj 和 newObj 是同一份堆空间的地址，改变newObj，等于改变了共同的堆内 存，这时候通过 obj 来获取这块内存的值当然会改变。 

为什么不全部用栈来保存呢？ 

首先，对于系统栈来说，它的功能除了保存变量之外，还有创建并切换函数执行上下文的功能。举个例 子:

```js
function f(a) {
  console.log(a);
}
function func(a) {
  f(a);
}
func(1);
```

假设用ESP指针来保存当前的执行状态，在系统栈中会产生如下的过程：

 1）调用func, 将 func 函数的上下文压栈，ESP指向栈顶。

 2）执行func，又调用f函数，将 f 函数的上下文压栈，ESP 指针上移。 

3）执行完 f 函数，将ESP 下移，f函数对应的栈顶空间被回收。 

4）执行完 func，ESP 下移，func对应的空间被回收。 图示如下:

![image-20250221164822178](D:\study\blog\source\_posts\interview\js\Skyjs\image-20250221164822178.png)

因此你也看到了，如果采用栈来存储相对基本类型更加复杂的对象数据，那么切换上下文的开销将变得 巨大！ 不过堆内存虽然空间大，能存放大量的数据，但与此同时垃圾内存的回收会带来更大的开销。

## v8引擎如何进行垃圾内存的回收？

JS 语言不像 C/C++, 让程序员自己去开辟或者释放内存，而是类似Java，采用自己的一套垃圾回收算法进 行自动的内存管理。作为一名资深的前端工程师，对于JS内存回收的机制是需要非常清楚, 以便于在极端 的环境下能够分析出系统性能的瓶颈，另一方面，学习这其中的机制，也对我们深入理解JS的闭包特 性、以及对内存的高效使用，都有很大的帮助。

### v8内存限制

在其他的后端语言中，如Java/Go, 对于内存的使用没有什么限制，但是JS不一样，V8只能使用系统的一 部分内存，具体来说，在 64 位系统下，V8最多只能分配 1.4G , 在 32 位系统中，最多只能分配 0.7G 。 你想想在前端这样的大内存需求其实并不大，但对于后端而言，nodejs如果遇到一个2G多的文件，那么 将无法全部将其读入内存进行各种操作了。 

我们知道对于栈内存而言，当ESP指针下移，也就是上下文切换之后，栈顶的空间会自动被回收。但对 于堆内存而言就比较复杂了，我们下面着重分析堆内存的垃圾回收。 

所有的对象类型的数据在JS中都是通过堆进行空间分配的。当我们构造一个对象进行赋值操作的时候， 其实相应的内存已经分配到了堆上。你可以不断的这样创建对象，让 V8 为它分配空间，直到堆的大小达到上限。 

那么问题来了，V8 为什么要给它设置内存上限？明明我的机器大几十G的内存，只能让我用这么一点？究其根本，是由两个因素所共同决定的，一个是JS单线程的执行机制，另一个是JS垃圾回收机制的限制。 

首先JS是单线程运行的，这意味着一旦进入到垃圾回收，那么其它的各种运行逻辑都要暂停; 另一方面垃圾回收其实是非常耗时间的操作，V8 官方是这样形容的:

> 以 1.5GB 的垃圾回收堆内存为例，V8 做一次小的垃圾回收需要50ms 以上，做一次非增量式(ps: 后面会解释)的垃圾回收甚至要 1s 以上。

可见其耗时之久，而且在这么长的时间内，我们的JS代码执行会一直没有响应，造成应用卡顿，导致应用性能和响应能力直线下降。因此，V8 做了一个简单粗暴的选择，那就是限制堆内存，也算是一种权衡 的手段，因为大部分情况是不会遇到操作几个G内存这样的场景的。

 不过，如果你想调整这个内存的限制也不是不行。配置命令如下:

```js
// 这是调整老生代这部分的内存，单位是MB。后面会详细介绍新生代和老生代内存
node --max-old-space-size=2048 xxx.js 
```

或者

```js
// 这是调整新生代这部分的内存，单位是 KB。
node --max-new-space-size=2048 xxx.js
```

### 新生代内存的回收

V8 把堆内存分成了两部分进行处理——新生代内存和老生代内存。顾名思义，新生代就是临时分配的内存，存活时间短， 老生代是常驻内存，存活的时间长。V8 的堆内存，也就是两个内存之和。

![image-20250224101949653](image-20250224101949653.png)

根据这两种不同种类的堆内存，V8 采用了不同的回收策略，来根据不同的场景做针对性的优化。

首先是新生代的内存，刚刚已经介绍了调整新生代内存的方法，那它的内存默认限制是多少？在 64 位 和 32 位系统下分别为 32MB 和 16MB。够小吧，不过也很好理解，新生代中的变量存活时间短，来了 马上就走，不容易产生太大的内存负担，因此可以将它设的足够小。 

那好了，新生代的垃圾回收是怎么做的呢？ 首先将新生代内存空间一分为二:

![image-20250224102825804](image-20250224102825804.png)

其中From部分表示正在使用的内存，To 是目前闲置的内存。 

当进行垃圾回收时，V8 将From部分的对象检查一遍，如果是存活对象那么复制到To内存中(在To内存中 按照顺序从头放置的)，如果是非存活对象直接回收即可。 

当所有的From中的存活对象按照顺序进入到To内存之后，From 和 To 两者的角色 对调 ，From现在被 闲置，To为正在使用，如此循环。 

那你很可能会问了，直接将非存活对象回收了不就万事大吉了嘛，为什么还要后面的一系列操作？ 

注意，我刚刚特别说明了，在To内存中按照顺序从头放置的，这是为了应对这样的场景:

![image-20250224103051767](image-20250224103051767.png)

深色的小方块代表存活对象，白色部分表示待分配的内存，由于堆内存是连续分配的，这样零零散散的 空间可能会导致稍微大一点的对象没有办法进行空间分配，这种零散的空间也叫做内存碎片。刚刚介绍 的新生代垃圾回收算法也叫Scavenge算法。 

Scavenge 算法主要就是解决内存碎片的问题，在进行一顿复制之后，To空间变成了这个样子:

![image-20250224103159634](image-20250224103159634.png)

是不是整齐了许多？这样就大大方便了后续连续空间的分配。 

不过Scavenge 算法的劣势也非常明显，就是内存只能使用新生代内存的一半，但是它只存放生命周期短的对象，这种对象 一般很少 ，因此 时间 性能非常优秀。

### 老生代内存的回收

刚刚介绍了新生代的回收方式，那么新生代中的变量如果经过多次回收后依然存在，那么就会被放入到 老生代内存中，这种现象就叫晋升 。 

发生晋升其实不只是这一种原因，我们来梳理一下会有那些情况触发晋升: 

- 已经经历过一次 Scavenge 回收。 
- To（闲置）空间的内存占用超过25%。

现在进入到老生代的垃圾回收机制当中，老生代中累积的变量空间一般都是很大的，当然不能用 Scavenge 算法啦，浪费一半空间不说，对庞大的内存空间进行复制岂不是劳民伤财？ 

那么对于老生代而言，究竟是采取怎样的策略进行垃圾回收的呢？ 

第一步，进行标记-清除。这个过程在《JavaScript高级程序设计(第三版)》中有过详细的介绍，主要分成两个阶段，即标记阶段和清除阶段。首先会遍历堆中的所有对象，对它们做上标记，然后对于代码环境中使用的变量以及被强引用的变量取消标记，剩下的就是要删除的变量了，在随后的清除阶段 对其进行空间的回收。 

当然这又会引发内存碎片的问题，存活对象的空间不连续对后续的空间分配造成障碍。老生代又是如何处理这个问题的呢？

第二步，整理内存碎片。V8 的解决方式非常简单粗暴，在清除阶段结束后，把存活的对象全部往一端靠拢。

![image-20250224104541191](image-20250224104541191.png)

由于是移动对象，它的执行速度不可能很快，事实上也是整个过程中最耗时间的部分。

### 增量标记

由于JS的单线程机制，V8 在进行垃圾回收的时候，不可避免地会阻塞业务逻辑的执行，倘若老生代的垃圾回收任务很重，那么耗时会非常可怕，严重影响应用的性能。那这个时候为了避免这样问题，V8 采取了增量标记的方案，即将一口气完成的标记任务分为很多小的部分完成，每做完一个小的部分就"歇"一 下，就js应用逻辑执行一会儿，然后再执行下面的部分，如果循环，直到标记阶段完成才进入内存碎片的整理上面来。其实这个过程跟React Fiber的思路有点像，这里就不展开了。

经过增量标记之后，垃圾回收过程对JS应用的阻塞时间减少到原来了1 / 6, 可以看到，这是一个非常成功 的改进。

## 描述一下v8执行一段js代码的过程
