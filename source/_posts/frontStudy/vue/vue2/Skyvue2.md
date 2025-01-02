---
title: vue2
top: 96
categories: 
    - 前端学习
    - vue2
tags:
  - js
  - vue2
  - css
abbrlink: 6049
date: 2024-12-27 18:12:38
---

##### 本文讲述了vue2的相关教程
<!-- more -->

# vue尚硅谷

## 1.Vue简介

### 1.2Vue是什么

一套用于构建用户界面的渐进是JavaScript框架

渐进式：Vue可以自底向上逐层的应用

简单的应用：只需要一个轻量小巧的核心库

复杂的应用：可以引入各式各样的Vue插件

### 1.3Vue的特点

1.采用组件化模式，提高代码复用率，且让代码更好维护

2.声明式编码，让编码人员无需直接操作DOM，提高开发效率

3.使用虚拟DOM+优秀的Diff算法，尽量复用DOM节点

## 2.搭建Vue开发环境及Vue核心

### 2.1.下载并引用

在Vue官网下载好到本地使用

```html
<script type="text/javascript" src="../js/vue.js"></script>
```

### 2.2.关闭开发版的警告

```html
<script type="text/javascript">
    Vue.config.productionTip = false //设置为 false 以阻止 vue 在启动时生成生产提示。
</script>
```

### 2.3.代码

容器与实例之间是1对1关系

 中间可以放入js代码或表达式或vue的方法和属性

注意区分：js表达式和js代码(语句)

1.表达式：一个表达式会产生一个值，可以放在任何一个需要值得地方：

(1).a

(2).a+b

(3).demo(1)

(4).x === y ? 'a' : 'b'

2.js代码(语句)

(1).if(){ }

(2).for(){ }



```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>初识Vue</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            <h1>hello,{{name}}</h1>
        </div>
        <script type="text/javascript">
        //创建Vue实例
        const x = new Vue({
            el:'#root',//el用于指定当前Vue实例为那个容器服务,值通常为css选择器字符串。
            data:{//data中用于存储数据，数据供el所指定的容器去使用。
                name:'sky'
            }
        })
        </script>
    </body>
</html>
```

### 2.4模板语法

1.插值语法 { { } }

用于标签体

```html
<h2>hello,{{name}}</h2>
```

2.指令语法

用于标签属性

```html
<a v-bind:href="url">链接</a>
```

### 2.5.数据绑定

v-bind用于单向绑定数据

name改变input的值改变，反之不行

```html
<input type="text" v-bind:value="name">
```

v-model用于双向绑定数据

```html
<input type="text" v-model:value="name">
```

注意：双向绑定一般应用到表单类元素(输入类的元素)如input,select

v-model:value可以简写为v-model,因为v-model收集的就是value值

### 2.6el与data的两种写法

el写法一：

```
new Vue({
            el:'#root',//el用于指定当前Vue实例为那个容器服务,值通常为css选择器字符串。
            data:{//data中用于存储数据，数据供el所指定的容器去使用。
                name:'sky'
            }
        })
```

el写法二：

```
const n = new Vue({
            data:{
                name:'sky'
            }
        })
        console.log(n)
        setTimeout(()=>{
            n.$mount('#root')
        }, 1000);
```

data写法一：对象式

```
new Vue({
            el:'#root',
            //第一种data写法对象式
            data:{
                name:'sky'
            } 
        })
```

data写法二：函数式

```
new Vue({
            el:'#root',
            //第二种写法函数式
            data(){
                return{
                    name:'sky'
                }
            }
        })
```

注意：由Vue管理的函数，一定不能写箭头函数，一但写了箭头函数，this就不是Vue实例了

### 2.7.MVVM模型及数据代理

M：模型（Model):对应data中的数据

V：视图（View):模板

VM：视图模型（ViemModel):Vue实例对象

![MVVM](MVVM.jpg)

vm身上的所有属性，及Vue原型上所有属性，在Vue模板中都可以使用

![数据代理](数据代理.jpg)

Vue中的数据代理:通过vm对象来代理data对象中的属性操作(读/写)

Vue中数据代理的好处:更加方便的操作data中的数据

基本原理:

通过Object.defineProperty()把data对象中所有属性添加到vm上。

为每一个添加到vm的属性，都指定一个getter/setter。

在getter/setter内部操作（读/写）data中对应属性。

### 2.8.事件处理

#### v-on

v-on来绑定方法，v-on:简写成@

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>事件的基本使用</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            <h1>欢迎来到{{name}}学习</h1>
            <button @click="showInfo1">点我提示信息</button>
            <button @click="showInfo2(66)">点我提示信息</button>
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
        //创建Vue实例
        const x = new Vue({
            el:'#root',
            data:{
                name:'Vue'
            },
            methods:{
                showInfo1(){
                    alert('同学你好')
                },
                showInfo2(number){
                    alert('欢迎')
                    console.log(number)
                }
            }
        })
        </script>
    </body>
</html>
```

#### 修饰符（允许连用）

prevent:阻止默认事件

stop:阻止事件冒泡

once:事件只触发一次

capture:使用事件捕获模式

self:只有event.target是当前操作的元素时才能触发事件

passive:事件的默认行为立即执行，无需等待事件回调执行完毕

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>事件的基本使用</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            <h1>欢迎来到{{name}}学习</h1>
            <!-- prevent:阻止默认事件 -->
            <a href="https://cn.vuejs.org/" @click.prevent="showInfo">点我提示信息</a>
            <!-- stop:阻止事件冒泡 -->
            <div class="demo1" @click="showInfo">
            <button @click.stop="showInfo">点我提示信息</button>
            </div>
            <!-- once:事件只触发一次 -->
            <button @click.once="showInfo">点我提示信息</button>
            <!-- capture:使用事件捕获模式 -->
            <div class="box1" @click.capture="showMsg(1)">
                div1
                <div class="box2" @click="showMsg(2)">
                    div2
                </div>
            </div>
            <!-- self:只有event.target是当前操作的元素时才能触发事件 -->
            <div class="demo1" @click.self="showInfo">
                <button @click="showInfo">点我提示信息</button>
            </div>
            <!-- passive:事件的默认行为立即执行，无需等待事件回调执行完毕 -->
            //wheel鼠标滚轮和scroll滚动条
            <ul class="list" @wheel="demo">
                <li>1</li>
                <li>2</li>
                <li>3</li>
                <li>4</li>
            </ul>
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
        //创建Vue实例
        const x = new Vue({
            el:'#root',
            data:{
                name:'Vue'
            },
            methods:{
                showInfo(){
                    alert('腾讯timi')
                },
                showMsg(n){
                    console.log(n)
                },
                demo(){
                    for(i=0;i<100000;i++)
                    {
                        console.log('#')
                    }
                    console.log('累死了')
                }
            }
        })
        </script>
    </body>
    <style>
        *{
            margin-top: 20px;
        }
        .demo1{
            height: 50px;
            background-color: skyblue;
        }
        .box1{
            margin: 10px;
            background-color: skyblue;
        }
        .box2{
            margin: 10px;
            background-color: orange;
        }
        .list{
            height: 200px;
            width: 200px;
            background-color: peru;
            overflow: auto;
        }
        li{
            height: 100px;
        }
    </style>
</html>
```

#### 键盘事件

1.Vue中常用的按键别名:

回车=enter；删除=delete（捕获“删除”和“退格”键）；退出=esc；

空格=space；换行=tab；上=up；下=dowm；左=left；右=right

注意：tab要配合keydowm使用

2.Vue未提供别名的按键，可以使用按键原始的key值(e.keyCode是按键编码，e.key按键名称)去绑定，但注意要转化为kebab-case(短横线命名)

3.系统修饰键（用法特殊）：ctrl、alt、shift、meta

配合keyup使用：按下修饰键的同时，再按下其他键，随后释放其他键，时间才被触发。ctrl+x只有当按ctrl加x才能实现

配合keydown使用：正常触发事件

4.Vue.config.keyCodes.自定义键名=键码,可以定制按键别名

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>键盘事件</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            <!-- 键盘点击事件keydown和keyup -->
            <input type="text" placeholder="按下回车提示输入" @keyup.enter="showInfo">
            <input type="text" placeholder="按下大写键提示输入" @keyup.caps-lock="showInfo">
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
            Vue.config.keyCodes.huiche = 13
        //创建Vue实例
        const x = new Vue({
            el:'#root',//el用于指定当前Vue实例为那个容器服务,值通常为css选择器字符串。
            data:{//data中用于存储数据，数据供el所指定的容器去使用。
                name:'sky'
            },
            methods:{
                showInfo(e){
                    /* if(e.keyCode !== 13) return */
                    console.log(e.target.value)
                }
            }
        })
        </script>
    </body>
</html>
```

### 2.9.计算属性

定义：要用的属性不存在，要通过已有属性计算得来。

原理：底层借用了Objcet.defineproperty方法提供的getter和setter

getter函数什么时候执行：

1.初次读取fullname2.所依赖的数据变化时

优势：与methods实现相比，内部有缓存机制（复用），效率高，调用方便

当只读不改时可以简写为

```
computed:{
    fullname(){
          return this.firstname + '-' +this.lastname
        }
    }
```

### 2.10.监视属性

#### 1.watch:

1.当被监视的属性发生改变时，回调函数自动调用，进行相关操作

2.监视的属性必须存在，才能监视

3.监视的两种写法：

new Vue是传入watch配置

通过vm.$watch监视

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>天气案列_监视属性</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            <h1>今天天气很{{info}}</h1>
            <button @click="change">切换天气</button>
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
        //创建Vue实例
        const vm = new Vue({
            el:'#root',//el用于指定当前Vue实例为那个容器服务,值通常为css选择器字符串。
            data:{//data中用于存储数据，数据供el所指定的容器去使用。
                isHot:true
            },
            computed:{
                info(){
                    return this.isHot ? '炎热' : '凉爽'
                }
            },
            methods: {
                change(){
                    this.isHot = !this.isHot
                }
            },
            //监视属性第一种写法
            /* watch:{
                isHot:{
                    immediate:true, //初始化是让handler被调用
                    //handler什么时候调用?当isHot被修改时调用
                    handler(newValue,oldValue){
                        console.log('isHot被修改了',newValue,oldValue)
                    }
                }
            } */
            
        })
        //监视属性第二种写法
        vm.$watch('isHot',{
                immediate:true, //初始化是让handler被调用
                    //handler什么时候调用?当isHot被修改时调用
                    handler(newValue,oldValue){
                        console.log('isHot被修改了',newValue,oldValue)
                    }
            })
        </script>
    </body>
</html>
```

#### 2.深度监视

Vue中的watch默认不监测对象内部值的改变（一层）

配置deep：true可以监视对象内部的改变（多层）

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>天气案列_深度监视</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            <h1>今天天气很{{info}}</h1>
            <button @click="change">切换天气</button>
            <hr/>   
            <h1>a的值为：{{numbers.a}}</h1>
            <button @click="numbers.a++">点我让a++</button>
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
        //创建Vue实例
        const vm = new Vue({
            el:'#root',//el用于指定当前Vue实例为那个容器服务,值通常为css选择器字符串。
            data:{//data中用于存储数据，数据供el所指定的容器去使用。
                isHot:true,
                numbers:{
                    a:1,
                    b:2
                }
            },
            computed:{
                info(){
                    return this.isHot ? '炎热' : '凉爽'
                }
            },
            methods: {
                change(){
                    this.isHot = !this.isHot
                }
            },
            watch:{
                /* //监视多级结构中的某个属性变化
                'numbers.a':{
                    handler(){
                        console.log('被修改')
                    }
                } */
                //监视多级属性中的所有属性变化
                numbers:{
                    deep:true,
                    handler(){
                        console.log('6666')
                    }
                }
            }   
        })
        </script>
    </body>
</html>
```

#### 3.监视简写：

```
一：watch:{
     isHot(){
      console.log('xiugai')
      }
二：vm.$watch('isHot',function(){
            console.log('xiugai')
        })
```

### 2.11计算属性和监视属性的区别

computed和watch的区别:

1.computed能完成的功能watch都可以完成

2.watch能玩成的功能，computed不一定能完成，列如：watch可以使用异步操作

注意：

1.所被Vue管理的函数，最好写成普通函数，这样this的指向才是vm或组件实例对象.

2.所有不被Vue所管理的函数（定时器的回调函数、ajax的回调函数等），最好写成箭头函数，这样this的指向才是vm或组件实例对象

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>姓名案列-watch实现</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            姓：<input type="text" v-model="firstname"><br/><br/>
            名：<input type="text" v-model="lastname"><br/><br/>
            姓名：<span>{{fullname}}</span>
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
        //创建Vue实例
        const vm = new Vue({
            el:'#root',//el用于指定当前Vue实例为那个容器服务,值通常为css选择器字符串。
            data:{//data中用于存储数据，数据供el所指定的容器去使用。
                name:'sky',
                firstname:'张',
                lastname:'三',
                fullname:'张-三'
            },
            watch:{
                firstname(val){
                    setTimeout(()=>{
                        this.fullname = val +'-' + this.lastname
                    },1000)
                },
                lastname(val){
                    this.fullname = this.firstname + '-' + val
                }
            }
        })
        </script>
    </body>
</html>
```

### 2.12样式绑定

使用:class='xxxx'或:style='xxx'来绑定

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>绑定样式</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <div id="root">
        <!-- 绑定class样式--字符串写法，适用于：样式的类名不确定，需要动态指定 -->
        <div id="root" class="base" :class="value" @click="changevalue"></div><br/><br/>
        <!-- 绑定class样式--数组写法，适用于：要绑定的样式个数不确定、名字也不确定 -->
        <div id="root" class="base" :class="arr"></div><br/><br/>
        <!-- 绑定class样式--对象写法，适用于：要绑定的样式个数确定、名字也确定、但要动态变化决定用不用 -->
        <div id="root" class="base" :class="obj"></div>
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
        //创建Vue实例
        const x = new Vue({
            el:'#root',//el用于指定当前Vue实例为那个容器服务,值通常为css选择器字符串。
            data:{//data中用于存储数据，数据供el所指定的容器去使用。
                name:'sky',
                value:'blue',
                arr:[
                    'blue',
                    'happy',
                    'sad',
                ],
                obj:{
                    blue:true,
                    happy:false
                }
            },
            methods:{
                changevalue(){
                    const arr=['blue','happy','sad']
                    const index = Math.floor(Math.random()*3)
                    this.value=arr[index]
                }
            }
        })
        </script>
    </body>
    <style>
        .happy{
            background-color: red;
        }
        .sad{
            background-color: green;
        }
        .blue{
            background-color: lightskyblue;
        }
        .bb{
            border-radius: 0%;
        }
        .base{
            height: 200px;
            width: 300px;
        }
    </style>
</html>
```

### 2.13条件渲染

#### 1.v-if

写法：(1).v-if="表达式";)=(2).v-else-if="表达式";(3).v-else="表达式"

适用于：切换频率低的场景

特点：不展示的DOM元素直接被移除

注意：v-if可以和：v-else-if、v-else一起使用，但要求不能被打断

#### 2.v-show

写法：v-show="表达式"

适用于：切换评率较高的场景。

特点：不展示的DOM元素未被移除，仅仅只是使用样式隐藏

注：使用v-if的时候，元素可能无法获取到，而使用v-show一定可以获取到

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>条件渲染</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            <h2>当前的n值为：{{n}}</h2>
            <button @click="n++">点我n+1</button>
            <!-- 使用v-show做条件渲染 -->
            <!-- <h2 v-show="false">欢迎来到{{name}}</h2> -->
            <!-- <h2 v-show="1 === 1">欢迎来到{{name}}</h2> -->

            <!-- 使用v-if做条件渲染 -->
            <!-- <h2 v-if="flase">欢迎来到{{name}}</h2> -->
            <!-- <h2 v-if="1 === 1">欢迎来到{{name}}</h2> -->

            <!-- v-if和v-else-if -->
            <!-- <div v-if="n === 1">Angular</div>
            <div v-else-if="n === 2">React</div>
            <div v-else-if="n === 3">Vue</div>
            <div v-else>gameover</div> -->

            <!-- v-if和temlate的使用 -->
            <template v-if="n === 2">
            <h2>你好</h2>
            <h2>云南</h2>
            <h2>昭通</h2>
            </template>
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
        //创建Vue实例
        const x = new Vue({
            el:'#root',
            data:{
                name:'云南昭通',
                n: 1
            }
        })
        </script>
    </body>
</html>
```

### 2.14列表渲染

#### 1.v-for指令

用于展示列表数据

语法：v-for=“（item,index) in xxx" :key="yyy"

可遍历的对象：数组，对象，字符串（用的很少），指定次数（用的很少）

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>基本列表</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            <!-- 数组遍历 -->
            <h2>人员列表</h2>
            <ul>
                <li v-for="(p,index) in persons" :key="index">
                    {{p.name+'-'+p.age}}
                </li>
            </ul>
            <!-- 对象遍历 -->
            <h2>人员列表</h2>
            <ul>
                <li v-for="(c,key) in cars" :key="key">
                    {{key}}-{{c}}
                </li>
            </ul>
            <!-- 字符串遍历 -->
            <h2>测试字符串遍历</h2>
            <ul>
                <li v-for="(char,index) in str" :key="index">
                    {{index}}-{{char}}
                </li>
            </ul>
            <!-- 指定遍历 -->
            <h2>测试指定次数遍历</h2>
            <ul>
                <li v-for="(n,index) in 5" :key="index">
                    {{index}}-{{n}}
                </li>
            </ul>
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
        const x = new Vue({
            el:'#root',
            data:{
                persons:[
                    {id:'1',name:'张三',age:'18'},
                    {id:'2',name:'李四',age:'19'},
                    {id:'3',name:'王五',age:'20'},
                ],
                cars:{
                    name:'奥迪',
                    price:'70万',
                    color:'黑色'
                },
                str:'hello'
            }
        })
        </script>
    </body>
</html>
```



#### 2.key的原理

面试题：react,vue中的key有什么作用?(key的内部原理)

##### 2.1虚拟DOM中的key的作用：

key时候虚拟DOM对象的标示，当数据发生变化时，Vue会根据新数据生成新的虚拟DOM，随后Vue进行新的虚拟DOM与旧的虚拟DOM的差异比较，比较规则如下：

##### 2.2比较规则：

（1）.旧的虚拟DOM中找到与新的虚拟DOM相同的key

旧虚拟DOM中内容没变，直接使用之前是的真是DOM

若虚拟DOM中内容变了，则生成新的真实DOM，随后替换掉页面中之前的真实DOM

（2）.旧虚拟DOM中未找到与新虚拟DOM相同的key

创建新的真实DOM，随后渲染到页面上

##### 2.3用index作为key可能会引发的问题：

(1).若对数据进行：逆序添加，逆序删除等破坏顺序的操作会产生没有必要的真实DOM更新，还有界面效果没问题，但效率低

(2).如果结构中还包含输入类的DOM：会产生错误的DOM更新——界面有问题

##### 2.4开发中如何选择key？

1.最好使用每条数据的唯一标识作为key，比如id、手机号、身份证号、学号等唯一值

2.如果不存在对数据的逆序添加、逆序删除等破坏顺序操作，仅用于渲染列表用于展示，使用index作为key是没有问题的

用id:![key-id](key-id.jpg)

用index:![key-index](key-index.jpg)

### 2.15Vue数据监视原理

1.Vue会监视data中所有层次的数据

2.如何监测对象中的数据？

通过setter实现监视，且要在new Vue时就传入要监测的数据。

（1）.对象中后追加的属性，Vue默认不做响应式处理

（2）.如需给后添加的属性做响应式，请使用

Vue.set(vm.object/array, propertyName/index, value)或

vm.$set(vm.object/array, propertyName/index, value)

3.如何监测数据中的数据？

通过包裹数组更新元素的方法实现，本质就是做了两件事：

（1）.调用原生对应的方法对数组进行更新。

（2）.重新解析模板，进而更新页面。

4.在Vue修改数组中的某个元素一定要使用以下方法：

1.使用这些API：push()、pop()、shift()、unshift()、splice()、sort()、reverse()

2.Vue.set或vm.$set

特别注意：Vue.set()和vm.$set()不能给vm或者vm的根数据对象添加属性！！！

### 2.16表单数据收集

若:<input type="text"/>，则v-model收集的是value值，用户输入的就是value值.

若:<input type="radio"/>，则v-model收集的是value值,且要给标签配置value值.

若<inpufi type="checkbox"/>

1.没有配置input的value属性，那么收集的就是checked（勾选or未勾选，是布尔值)

2.配置input的value属性:

（1)v-model的初始值是非数组,那么收集的就是checked(勾选or未勾选,是布尔值

（2)v-model的初始值是数组,那么收集的的就是value组成的数组

备注:v-model的三个修饰符:

lazy:失去焦点再收集数据

number:输入字符串转为有效的数字

trim:输入首尾空格过滤

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>收集表单数据</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            <form>
            账号:<input type="text" v-model="acount"><br><br>
            密码:<input type="password" v-model="password"><br><br>
            年龄:<input type='number' v-model.number="age"><br><br>
            性别：男<input type="radio" name="sex" v-model="sex" value="男">
                  女<input type="radio" name="sex" v-model="sex" value="女"><br><br>
            爱好：看书<input type="checkbox" v-model="habits" value="看书"> 
                  游戏<input type="checkbox" v-model="habits" value="游戏"> 
                  游泳<input type="checkbox" v-model="habits" value="游泳"> <br><br>
            所属校区：<select v-model="address">
                        <option value="">请选择校区</option>
                        <option value="北京">北京</option>
                        <option value="上海">上海</option>
                        <option value="杭州">杭州</option>
                     </select>
                     <br><br>
            其他信息：<textarea v-model.lazy="other"></textarea><br><br>
            <input type="checkbox" v-model="readAgree"><a href="https://www.bilibili.com/">阅读并接受</a><br><br>
            <button @click.prevent="submit">提交</button>
            </form>
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
        //创建Vue实例
        const x = new Vue({
            el:'#root',
            data:{
                acount:'',
                password:'',
                age:'',
                sex:'',
                habits:[],
                address:'',
                other:'',
                readAgree:''
            },
            methods:{
                submit(){
                    console.log(JSON.stringify(this._data))
                }
            }
        })
        </script>
    </body>
</html>
```

### 2.17过滤器

过滤器:

定义:对要显示的数据进行特定格式化后再显示（适用于一些简单逻辑的处理）。

语法:

1.注册过滤器:Vue.filter(name,callback)或new Vue{filters:{}}

2.使用过滤器:{{ xxx│过滤器名}}或v-bind:属性=“xxx|过滤器名"

备注:

1.过滤器也可以接收额外参数、多个过滤器也可以串联

2.并没有改变原本的数据,是产生新的对应的数据

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>过滤器</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
        <script type="text/javascript" src="../js/day.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            <h1>显示格式化后时间</h1>
            <!-- 计算属性实现 -->
            <h2>{{datatime}}</h2>
            <!-- methods实现 -->
            <h2>{{getTime()}}</h2>
            <!-- 过滤器实现-->
            <h2>{{time | timeFormater}}</h2>
            <!-- 过滤器实现（传参） -->
            <h2>{{time | timeFormater('YYYY_MM_DD') | mySlice}}</h2>
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
            //全局过滤器
            Vue.filter('mySlice',function(value){
                return value.slice(0,4)
            })
        //创建Vue实例
        const x = new Vue({
            el:'#root',
            data:{
                time:1687503955852
            },
            computed:{
                datatime(){
                    return dayjs(this.time).format('YYYY年MM月DD日 HH:mm:ss')
                }
            },
            methods:{
                getTime(){
                    return dayjs(this.time).format('YYYY年MM月DD日 HH:mm:ss')
                }
            },
            //局部过滤器
            filters:{
                timeFormater(value,str='YYYY年MM月DD日 HH:mm:ss'){
                    return dayjs(value).format(str)
                }
            }
        })
        </script>
    </body>
</html>
```



### 2.18内置指令

#### 1.v-text指令:

1.作用：向其所在的节点中渲染文本内容。

2.与插值语法的区别：v-text会替换掉节点中的内容.{{xx}}则不会

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>v-text指令</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            <h1>hello,{{name}}</h1>
            <h1 v-text="name"></h1>
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
        //创建Vue实例
        const x = new Vue({
            el:'#root',
            data:{
                name:'sky'
            }
        })
        </script>
    </body>
</html>
```



#### 2.v-html指令:

1.作用:向指定节点中渲染包含html结构的内容。

2.与插值语法的区别:

(1).v-html会替换掉节点中所有的内容，{{xx}}则不会。

(2).v-html可以识别html结构。

3.严重注意:v-html有安全性问题!!!!

(1).在网站上动态渲染任意HTMIL是非常危险的,容易导致XSS攻击。

(2).一定要在可信的内容上使用v-html，永不要用在用户提交的内容上!

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>v-html指令</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            <div>hello,{{name}}</div>
            <div v-html="str"></div>
            <div v-html="str2"></div>
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
        //创建Vue实例
        const x = new Vue({
            el:'#root',
            data:{
                name:'sky',
                str:'<h2>你好啊</h2>',
                str2:'<a href=javascript:location.href="http://www.baidu.com?"+document.coockie>点击事件'
            }
        })
        </script>
    </body>
</html>
```



#### 3.v-cloak指令（没有值）:

1.本质是一个特殊属性，Vue实例创建完毕并接管容器后，会删掉v-cloak属性。

2.使用css配合v-cloak可以解决网速慢时页面展示出{{xxx}}的问题。

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>v-cloak指令</title>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            <h1 v-cloak>hello,{{name}}</h1> 
        </div>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>//假如慢5s
        <script type="text/javascript">
            Vue.config.productionTip = false
        //创建Vue实例
        const x = new Vue({
            el:'#root',
            data:{
                name:'sky'
            }
        })
        </script>
    </body>
    <style>
        [cloak]{
            display: none;
        }
    </style>
</html>
```



#### 4.v-once指令:

1.v-once所在节点在初次动态渲染后，就视为静态内容了。

2.以后数据的改变不会引起v-once所在结构的更新，可以用于优化性能。

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>v-once指令</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            <h1 v-once>初始化的n值为,{{n}}</h1>
            <h1>当前n值为,{{n}}</h1>
            <button @click="n++">点我n++</button>
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
        //创建Vue实例
        const x = new Vue({
            el:'#root',
            data:{
                n:1
            }
        })
        </script>
    </body>
</html>
```



#### 5.v-pre指令:

1.跳过其所在节点的编译过程。

2.可利用它跳过:没有使用指令语法、没有使用插值语法的节点，会加快编译。

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>v-pre指令</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            <h1 v-pre>Vue其实很简单</h1>
            <h1>当前n值为,{{n}}</h1>
            <button @click="n++">点我n++</button>
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
        //创建Vue实例
        const x = new Vue({
            el:'#root',
            data:{
                n:1
            }
        })
        </script>
    </body>
</html>
```



### 2.19自定义指令

自定义指令总结:

一、定义语法:

(1).局部指令:

new Vue({

​    directives:{指令名:配置对象}

})

或

new Vue({

directives{指令名:回调函数}

})

(2).全局指令:

Vue.directive(指令名,配置对象）或 Vue.directive(指令名,回调函数)

二.配置对象中常用的3个回调:

(1).bind:指令与元素成功绑定时调用。

(2).inserted:指令所在元素被插入页面时调用。

(3).update:指令所在模板结构被重新解析时调用。

三、备注:

1.指令定义时不加v-，但使用时要加v-;

2.指令名如果是多个单词，要使用kebab-case命名方式，不要用

camelCase命名.

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8"/>
        <title>自定义指令</title>
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <div id="root">
            <h2>当前的n值为：<span v-text="n"></span></h2>
            <h2>放大10倍后的n值为：<span v-big="n"></span></h2>
            <button @click="n++">点我n++</button>
            <hr>
            <input type="text" v-fbind="n">
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
            Vue.directive('big',function(element,binding){
                        element.innerText = binding.value * 10
                    },)
            Vue.directive('fbind',{
                        //指令与元素绑定成功时（一上来）
                        bind(element,binding){
                            element.value = binding.value
                        },
                        //指令所在元素被插入页面是
                        inserted(element,binding){
                            element.focus()
                        },
                        //指令所在的模板被重新解析时
                        update(element,binding){
                            element.value = binding.value
                        }
                    })
            const vm = new Vue({
                el:'#root',
                data:{
                    n:1
                },
                /* directives:{//里面的this为Windows
                    //big函数何时被调用？1.指令与元素成功绑定时（一上来）2.指令所在模板被解析时
                    big(element,binding){
                        element.innerText = binding.value * 10
                    },
                    fbind:{
                        //指令与元素绑定成功时（一上来）
                        bind(element,binding){
                            element.value = binding.value
                        },
                        //指令所在元素被插入页面是
                        inserted(element,binding){
                            element.focus()
                        },
                        //指令所在的模板被重新解析时
                        update(element,binding){
                            element.value = binding.value
                        }
                    }
                } */
            })
        </script>
    </body>
</html>
```

### 2.20生命周期

![生命周期](生命周期.png)

vm的一生(vm的生命周期）:
将要创建===>调用beforeCreate函数。

创建完毕===>调用created函数。

将要挂载===>调用beforeMount函数。

(重要)挂载完毕===〉调用mounted函数。=======>【重要的钩子】

将要更新===>调用beforeUpdate函数。

更新完毕-==>调用updated函数。

(重要)将要销毁===>调用beforeDestroy函数。=======>【重要的钩子】

销毁完毕===>调用destroyed函数。

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8"/>
        <title>分析生命周期</title>
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <div id="root">
            
        </div>
        <script type="text/javascript">
            const vm = new Vue({
                el:'#root',
                template:`
                <div>
                <h2>n的值为：{{n}}</h2>
                <button @click="addN">点我n加一</button>
                <button @click='bye'>点我销毁Vue></button>
                </div>
                `,
                data:{
                    n:1
                },
                methods:{
                    addN(){
                        this.n++
                    },
                    bye(){
                        console.log('bye')
                        this.$destroy()
                    }
                },
                beforeCreate() {
                    console.log('beforeCreate')
                },
                created() {
                    console.log('create')
                },
                beforeMount() {
                    console.log('beforeMount')
                },
                mounted() {
                    console.log('mounted')
                },
                beforeUpdate(){
                    console.log('beforeUpdate')
                },
                updated() {
                    console.log('updated')
                },
                beforeDestroy() {
                    console.log('beforeDestroy')
                    debugger;
                },
                destroyed() {
                    console.log('destroyed')
                }
            })
            
        </script>
    </body>
</html>
```

#### 1.生命周期常用钩子及实例

常用的生命周期钩子:
1.mounted:发送ajax请求、启动定时器、绑定自定义事件、订阅消息等【初始化操作】.

2.beforeDestroy:清除定时器、解绑自定义事件、取消订阅消息等【收尾工作】.

关于销毁Vue实例
1,销毁后借助Vue开发者工具看不到任何信息。

2.销毁后自定义事件会失效但原生DOM事件依然有效-

3，一服不会在beforeDestroy操作数据,因为即便操作数据,也不会再触发更新流程了。

## 3.Vue组件化编程

传统的编程方式：

![传统方式编写应用](传统方式编写应用.png)

组件化的编程方式：

![使用组件方式编写应用](使用组件方式编写应用.png)

组件的定义：

![组件的定义](组件的定义.png)

### 3.1模块与组件、模块化与组件化

#### 1.模块

1.理解：向外提供特定功能的js程序，一般就是一个js文件

2.为什么: js文件很多很复杂

3.作用:复用js，简化js 的编写，提高js运行效率

#### 2.组件

1.理解:用来实现局部(特定)功能效果的代码集合

2.为什么：一个界面的功能很复杂

3.作用:复用编码,简化项目编码。提高运行效率

#### 3.模块化

当应用中的js都以模块来编写的,那这个应用就是一个模块化的应用。

#### 4.组件化

当应用中的功能都是多组件的方式来编写的,那这个应用就是一个组件化的应用.

### 3.2非单文件组件

一个文件中包含n个组件

#### 1.简单使用

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>基本使用</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root1">
            <hello></hello>
            <hr>
            <h2>{{msg}}</h2>
            <!-- 第三步编写组件标签 -->
            <school></school>
            <hr>
            <!-- 第三步编写组件标签 -->
            <student></student>
        </div>
        <div id="root2">
            <!-- 第三步编写组件标签 -->
            <hello></hello>
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
            //第一步：创建school组件
            const school = Vue.extend({
                //组件定义时，一定不要写el配置项，因为最终所有的组件都要被一个vm管理，由vm决定服务与那个容器
                template:
                `
                <div>
                    <h2>学校名称：{{schoolName}}</h2>
                    <h2>学校地址：{{address}}</h2>
                    <button @click="showName">显示学校名称</button>
                </div>
                `,
                data(){
                    return{
                        schoolName:'中国石油大学',
                        address:'青岛',
                    }
                },
                methods:{
                    showName(){
                        alert(this.schoolName)
                    }
                }
            })
            //第一步：创建student组件
            const student = Vue.extend({
                template:
                `
                <div>
                    <h2>学生名字：{{studentName}}</h2>
                    <h2>年龄：{{age}}</h2>
                </div>
                `,
                data(){
                    return{
                        studentName:'黄智',
                        age:'22'
                    }
                }
            })
            //第一步：创建hello组件
            const hello = Vue.extend({
                template:`
                <div>
                    <h2>{{name}}</h2>
                </div>
                `,
                data(){
                    return{
                        name:"你好！Sir"
                    }
                }
            })
            //第二步注册组件（全局注册）
            Vue.component('hello',hello)
            //创建vm
            const x = new Vue({
                el:'#root1',
                data:{
                    msg:'欢迎！'
                },
                //第二步注册组件（局部注册）
                components:{
                    school,
                    student
                }
        })
            const y = new Vue({
                el:'#root2',
                
        })
        </script>
    </body>
</html>
```

#### 2.几个注意点:

1.关于组件名:

一个单词组成:
第一种写法(首字母小写):school

第二种写法(首字母大写):School

多个单词组成:

第一种写法(kebab-case命名):my-school

第二种写法(CamelCase命名):MySchool（需要Vue脚于架支持)

备注:

(1).组件名尽可能回避HTML中己有的元素名称、例如:h2、H2都不行。

(2).可以使用name配置项指定组件在开发者工具中呈现的名字。

2.关于组件标签:

第一种写法:

```
<school></school>
```

第二种写法:

```
<school/>
```

备注:不用使用脚于架时,

```
<school/>
```

会导致后续组件不能渲染。

3.一个简写方式:

const school = Vue.extend(options）可简写为: const school = options

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>几个注意点</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root">
            <h2>hello,{{msg}}</h2>
            <school></school>
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
        /* //第一种写法
        const school = Vue.extend({
            name:'sky',
            template:`
            <div>
                <h2>{{name}}</h2>
                <h2>{{address}}</h2>
            </div>
            `,
            data(){
                return{
                    name:'中国石油大学',
                    address:'青岛'
                }
            }
        }) */
        //第二种简写
        const school = {
            name:'sky',
            template:`
            <div>
                <h2>{{name}}</h2>
                <h2>{{address}}</h2>
            </div>
            `,
            data(){
                return{
                    name:'中国石油大学',
                    address:'青岛'
                }
            }
        }
        //创建Vue实例
        const x = new Vue({
            el:'#root',
            data:{
                msg:'欢迎学习Vue!'
            },
            components:{
                school
            }
        })
        </script>
    </body>
</html>
```

#### 3.组件嵌套

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>嵌套组件</title>
        <!-- 引入Vue -->
        <script type="text/javascript" src="../js/vue.js"></script>
    </head>
    <body>
        <!-- 准备一个容器 -->
        <div id="root1">
            
        </div>
        <script type="text/javascript">
            Vue.config.productionTip = false
            //创建student组件
            const student = Vue.extend({
                template:
                `
                <div>
                    <h2>学生名字：{{studentName}}</h2>
                    <h2>年龄：{{age}}</h2>
                </div>
                `,
                data(){
                    return{
                        studentName:'黄智',
                        age:'22'
                    }
                }
            })
            //创建school组件
            const school = Vue.extend({
                //组件定义时，一定不要写el配置项，因为最终所有的组件都要被一个vm管理，由vm决定服务与那个容器
                template:
                `
                <div>
                    <h2>学校名称：{{schoolName}}</h2>
                    <h2>学校地址：{{address}}</h2>
                    <button @click="showName">显示学校名称</button>
                    <student/>
                </div>
                `,
                data(){
                    return{
                        schoolName:'中国石油大学',
                        address:'青岛',
                    }
                },
                methods:{
                    showName(){
                        alert(this.schoolName)
                    }
                },
                components:{//局部注册
                    student
                }
            })
            //创建hello组件
            const hello = Vue.extend({
                template:`
                <div>
                    <h2>{{name}}</h2>
                </div>
                `,
                data(){
                    return{
                        name:"你好！Sir"
                    }
                }
            })
            const app = Vue.extend({
                template:`
                <div>
                    <hello/>
                    <school/>
                </div>
                `,
                components:{
                    school,
                    hello
                }
            })
            //创建vm
            const x = new Vue({
                el:'#root1',
                template:`
                <div>
                    <app/>
                </div>
                `,
                data:{
                    msg:'欢迎！'
                },
                //第二步注册组件（局部注册）
                components:{
                    app
                }
        })
        </script>
    </body>
</html>
```

#### 4.component

关于VueComponent:

1.school组件本质是一个名为VueComponent的构选函数，且不是程序员定义的，是Vue.extend生.成的。

2.我们只需要写

```
<school/>
```

或

```
<school></school>
```

,Vue解析时会帮我们创建school组件的实例对象，即vue帮我们执的:new  VueComponent(options).

3.特别注意:每次调用vue.extend，返回的都是一个全新的VueComponent ! ! ! !

4.关于this指向:
(1).组们配置中:
data函数、methods中的函数、watch中的函数、computed中的函数它们的this均是【VueComponent实例对象】.

(2).new vue()南置中:
data函数、methods中的函数、watch中的函数、computed中的函数它们的this均是【Vue实例对象】.

5.VueComponent的实例对象，以后简称vc（也可称之为:组件实例对象）-
Vue的实例对象,以后简称vm。

#### 5.一个重要的内置联系

1.个重要的内置关系: VueComponent. prototype.__proto__ === Vue. prototype

2.为什么要有这个关系:让红件实例对象（vc）可以访问到 Vue原型上的属性、方法。

![Vue与Vuecomponent的关系](Vue与Vuecomponent的关系.png)

### 3.3单文件组件

```vue
<template>
    <!-- 组件的结构 -->
    <div calss="demo">
      <h2>学校名称：{{schoolName}}</h2>
      <h2>学校地址：{{address}}</h2>
      <button @click="showName">显示学校名称</button>
    </div>
</template>
<script>
//组件交互相关代码（数据、方法等等）

export default {
    name:'School',
    data(){
      return{
        schoolName:'中国石油大学',
        address:'青岛',
      }
    },
    methods:{
      showName(){
        alert(this.schoolName)
      }
    }
}
</script>
<style>
/*组件样式*/
.demo{
    background-color: skyblue;
}
</style>

```

## 4.使用Vue脚手架

### 4.1初始化脚手架

#### 1.说明

1.Vue 脚手架是 Vue 官方提供的标准化开发工具（开发平台）。

2.最新的版本是 4.x。

3.文档: https://cli.vuejs.org/zh/

#### 2.具体步骤

第一步（仅第一次执行）：全局安装@vue/cli。

npm install -g @vue/cli

第二步：**切换到你要创建项目的目录**，然后使用命令创建项目

vue create xxxx

第三步：启动项目

npm run serve

备注：

1.如出现下载缓慢请配置 npm 淘宝镜像：npm config set registry

https://registry.npm.taobao.org

2.Vue 脚手架隐藏了所有 webpack 相关的配置，若想查看具体的 webpakc 配置，请执行：vue inspect > output.js

#### 3.模板项目的结构

**├── node_modules**

**├── public**

**│ ├── favicon.ico: 页签图标**

**│ └──** **index.html: 主页面**

**├── src**

**│ ├── assets: 存放静态资源**

**│ │ └── logo.png**

**│ │──** **component: 存放组件**

**│ │ └── HelloWorld.vue**

**│ │──** **App.vue: 汇总所有组件**

**│ │──** **main.js: 入口文件**

**├── .gitignore: git 版本管制忽略的配置**

**├── babel.config.js: babel 的配置文件**

**├── package.json: 应用包配置文件**

**├── README.md: 应用描述文件**

**├── package-lock.json：包版本控制文件**

**├── vue.config.js：配置文件**

#### 4.关于不同版本的Vue:

vue.js与vue.runtime.xxx.js的区别:

(1).vue.js是完整版的Vue。包含:核心功能+模板解析器

(2).vue.runtime.xxx.js是运行版的Vue,只包含:核心功能:没有模板解析器。

因为vue.runtime.xxx.js没有模板解析器，所以不能使用template配置项，需要使用render函数接收到的createElement函数去指定具体内容.

#### 5.vue.config.js配置文件

使用vue inspect >-output.js可以查看到vue脚手架的默认配置。

使川vue.config.js可以对脚手架进行个性化定制，详情见: https://cli.vuejs.org/zh

### 4.2ref属性

1.被用来给元素或子组件注册引用信息(id的替代者)

2.应用在htm1标签上获取的是真实DOM元素，应用在组件标签上是组件实例对象(vc)

3.使用方式:
打标识:

```
<h1 ref="xxx">.....</h1>
```

或

```
<School ref="xxx"></School>
```

获取:this.$refs.xxx

### 4.3props配置项

功能:让组件接收外部传过来的数据

(1).传递数据:

```
<Demo name="xxx"/>
```

(2).接收数据:

第一种方式（只接收）:

```
props:['name']
```

第二种方式（限制类型）:

```
props:{
	name:Number
}
```

第三种方式（限制类型、限制必要性、指定默认值）:

```js
props:{
	name:{
		type:String，//类型
		required:true,//必要性
		default:'老王’//默认值
	}
}
```

备注: props是只读的，Vue底层会监测你对props的修改，如果进行了修改，就会发出警告,若业务需求确实需要修改，那么请复制props的内容到data中一份，然后去修改data中的数据。

### 4.4mixin(混入)

功能:可以把多个组件共用的配置提取成一个混入对象

使用方式:
第一步定义混合,例如:

```
{
	data(){....},
	methods:{.….},
	......
}
```

第二步使用混入。例如:
(1).全局混入:Vue.mixin(xxx)

(2).局部混入:mixins : [ " xxx " ]

### 4.5插件

功能:用于增强vue

本质:包含install方法的一个对象，install的第一个参数是Vue，第二个以后的参数是插件使用者传递的数据。

定义插件:

```
对象.install = function (Vue,options) {
		//1．添加全局过滤器
        vue.filter(.. . .)
        
        // 2．添加全局指令
        Vue.directive(......)
        // 3.配置全局混入(合)
        Vue.mixin(...)
        //4．添加实例方法
        Vue.prototype.$myMethod = function(){...}
        Vue.prototype.$myProperty = XXXX
        }
        使用插件:Vue.use()
```

### 4.6scoped样式

作用:让样式在局部生效。防止冲突.

写法:

```
<style scoped>
```

注:如果没有写lang='less'或者lang='css'则默认为css

npm view xxxx versions查看xxxx插件的所有版本

npm view xxxx version查看xxxx插件的版本

### 4.7总结TodoList案列

1.组件化编码流程:

(1).拆分静态组件:组件要按照功能点拆分，命名不要与html元素冲突。

(2).实现动态组件:考虑好数据的存放位置，数据是一个组件在用，还是一些组件在用:

1).一个组件在用:放在组件自身即可。

2).一些组件在用:放在他们共同的父组件上(状态提升)。

(3).实现交互:从绑定事件开始。

2.props适用于:

(1).父组件==>子组件通信

(2).子组件==>父组件通信（要求父先给子一个函数)3.使用v-model时要切记: v-model绑定的值不能是props传过来的值，因为props是不可以修改的!

4.props传过来的若是对象类型的值，修改对象中的属性时Vue不会报错，但不推荐这样做。

### 4.8webStorage

1.存储内容大小一般支持5MB左右(不同浏览器可能还不一样)

2.浏览器端通过Window.sessionStorage和 Window.localStorage属性来实现本地存储机制。

3.相关API:
1.[ xxxxxStorage.setItem( ' key ' , 'value ' );
该方法接受一个键和值作为参数，会把键值对添加到存储中，如果键名存在，则更新其对应的值。

2.XXXXxStorage-getItem( ' person ' );
该方法接受一个键名作为参数，返回键名对应的值。

3.xxxxxStorage.removeItem( ' key ' ) ;
该方法接受一个键名作为参数，并把该键名从存储中删除。

4.xxxxxStorage.clear()
该方法会清空存储中的所有数据。

4.备注:
1.SessionStorage存储的内容会随着浏览器窗口关闭而消失。

2.LocalStorage存储的内容，需要手动清除才会消失.

3.xxxxxStorage.getItem(xxx)如果xxx对应的value获取不到，那么getltem的返回值是null。

4.JSON.parse(null)的结果依然是null。

### 4.9组件的自定义事件

1.一种组件间通信的方式，适用于:子组件==>父组件

⒉.使用场景∶A是父组件，B是子组件，B想给A传数据，那么就要在A中给B绑定自定义事件（事件的回调在A中)。

3.绑定自定义事件:
	1.第一种方式，在父组件中:

```
<Demo @atguigu="test"/>
```

或

```
<Demo v-on:atguigu="test"/>
```

2.第二种方式，在父组件中:

```js
<Demo ref="demo" />
.. .. ..
mounted(){
	this.$refs.xxx.$on( 'atguigu ' ,this.test)
}
```

​	3.若想让自定义事件只能触发一次，可以使用once修饰符，或$once方法。
4.触发自定义事件:this.$emit( 'atguigu ',数据)

5.解绑自定义事件this.$off( ' atguigu ')

6.组件上也可以绑定原生DOM事件，需要使用native修饰符。

7.注意:通过this..refs.xx. fon('atguigu',回调)绑定自定义事件时，回调要么配置在methods中，要么用箭头函数，否则this指向会出问题!

### 4.10全局事件总线（GlobalEventBus）

1.一种组件间通信的方式，适用于任意组件间通信。

2.安装全局事件总线:

```js
new Vue({
	.....
	beforeCreate() {
		Vue.prototype.$bus = this //安装全局事件总线，$bus就是当前应用的vm},
	......
})
```

3.使用事件总线:

​	1.接收数据:A组件想接收数据，则在A组件中给$bus绑定自定义事件，事件的回调留在A组件自身

```js
methods(){
	demo(data){......}
}
mounted() {
	this.$bus. $on( ' xxxx ' ,this.demo)
}
```

​	2.提供数据:this.$bus.$emit( ' xxxx ',数据)
4.最好在beforeDestroy钩子中，用$off去解绑当前组件所用到的事件。

### 4.11消息订阅与发布（pubsub)

1.一种组件间通信的方式，适用于任意组件间通信。

2.使用步骤:

1.安装pubsub: npm i pubsub-js

2.引入: import pubsub from "pubsub-js'

3.接收数据:A组件想接收数据，则在A组件中订阅消息，订阅的回调留在A组件自身。

```js
methods(){
	demo(data){......}
}
mounted(){}
	this.pid = pubsub.subscribe( 'xxx ',this.demo)//订阅消息
}
```

4.提供数据:pubsub.publish( " xxx" ,数据）

5.最好在beforeDestroy钩子中，用PubSub.unsubscribe(pid)去取消订阅

### 4.12nextTick

1.语法: this.$nextTick(回调函数)

2.作用:在下一次DOM更新结束后执行其指定的回调。

3.什么时候用:当改变数据后，要基于更新后的新DOM进行某些操作时，要在nextTick所指定的回调函数中执行。

### 4.13Vue封装的过渡与动画

1.作用:在插入、更新或移除DOM元素时
在合适的时候给元素添加样式类名。
2.图示:

![动画与过渡](动画与过渡.png)

3.写法:
准备好样式:
	元素进入的样式:

​		1.v-enter:进入的起点
​		2.v-enter-actlve:进入过程中
​		3.v-enter-to:进入的终点

​	元素离开的样式：

​		1.v-leave:离开的起点
​		2.v-leave-actlve:离开过程中
​		3.v-leave-to:离开的终点

2.使用

```
<transition>
```

包表要过度的元素。并配置name属性:



```html
<transition name="hello">
	<h1 v-shou="isshows">你好啊!</h1></transition>
</transition>
```

3.备注:若有多个元素需要过度，则需要使用: 

```
<transition-group>
```

，且每个元素都要指定 key 值，

## 5.Vue中的ajax

### 5.1Vue脚手架配置代理

方法一
在vue.config.js中添加如下配产:

```js
devServer: {
    proxy: 'http://localhost:5000'
  }
```

说明:

1.优点:配置简单，请求资源时直接发给前端(8080)即可。

2缺点:不能配置多个代理。不能灵活的控制请求是否走代理。

3.工作方式:若按照上述配置代理，当请求了前端不存在的资源时，那么该请求会转发给服务器〈优先匹配前端资源)

方法二
编写vue.config.js配置具体代理规则:

```
module.exports = {
  devServer: {
    proxy: {
      '/api1': {//匹配所有以'/api1'开头的请求路径
        target: 'http://localhost:5000',//代理目标的基础路径
        changeOrigin: true
        pathRewrite{'^api1':''}
      },
      '/api2': {//匹配所有以'/api2'开头的请求路径
        target: 'http://localhost:5001',//代理目标的基础路径
        changeOrigin: true
        pathRewrite{'^api2':''}
      }
    }
  }
}
/*
	changeOrigin设置为true是，服务器收到的请求头中的host为：localhost:5000
	changeOrigin设置为true是，服务器收到的请求头中的host为：localhost:8000
	changeOrigin默认值为true
*/
```

说明:
1.优点:可以配置多个代理，且可以灵活的控制请求是否走代理。

⒉.缺点:配置略微繁琐，请求资源时必须加前缀。

### 5.2Vue项目中常用的两个Ajax

5.2.1 axios

通用的Ajax请求库，官方推荐，使用广泛

5.2.2 vue-resource

vue插件库,vue1.x使用广泛,官方已不维护

### 5.3slot插槽

1.作用:让父组件可以向子组件指定位查插入html结构，也是一种组件间通信的方式;适用于父组件==>子组件。

2.分类:默认插槽、具名插槽、作用域插槽

3.使用方式:

​	1.默认插槽：

```Vue
父组件中:
		<Category>
			<div>html结构1</div>
		</Category>
子组件中:
		<template>
			<div>
				<!--定义插艳-->
                <slot>插柑默认内容-.-</slot>
			</div>
		</template>

```

​	2.具名插槽:

```Vue
父组件中:
		<Category>
			<template slot="center">
				<div>html结构1</div>
			</template>
			<template v-slot:footer>
				<div>html结构2</div>
			</template>
		</Category>
子组件中:
		<template>
			<div>
				<--定义插槽-->
				<slot nane="center">插槽默认内容...</slot>
				<slot nane="footer">插艳默认内容...</slot>
			</div>
		</template>

```

​	3.作用域插槽

​		1.理解:数据在组件的自身，但根据数据生成的结构需要组件的使用者来决			定。(games数据在Category组件中，但使用数据所遍历出来的结构由App			组件决定)

​		2.具体编码:

```Vue
父组件中:
		<Category>
			<template scope-"scopeData">
				<! --生成的是ul列表-->
				<ul>
					<li v-for="g in scopeData.games" :key="g">{{g}}</li>
				</ul>
			</template>
		</Category>
		<Category>
			<template slot-scope="scopeData">
				<!--生成的是h4标题-->
				<h4 v-for="g in scopeData.games" :key=“g">{{g}}</h4>
			</template>
		</Category>
子组性中:
		<template>
			<div>
                <slot :games="games"></slot>
            </div>
		</template>
		<script>
			export default{
                name:"Category",
                props:['title'],
                //教据在子组件自身
                data(){
                    return{
					games:[ '红色警戒","穿越火线","劲舞团","超级玛丽"]
				}
			}，
		}
		</script>

```

### 5.4Vuex

![](D:\study\blog\source\_posts\image\vuex.png)

#### 1.概念

​	在Vue中实现集中式状态〔数据)管理的一个Vue插件，对vue应用中多个组件的共享状态进行集中式的管理(读/写)，也是一种组件问通信的方式,且适用于任意组件间通信。

#### 2.何时使用?

​	多个组件需要共亨数据时

#### 3.搭建vuex环境

​	1.创建文件：src/store/index.js

```js
//引入vue核心库
import vue from 'vue'
//引入vuex
import vuex from 'vuex'
//应用Vuex插件
Vue.use(Vuex)
//准备actions对象—响应组件中用户的动作
const actions = {}
//准备mutations对象—修改state中的数据
const mutations = {}
/准备state对象--保存具体的教据
const state = {}

//创建并暴露store
export default new Vuex.Store({
	actions,
	mutations,
	state
})

```

​	2.在main.js中创建vm时传入store配置项

```vue
......
//引入store
import store fron './store'
......
//创建vm
new Vue({
	el:'#app',
	render: h -> h(App),
	store
})

```

#### 4.基本使用

​	1.初始化数据、配置actions、配置mutations、操作文件store.js

```js
//引Vue核心库
import vue from 'vue'
//引Vuex
import vuex from "vuex' 
//引用Vuex
Vue.use(Vuex)

const actions = {
	//响应组件中加的动作
	jia(context,value){
		//console.log('actions中的a被调用了',miniStore,value)
		context.commit("JIA",value)
	},
}

const mutations = {
	//执行加
	JIA(state,value){
		//console.log("mutations中的JIA被调用了",state ,value)
		state.sum += value
	}
}
/初始化数据
const state = {
	sum:
}
//创建并暴露store
export default new Vuex.Store({
	actions,
	mutations,
	state
})

```

​	2.组件中读取vuex中的数据:$store.state.sum

​	3.组件中修改vuex中的数据:$store.dispatch("action中的方法名 '',数据)]或$store.commit( 'mutations中的方法名' ,数据)

​	备注:若没有网络请求或其他业务逻辑，组件中也可以越过actions，即不写dispatch，直按编写commit

#### 5.getters的使用

​	1.概念：当state中的数据需要加工后再使用时，可以使用getters加工

​	2.在store.js中追加getters配置

```js
......
const getters = {
	bigSum(){
		return state.sum * 10
	}
}

//创建并暴露store
export defualt new Vuex.Store({
	.......
	getters
})
```

​	3.组件中读取数据：$store.getters.bigSum

#### 6.四个map方法的使用

​	1.mapState方法：用于帮助我们映射state中的数据为计算属性

```vue
computed:{
	//借助mapState生成计算属性，从state中获取数据（对象写法）
    ...mapState({sum:'sum',school:'school',subject:'subject'})

    //借助mapState生成计算属性，从state中获取数据（数组写法）
    ...mapState(['sum','school','subject']),
}
```

​	2.mapGetters方法:用于帮助我们映射getters中的数据为计算属性

```Vue
computed:{
	//借助mapGetters生成计算属性，从Getters中获取数据（对象写法）
    ...mapGetters({bigSum:'bigSum'})

    //借助mapGetters生成计算属性，从Getters中获取数据（数组写法）
    ...mapGetters(['bigSum'])
}
```

​	3.mapActions方法:用于帮助我们生成与actions对话的方法，即包含$store.dispatch('xxx')的函数

```Vue
methods:{
	//借助mapActions生成对应的方法，方法中会调用commit去联系actions（对象写法）
    ...mapActions({incrementOdd:'jiaodd',incrementWait:'jiawait'})

    //借助mapActions生成对应的方法，方法中会调用commit去联系actions（数组写法）
    ...mapActions(['jiaodd','jiawait'])
}
```

​	4.mapMutations方法:用于帮助我们生成与mutations对话的方法，即包含$store.commit('xxx')的函数

```vue
methods:{
	//借助mapMutations生成对应的方法，方法中会调用dispatch去联系mutations（对象写法）
    ...mapMutations({increment:'JIA',decrement:'JIAN'}),

    //借助mapMutations生成对应的方法，方法中会调用dispatch去联系mutations（数组写法）
    ...mapMutations(['JIA','JIAN']),
}
```

​	备注:mapActions与mapMutations使用时，若需要传递参数需要：在模板中绑定好事件时传递好参数，否则参数是事件对象.

### 5.5路由

​	1.理解：一个路由（route)就是一组映射关系（key-value），多个路由需要路由器（router）进行管理.

​	2.前端路由：key是路径，value是组件.

#### 1.基本使用

​	1.安装vue-router，命令：npm i vue-router

​	2.应用插件：Vue.use(VueRouter)

​	3.编写router配置项:

```js
//引入VueRouter
import VueRouter from 'vue-router'
//引入Luyou组件
import About from '../components/About'
import Home from '../components/Home'

//创建router实例对象，去管理一组一组的路由规则
const router = new VueRouter({
	routes :[
		{
			path:'/about',
			component:About
		},
		{
			path:'/home',
			component:Home
		}
	]
})
//暴露router
export default router

```

​	4.实现切换(active-class可配置高亮样式)

```vue
<router-link active-class="active" to="/about">About</router-link>
```

​	5.指定展示位置

```vue
<router-wiew></router-view>
```

#### 2.几个注意点

​	1.路由组件通常存放在pages文件夹，一般组件通常存放在components文件夹。

​	2.通过切换，“隐藏”了的路由组件，默认是被销毁掉的，需要的时候再去挂载。

​	3.每个组件都有自己的$route属性，里面存储着自己的路由信息。

​	4.整个应用只有一个router，可以通过组件的$router属性获取到。

#### 3.多级路由（多级路由）

​	1.配置路由规则，使用children配置项:

```js
routes:[
	{
		path:'/about',
		component:About,
	},
	{
		path:'home',
		conmonent: Home ,
		children:[//通过children配置子级路由
			{
				path:'news',//此论一定不要写:/news
				component:News
			},
			{
				path:'message',//此处一定不要写。/message
				component:Message
			}
		}
	}
]

```

​	2.跳转（要写完整路径):

```vue
<router-link to="/home/news" >Nevs</router-link>
```

#### 4.路由的query参数

​	1.传递参数

```js
<!--跳转并搓带query参数，to的字符牢写法-->
<router-link :to="/hone/message/detail?id=666&title=你好"”>跳转</ router-link>
<!--跳转并携带query参数，to的对象写法-->
<router-link
	:to="{
		path:'/home/message/detail',
		query:{
			id :666,
			title:'你好'
		}
	}”
>跳转</router-link>
```

#### 5.命名路由

​	1.作用：可以简化路由的跳转

​	2.如何使用

​		1.给路由命名

```js
{
	path :"/demo",
	conponent:Demo,
	children:[
		{
			path:"test',
			component:Test,
			children:[
				{
					name:'hello'//给路由命名
					path:'welcone',
					component :Hello,
				}
			]
		}
	]
}

```

​		2.简化跳转

```js
<!--简化前，需要写完整的路径-->
<router-link to="/demo/test/welcome">跳转</router-link>

<!--简化后，直接通过名字跳转-->
<router-link :to="{name:'hello'}">跳转</router-link>

<!--简化写法配合传递参数-->
<router-1ink
	:to="{
		name:'hello',
		query:{
			id:566,
			title:'你好'
		}
	}”
>跳转</router-link>

```

#### 6.路由的params参数

​	1.配置路由，声明接收params参数

```js
{
	path:'/home',
	component:Home,
	children:[
		{
			path:'news',
			component:News
		},
		{
			conponent:Message,
			children:[
				{
					name : 'xiangqing",
					path : 'detail/:id/:title',//使用占位符声明接枚params参数			 component:Detail
				}
			]
		}
	]
}
```

​	2.传递参数

```js
<!--跳转并携带params参数.to的字符串写法-->
<router-link :to-"/home/message/detail/666/你好">跳转</router-link>

<!--跳转并挠带params参数。to的对象写法-->
<router-link
	:to="{
		nanme : 'xiangqing',
         parans :{
			id:665,
			title:'你好'
         }
	}”
>跳转</router-link>

```

**特别注意：路由携带params参数是，若使用to的对象写法，则不能使用path配置项，必须使用name配置！**

​	3.接收参数

```js
$route.params.id
$route.params.title
```

#### 路由的props配置

​	作用：让路由组件更加方便的接收到参数

```js
{
	name:"xiangqing",
	path:'detail/:id',
	component:Detail,
//第一种写法：props值为对绿，该对象中所有的key-value的组合最终都会通过props传给Detail组件
//props:{a:900}

//第二种写法。props值为布尔值，布尔值为true，则把路由收到的所有params参数通过props情给Detail组他
//props:true

//第三种写法:props值为函数，该函数返回的对象中每一组key-value都会通过	props传给Detail组件
	props(route){
		return {
			id:route.query.id,
			title : route-query.title
		}
	}
}
```

#### 7.`<router-link>`的replace属性

​	1.作用:控制路由跳转时操怍浏览器历史记录的模式

​	⒉浏览器的历史记录有两种写入方式:分别为push和replace, push是追加历史记录，replacel是替换当前记录路由跳转时候默认为push

​	3.如何开启replace模式:

```
<router-link replace .....  >News</router-link>
```



#### 8.编程式路由导航

​	1.作用：不借用

```
<router-link>
```

实现路由跳转，让路由跳转更加灵活

​	2.具体编码：

```js
//$router的两个API
this.$router-push({
	name:'xiangqine',
		params:{
			id:xxx,
			title:×xx
		}
})
this.$router.replace({
	name:'xiangainge',
		params:{
			id:xxx,
			title:xXX
		}
})
this.$router.forward()//前进
this.$router.back()//后退
this.$router.go() //可前进可后退

```

#### 9.缓存路由组件

​	1.作用：让不展示的路由组件保持挂载，不被销毁.

​	2.具体编码

```js
<!-- 缓存多个路由组件 -->
<!-- <keep-alive :include="['News','message']"> -->
      
<!-- 缓存一个路由组件 -->
<keep-alive include="News"> 
	<router-view/>
</keep-alive>
```

#### 10.两个新的生命周期钩子

1.作用：路由组件所独有的两个钩子，用于捕获路由组件的激活状态.

2.具体名字：

​	1.activated路由组件被激活时候触发

​	2.deactivated路由组件失活时触发

#### 11.路由守卫

1.作用：对路由进行权限控制

2.分类：全局守卫、独享守卫、组件内守卫

3.全局守卫

```js
//全局前置路由守卫----初始化的时候被调用、每次路由切换之前被调用
 router.beforeEach((to,from,next)=>{
    console.log('前置路由守卫',to,from)
    if(to.meta.idAuth){
      if(localStorage.getItem('school') === 'upc'){
        next()
      }else{
        alert('没有权限！')
      }
    }else{
      next()
    }
 })

 //全局后置路由守卫----初始化的时候被调用、每次路由切换之后被调用
 router.afterEach((to,from)=>{
  console.log('后置路由守卫',to,from)
  document.title = to.meta.title || 'sky系统'
 })
```

4.独享路由守卫

```js
beforeEnter(to,from,next){
    if(to.meta.idAuth){
           if(localStorage.getItem('school')==='upc'){
                next()
              }else{
                alert('没有权限！')
              }
            }else{
              next()
            }
          }
```

5.组件内守卫

```js
//进入守卫，通过路由的规则，进入该组件是被调用
beforeRouterEnter(to, from, next){

},
 //离开守卫，通过路由的规则，离开该组件是被调用
beforeRouterEnter(to, from, next){

},
```

#### 12.路由器的两种工作模式

1.对于一个url来说，什么是hash值?——#及其后面的内容就是hash值。

2.hash值不会包含在HTTP请求中，即: hash值不会带给服务器。

3.hash模式:

​	1.地址中永远带着#号，不美观。

​	2若以后将地址通过第三方手机app分享，若app校验严格，则地址会被标记为不合法

​	3.兼容性较好。

4.history模式:

​	1.地址干净，美观。

​	2.兼容性和hash模式相比略差。

​	3.应用部署上线时需要后端人员支持，解决刷新页面服务端404的问题。