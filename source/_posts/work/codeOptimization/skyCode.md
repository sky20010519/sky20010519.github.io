---
title: 工作中用到的代码
categories:
  - js
tags:
  - js
abbrlink: d59ddab2
date: 2025-01-02 18:12:38
---

**本文讲述了平时工作遇见的一些问题以及解决的代码**

<!-- more -->

# 获取前几天日期

代码优化之前 

```js
const dataTime = new Date();
    const year = dataTime.getFullYear()
    const month = dataTime.getMonth() + 1
    const day = dataTime.getDate()
    var showDay
    var showMonth
    var showYear
    const nonLeapYearMonthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    const leapYearMonthDays = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    // debugger;
    if (day - 7 < 0) {
        var days = 7 - day;
        if (month == 3) {
            if ((year % 4 === 0 && year % 100 !== 0) || year % 400 === 0) {
                showYear = year
                showMonth = month - 1
                showDay = leapYearMonthDays[showMonth-1] - days
            } else {
                showYear = year
                showMonth = month - 1
                showDay = nonLeapYearMonthDays[showMonth-1] - days
            }
        } else if (month == 1) {
            showYear = year - 1
            showMonth = 12
            showDay = leapYearMonthDays[showMonth-1] - days
        } else {
            showYear = year
            showMonth = month - 1
            showDay = leapYearMonthDays[showMonth-1] - days
        }
    } else if(day - 7 == 0){
        if (month == 3) {
            if ((year % 4 === 0 && year % 100 !== 0) || year % 400 === 0) {
                showYear = year
                showMonth = month - 1
                showDay = leapYearMonthDays[showMonth-1]
            } else {
                showYear = year
                showMonth = month - 1
                showDay = nonLeapYearMonthDays[showMonth-1]
            }
        } else if (month == 1) {
            showYear = year - 1
            showMonth = 12
            showDay = leapYearMonthDays[showMonth-1]
        } else {
            showYear = year
            showMonth = month - 1
            showDay = leapYearMonthDays[showMonth-1]
        }
    }else{
        showYear = year
        showMonth = month
        showDay = day - 7
    }
    const showDay1 = showDay < 10 ? "0" + showDay : showDay
    const showMonth1 = showMonth < 10 ? "0" + showMonth : showMonth
    const showDay2 = day < 10 ? "0" + day : day
    const showMonth2 = month < 10 ? "0" + month : month
    const a1 = `${showYear}-${showMonth1}-${showDay1}`
    const a2 = `${year}-${showMonth2}-${showDay2}`
```

代码优化后

```js
// 封装计算指定日期往前推指定天数后的日期的函数
function getPreviousDate(date, days){
    const newDate = new Date(date);
    newDate.setDate(newDate.getDate() - days);
    return newDate;
}
// 日期格式化函数
function formatDate(day, month, year) {
    const formattedDay = day < 10 ? "0" + day : day;
    const formattedMonth = month < 10 ? "0" + month : month;
    return `${year}-${formattedMonth}-${formattedDay}`;
}
// 获取当前日期
    const dataTime = new Date();
    const year = dataTime.getFullYear();
    const month = dataTime.getMonth() + 1;
    const day = dataTime.getDate();
    // 计算 7 天前的日期
    const previousDate = getPreviousDate(dataTime, 7);
    const showYear = previousDate.getFullYear();
    const showMonth = previousDate.getMonth() + 1;
    const showDay = previousDate.getDate();
    // 格式化日期
    dateRange.value[0] = formatDate(showDay, showMonth, showYear);
    dateRange.value[1] = formatDate(day, month, year);
```

# 用div写切换按钮的样式

```html
<div class="security-show-right-top-button-item" v-for="(item, index) in teamScoreData.sortIndex"
                    :key="index" :class="{ actived: index === teamScoreData.initialSequence }"
                    @click="handleChangeIndex(index)">
                    <div>{{ item.name }}</div>
                </div>
```

```js
const teamScoreData = reactive({
    initialSequence: 0,
    sortIndex: [
        { name: '升序', value: "" },
        { name: '降序', value: "" },
    ],
    tableData: [
        { name: "队伍1", scope: 99.86 },
        { name: "队伍2", scope: 99.86 },
        { name: "队伍3", scope: 99.86 },
        { name: "队伍4", scope: 99.86 },
        { name: "队伍5", scope: 99.86 },
        { name: "队伍6", scope: 99.86 },
        { name: "队伍7", scope: 99.86 },
        { name: "队伍8", scope: 99.86 },
        { name: "队伍9", scope: 99.86 },
        { name: "队伍10", scope: 99.86 },
    ]
})
```

```css
.security-show-right-top-button-item {
        text-align: center;
        @include set-size(width,60px);
        @include set-fontsize(12px);
        padding: 8px 10px;
        border-radius: 4px;
        color: #c0c4cc;
        cursor: pointer;
    }

    .security-show-right-top-button-item.actived {
        background: rgba(0, 101, 255, 1);
        @include set-fontsize(12px);
        padding: 8px 10px;
        border-radius: 4px;
        color: #fff;
        cursor: pointer;
    }
```

# 前端页面导出

使用xlsx.js库

先安装xlsx.js

```properties
npm install xlsx
```

在需要导出的页面进行引用

```js
import * as XLSX from 'xlsx'
```

实例代码

```js
function handleExport(){
    let exportList = [
        ['序号', '部门名称', 
        '甲方项目','甲方项目','甲方项目','甲方项目','甲方项目', '甲方项目', '甲方项目', 
        '乙方项目','乙方项目','乙方项目','乙方项目','乙方项目', '乙方项目', '乙方项目',],
        ['','',
        '应查项目数','现场检查项目数','现场检查覆盖率','线上检查项目数','线上检查覆盖率','总检查项目数','总覆盖率',
        '应查项目数','现场检查项目数','现场检查覆盖率','线上检查项目数','线上检查覆盖率','总检查项目数','总覆盖率',
        ]
    ];

    //生成数据行
    dataList.value.forEach((item,index)=>{
        let list = [
            index + 1,
            item.belongCompanyName,
            item.jiafangTotalNum,
            item.jiafangPatrolNum,
            item.jiafangPatrolCoverageRate,
            item.jiafangCheckNum,
            item.jiafangCoverageRate,
            item.jiafangTotalCheckNum,
            item.jiafangTotalCoverageRate,
            item.yifangTotalNum,
            item.yifangPatrolNum,
            item.yifangPatrolCoverageRate,
            item.yifangCheckNum,
            item.yifangCoverageRate,
            item.yifangTotalCheckNum,
            item.yifangTotalCoverageRate,
        ]
        exportList.push(list)
    })

    // 创建工作表
    const ws = XLSX.utils.aoa_to_sheet([]);

    //手动添加表头数据
    XLSX.utils.sheet_add_aoa(ws, exportList.slice(0,2), { origin: 'A1'})//表示exportList的前两维数组为表头从表的A1开始写
    XLSX.utils.sheet_add_aoa(ws, exportList.slice(2), { origin: 'A3'})//表示exportList的第3维数组开始的表格数据从A3开始写

    // 合并单元格实现多级表头其中s表示开始，e表示结束，r表示行，c表示列
    ws['!merges'] = [
        { s: { r: 0, c: 0 }, e: { r: 1, c: 0 } }, // 合并第一列第 1 - 2 行
        { s: { r: 0, c: 1 }, e: { r: 1, c: 1 } }, // 合并第二列第 1 - 2 行
        { s: { r: 0, c: 2 }, e: { r: 0, c: 8 } }, // 合并第一行第 3 - 9 行
        { s: { r: 0, c: 9 }, e: { r: 0, c: 15 } }, // 合并第一行第 10 - 16 行
    ];

    // 创建工作簿
    const wb = XLSX.utils.book_new();
    // 添加工作表
    XLSX.utils.book_append_sheet(wb, ws, 'result');

    // 写入数据
    const wbout = XLSX.write(wb, {
        bookType: 'xlsx',
        bookSST: true,
        type: 'array'
    });

    // 创建下载链接
    let url = window.URL.createObjectURL(new Blob([wbout]));
    let link = document.createElement('a');
    link.style.display = 'none';
    link.href = url;
    link.setAttribute('download',"非正式人员-项目检查统计" + new Date().getTime() + '.xlsx');
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link); // 下载完成移除元素
    window.URL.revokeObjectURL(url); // 释放掉 blob 对象
}
```

抽象提取公共方法导出xlxs、csv、txt

```js
/**
 * 导出文件
 * @param {Array} exportList 导出数据
 * @param {String} fileName 导出文件名
 * @param {String} fileType 导出文件类型，支持 'xlsx', 'txt', 'csv'
 */
export function exportFile(exportList, fileName, fileType = 'xlsx') {
  // 提取创建下载链接并触发下载的通用逻辑
  const createAndTriggerDownload = (url, finalFileName) => {
    const link = document.createElement("a");
    link.style.display = "none";
    link.href = url;
    link.setAttribute("download", finalFileName);
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  if (fileType === 'xlsx') {
    const ws = XLSX.utils.json_to_sheet(exportList);
    const wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, "result");
    const wbout = XLSX.write(wb, {
      bookType: "xlsx",
      bookSST: true,
      type: "array",
    });
    const blob = new Blob([wbout]);
    const url = window.URL.createObjectURL(blob);
    const finalFileName = `${fileName}${new Date().getTime()}.xlsx`;
    createAndTriggerDownload(url, finalFileName);
    window.URL.revokeObjectURL(url);
  } else if (fileType === 'txt' || fileType === 'csv') {
    // 提取处理每行数据的逻辑
    const processRow = (row) => {
      return Object.values(row).map(value => {
        if (typeof value === 'string' && value.includes(',')) {
          return `"${value}"`;
        }
        return value;
      }).join(fileType === 'csv' ? ',' : '\t');
    };

    let csvContent = "data:text/csv;charset=utf-8,";
    const rows = exportList.map(processRow);
    csvContent += rows.join('\n');

    const encodedUri = encodeURI(csvContent);
    const finalFileName = `${fileName}${new Date().getTime()}.${fileType}`;
    createAndTriggerDownload(encodedUri, finalFileName);
  }
}
```



# ui中的字体样式

看到公司ui设计图中的字体样式，不能直接复制粘贴，因为本项目中不一定有样式中的字体包，需要我们在项目中引用字体包

首先要获取字体包可以选择和公司ui要或者网上直接下载

![image-20250210171206872](image-20250210171206872)

下载完成在对应的js页面进行引用

```css
@font-face {
    font-family: "YouSheBiaoTiHei";
    src: url("@/assets/font/YouSheBiaoTiHei.ttf");
}
```

然后在下面使用该字体

```css
.home-main-company1-name {
        width: 72px;
        height: 36px;
        font-family: "PangMenZhengDao";
        font-weight: 400;
        font-size: 18px;
        color: #FFFFFF;
        line-height: 18px;
        text-shadow: 0px 2px 1px #002D6C;
        text-align: center;
        font-style: normal;
        text-transform: none;
    }
```

# 鼠标悬浮显示内容

```html
<div v-for="(company, index) in homeCompany.companyList" :key="index"
            :class="['home-main-company' + (index + 1), index < 4 ? 'bg' : 'bgs']" @mouseenter="showTooltip(index)"
            @mouseleave="hideTooltip(index)">
            <div class="home-main-company1-num">{{ company.num1 }}</div>
            <div class="home-main-company1-num">{{ company.num2 }}</div>
            <div class="home-main-company1-name">{{ company.name }}</div>
            <!-- 悬浮显示的文本框 -->
            <div class="tooltip" :style="{ display: tooltipIndex === index ? 'block' : 'none' }">
                <!-- 这里可以显示更多详细信息，例如公司简介等 -->
                <div class="tooltip-name">{{ company.name }}</div>
                <div class="tooltip-num">收付实现制利润总额：<span>{{ company.num1 }}</span></div>
                <div class="tooltip-num">权责发生制利润总额：<span>{{ company.num1 }}</span></div>
            </div>
        </div>
```

```js
import { reactive, ref } from 'vue';

const homeCompany = reactive({
    companyList: [
        {
            name: '城市照明公司',
            num1: "585万",
            num2: "900万"
        }
});

// 用于记录当前悬浮的公司索引
const tooltipIndex = ref(-1);

// 鼠标进入时显示文本框
const showTooltip = (index) => {
    tooltipIndex.value = index;
};

// 鼠标离开时隐藏文本框
const hideTooltip = () => {
    tooltipIndex.value = -1;
};
```

```css
// 悬浮显示的文本框样式
    .tooltip {
        position: absolute;
        left: 100%;
        /* 显示在右侧 */
        top: 50%;
        transform: translateY(-50%);
        height: 120;
        background: url("@/assets/home/tooltip.png") no-repeat center / 100% 100%;
        border: 1px solid;
        border-image: linear-gradient(180deg, rgba(22, 120, 254, 1), rgba(22, 120, 254, 0)) 1 1;
        padding: 10px;
        border-radius: 5px;
        width: 203px;
        z-index: 10;

        .tooltip-name {
            width: 96px;
            height: 16px;
            font-family: 'PangMenZhengDao';
            font-weight: 400;
            font-size: 16px;
            color: #FFFFFF;
            line-height: 16px;
            text-align: left;
            font-style: normal;
            text-transform: none;
            margin-top: 5px;
            margin-bottom: 30px;
        }

        .tooltip-num {
            font-family: 'SourceHanSansCN-Regular';
            font-weight: 400;
            font-size: 12px;
            color: #C0C4CC;
            line-height: 14px;
            text-align: left;
            font-style: normal;
            text-transform: none;
            margin-top: 10px;
        }

        .tooltip-num span {
            width: 51px;
            height: 21px;
            font-family: 'YouSheBiaoTiHei';
            font-weight: 400;
            font-size: 16px;
            color: #00FFFF;
            line-height: 19px;
            text-align: left;
            font-style: normal;
            text-transform: none;
        }
    }
```

# vue3获取全局变量

在main.js入口文件中

```js
const app = createApp(App)
app.config.globalProperties.sss = { size: 'small', zIndex: 3000 }
```

在vue组件中

```js
import { getCurrentInstance } from 'vue';
const {proxy} = getCurrentInstance()
console.log(proxy.sss)
```

![image-20250225093414839](image-20250225093414839.png)

# js控制全局样式插入和删除

```js
const globalStyleElement = ref(null);
function handle2() {
    const styleElement = document.createElement('style');
    // 定义全局样式
    const globalStyles = `
      /* 这里可以添加你想要的全局样式 */
      .el-date-picker__header{
        display:none!important
        }
    `;
    // 将样式内容添加到 style 元素中
    styleElement.textContent = globalStyles;
    // 将 style 元素插入到 head 标签中
    document.head.appendChild(styleElement);
    // 保存 style 元素的引用
    globalStyleElement.value = styleElement;
}
function handle1() {
    if (globalStyleElement.value) {
        // 从 head 标签中移除 style 元素
        document.head.removeChild(globalStyleElement.value);
        // 清空引用
        globalStyleElement.value = null;
    }
}
```

# vue3父子组件之间的传递

父组件

```

```

# elmentplus表格的设置

## 表头和表格字体设置

```scss
// 表头字体样式
            :deep(.el-table__header th) {
                font-size: 18px;
            }

            // 表格主体字体样式
            :deep(.el-table__body td) {
                font-size: 16px;
                font-weight: bold;
            }
```

## 取消表格高亮

取消单行悬浮高光

```scss
:deep(.el-table)tbody tr:hover>td {
                background-color: unset !important
            }
```

多行合并取消悬浮高光

```scss
:deep(.el-table)tbody tr {
                pointer-events: none;
            }
```

常用样式ERP

```scss
:deep(.el-input__wrapper) {
        background-color: #427CD4;
    }

    :deep(.el-table--default) {
        font-size: 14px;
    }

    :deep(.el-dialog) {
        --el-dialog-bg-color: #3456a1
    }

    :deep(.el-dialog__title) {
        color: #ffffff;
    }

    :deep(.el-select__wrapper) {
        background-color: #427CD4;
    }

    :deep(.el-select__placeholder) {
        color: #ffffff;
    }

    :deep(.el-input__inner) {
        color: #ffffff;
    }

    :deep(.pagination-container) {
        background: transparent;
    }

    :deep(.el-pagination__total) {
        color: #ffffff;
    }

    :deep(.el-pagination__jump) {
        color: #ffffff;
    }

    :deep(.el-pagination.is-background .el-pager li.is-active) {
        border-radius: 20px;
    }

    :deep(.el-date-editor .el-range-input) {
        color: #ffffff;
    }

    :deep(.el-date-editor .el-range-separator) {
        color: #ffffff;
    }

    :deep(.el-table .el-table__header-wrapper th, .el-table .el-table__fixed-header-wrapper th) {
        background-color: #1A6EF4 !important;
        color: #ffffff;
        font-family: Microsoft YaHei;
        font-size: 14px;
        font-weight: 400;
        line-height: 18.48px;
        border: 1px solid #1D469D;
    }

    :deep(.el-table)tr:nth-child(odd) {
        background-color: #3358a7;
        color: #ffffff;
        border: 1px solid #1D469D;
    }

    :deep(.el-table__header-wrapper) {
        // height: 36px;
    }

    :deep(.el-table__body-wrapper) {
        max-height: 870px;
        background: royalblue;
    }

    :deep(.el-table)tr:nth-child(even) {
        background-color: #3668c3;
        color: #ffffff;
        border: 1px solid #1D469D;
    }

    :deep(.el-table)tbody tr:hover>td {
        background-color: #1A6EF4 !important;
    }

    :deep(.el-table__body tr.current-row>td.el-table__cell) {
        background-color: transparent !important;
    }

    :deep(.el-scrollbar__thumb) {
        background-color: #409eff;
    }

    :deep(.el-scrollbar__bar.is-horizontal) {
        height: 20px;
    }
```



## 合并行

加上:span-method="objectSpanMethod"

```vue
<el-table :data="tableData" border style="width: 100%" :span-method="objectSpanMethod">
```

然后处理

```js
const mergeObj = {}
const mergeArr = ['tmonth', 'tsupplier', "tsupplierType", "tdeductionType",]//添加需要合并的行
mergeArr.forEach((key) => {
            let count = 0; // 用来记录需要合并行的起始位置
            mergeObj[key] = []; // 记录每一列的合并信息
            data.value.forEach((item, index) => {
                // index == 0表示数据为第一行，直接 push 一个 1
                if (index === 0) {
                    mergeObj[key].push(1);
                } else {
                    // 判断当前行是否与上一行其值相等 如果相等 在 count 记录的位置其值 +1 表示当前行需要合并 并push 一个 0 作为占位
                    if (item[key] === data.value[index - 1][key]) {
                        mergeObj[key][count] += 1;
                        mergeObj[key].push(0);
                    } else {
                        // 如果当前行和上一行其值不相等 
                        count = index; // 记录当前位置 
                        mergeObj[key].push(1); // 重新push 一个 1
                    }
                }
            })
        })
function objectSpanMethod({ column, rowIndex }) {
    // 排除汇总行的合并处理
    if (rowIndex === tableData.value.length - 1) {
        return [1, 1];
    }
    // 判断列的属性
    if (mergeArr.indexOf(column.property) !== -1) {
        // 判断其值是不是为0 
        if (mergeObj[column.property][rowIndex]) {
            return [mergeObj[column.property][rowIndex], 1]
        } else {
            // 如果为0则为需要合并的行
            return [0, 0];
        }
    }
}

```

## 表格最后一行加上总和

用计算属性先算到需要求和的数据和插入最后一行数据

```js
const totalAmount = computed(()=>{
	return data.value.reduce((sum,item)=>{
		return sum + parseFloat(item.tamout || 0) * 10000;
	},0) / 10000
})
const tableData = computed(()=>{
    const newData = [...data.value];
    newData.push({
        tmonth: '总计',
        tsupplier: '',
        tsupplierType: '',
        tdeductionType: '',
        tmaterialName: '',
        tnumber: '',
        tunitPrice: '',
        tamount: totalAmount.value,
        tsettlement: ''
    });
    return newData
})
```

在表格外部加上div样式

```scss
.fixed-footer-table {
            height: 100%;
            display: flex;
            flex-direction: column;
    // 表格主体样式
            :deep(.el-table__body-wrapper) {
                flex: 1;
                overflow-y: auto;
            }
    // 最后一行固定样式
            :deep(.el-table__body tr:last-child) {
                position: sticky;
                bottom: 0;
                background-color: white;
                z-index: 1;
            }
}
```

# 常用的js代码

## 变量的赋值

交换变量

```js
let a = 1, b = 2;
[a, b] = [b, a];
// Result: a = 2, b = 1
```

对象的解构

```js
const { name, age } = { name: 'John', age: 23 };
// Result: name = 'John', age = 23
```

快速克隆对象

```js
const originalObj = { name: 'John', age: 24 };
const clonedObj = { ...originalObj };
// Result: clonedObj = { name: 'John', age: 24 }
// Modifying clonedObj won't affect originalObj
```

合并对象

```js
const obj1 = { name: 'John' };
const obj2 = { age: 22 };
const mergedObj = { ...obj1, ...obj2 };
// Result: mergedObj = { name: 'John', age: 22 }
```

合并对象变得更加顺畅。请记住，如果有重叠，后面的属性将覆盖前面的属性。

## 消除重复数组值

```js
const arr = [1, 2, 2, 3, 4, 4, 5];
const unique = [...new Set(arr)];
// Result: unique = [1, 2, 3, 4, 5]
```

## 转化数组

```js
const nodesArray = [ ...document.querySelectorAll('div') ];
```

使用扩展运算符将 NodeList 转换为数组，释放数组方法的强大功能。

## 数组的方法

### push()

功能: 在数组**最后一位**添加一个或多个元素,并返回新数组的长度,改变原数组.(添加多个元素用逗号隔开)

```js
 var arr = [1, 2, "c"];
 var rel = arr.push("A", "B");
 console.log(arr); // [1, 2, "c", "A", "B"]
 console.log(rel); //  5  (数组长度)

```

### pop()

功能：删除数组的最后一位，并且**返回删除的数据**，会改变原来的数组。(该方法不接受参数,且每次只能删除最后一个)

```js
   var arr = [1, 2, "c"];
   var rel = arr.pop();
   console.log(arr); // [1, 2]
   console.log(rel); // c

```

### splice()

功能：向数组中添加，或从数组删除，或替换数组中的元素，然后返回被删除/替换的元素所组成的数组。可以实现数组的增删改；

语法:arrayObject.splice(index,howmany,item1,…,itemX)

|    **参数**     |                           **描述**                           |
| :-------------: | :----------------------------------------------------------: |
|      index      | 必需。整数，规定添加/删除项目的位置（元素下标），使用负数可从数组结尾处规定位置。 |
|     howmany     |    必需。要删除的项目数量。如果设置为 0，则不会删除项目。    |
| item1, …, itemX |                  可选。向数组添加的新项目。                  |

例，删除arr()中第三个元素并添加 ”add1“ "add2"元素

```js
 var arr = ["a", "b", "c", 2, 3, 6];
 var rel = arr.splice(2, 1, "add1", "add2");
 console.log(arr);   //原数组
 console.log(rel);	//新数组 

```

![image-20250306160750529](image-20250306160750529.png)

### slice()

功能： 裁切指定位置的数组，返回值为被裁切的元素形成的新数组 ，不改变原数组
同concat() 方法 slice() 如果不传参数,会使用默认值,得到一个与原数组元素相同的新数组 (复制数组)

语法： arr[].slice(startIndex,endIndex)

|                             参数                             |                     描述                     |
| :----------------------------------------------------------: | :------------------------------------------: |
|                          startIndex                          |              起始下标 默认值 0               |
|                           endIndex                           | 终止下标 默认值 length,可以接收负数,(倒着数) |
| **注意！起始下标和终止下标的区间是 左闭右开 [ a ，b) 能取到起始，取不到终止** |                                              |

```js
  var list = ["a", "b", "c", "d"];
  var result = list.slice(1, 3);
  console.log(result);  // ["b", "c"]

```

### indexOf()

功能: 查询某个元素在数组中第一次出现的位置 存在该元素,返回下标,不存在 返回 -1 (可以通过返回值 变相的判断是否存在该元素)

```js
 var list = [1, 2, 3, 4];
 var index = list.indexOf(4); //3
 var index = list.indexOf("4"); //-1
 console.log(index);

```

### map()

功能: 遍历数组, 每次循环时执行传入的回调函数,根据回调函数的返回值,生成一个新的数组 ,
同forEach() 方法,但是map()方法有返回值,可以return出来;

```js
var list = [32, 93, 77, 53, 38, 87];
var res = list.map(function (item, index, array) {
  return item + 5 * 2;
});
console.log("原数组", list);
console.log("新数组", res);
```

![image-20250306161425508](image-20250306161425508.png)

还可以根据字段名返回数组

```js
var list = [
	{name:"list1",value:1},
	{name:"list2",value:2},
	{name:"list3",value:3},
	{name:"list4",value:4},
]
var res = list.map((item) => {
 reutrun item.name
})
//返回由name组成的数组
```

### filter()

功能: 遍历数组, 每次循环时执行传入的回调函数,回调函数返回一个条件,把满足条件的元素筛选出来放到新数组中.

参数： item:每次循环的当前元素, index:当前项的索引, array:原始数组；
示例:

```js
   var list = [32, 93, 77, 53, 38, 87];
   var resList = list.filter(function (item, index, array) {
      return item >= 60; // true || false
    });
   console.log(resList);//[93,77,87]
```

### reduce()

功能: 遍历数组, 每次循环时执行传入的回调函数,回调函数会返回一个值,将该值作为初始值**prev**,传入到下一次函数中, 返回最终操作的结果;

```js
    var arr = [2, 3, 4, 5];
    var sum = arr.reduce(function (prev, item, index, array) {
      console.log(prev, item, index, array);
      return prev + item;
    });
    console.log(sum);//14

```

```js
   	var arr = [2, 3, 4, 5];
    var sum = arr.reduce(function (prev, item, index, array) {
      console.log(prev, item, index, array);
      return prev + item;
    }, 1);
    console.log(sum);//15

```

### includes()

功能: 用来判断一个数组是否包含一个指定的值，如果是返回 true，否则false。

```js
let site = ['runoob', 'google', 'taobao'];
site.includes('runoob'); 
// true 
site.includes('baidu'); 
// false

```

# 网络请求获取文件流

普通的网络请求

在request.js中设置请求地址，可以设置相关设置

```js
export const service2 = axios.create({
  // axios中请求配置有baseURL选项，表示请求URL公共部分
  baseURL: "https://ssrl.jnreli.com:18899/admin-api",
  // baseURL:"https://safe.jinanenergy.cn/admin-api",
  // 超时
  timeout: 30000,
});
```

在接口文件js中编写

```js
export function exportHazardCheck(data){
    return service2.get("/biz/safe-to/erp/hidden/export/new",{
        params: data,
      })
}
```

当请求的数据为文件流时，应该在请求头上加上responseType: 'blob'表明接收的数据为文件

```js
export function exportHazardCheck(data){
    return service2.get("/biz/safe-to/erp/hidden/export/new",{
        params: data,
        responseType: 'blob'
      })
}
```

然后将数据用blob类型接收并且用a链接下载

```js
const blob = new Blob([data], {
        type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      });
      const url = URL.createObjectURL(blob);
      const link = document.createElement("a");
      link.style.display = "none";
      link.href = url;
      link.setAttribute("download", name + new Date().getTime() + ".xlsx");
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link); // 下载完成移除元素
      window.URL.revokeObjectURL(url); // 释放掉 blob 对象
```

注：type和后缀由不同的文件决定

- 下载excel表格type:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,后缀为.xlsx
- 下载pdf表格type:application/pdf,后缀为.pdf

# 前端权限开发

## 权限控制的方案选择

做后台项目区别于做其它的项目，权限验证与安全性是非常重要的，可以说是一个后台项目一开始就必须考虑和搭建的基础核心功能。在后台管理系统中，实现权限控制可以采用多种方案：

| 权限方案类型                                              | 描述                                                         |
| :-------------------------------------------------------- | ------------------------------------------------------------ |
| 基于角色的访问控制（Role-Based Access Control，RBAC）     | 是一种广泛采用的权限控制方案。系统中定义了不同的角色，每个角色具有一组权限，而用户被分配到一个或多个角色。通过控制用户角色的分配，可以实现对用户访问系统中不同功能和资源的权限控制。 |
| 基于权限的访问控制（Permission-Based Access Control）     | 这种方案将权限直接分配给用户，而不是通过角色来管理。每个用户都有自己的权限列表，控制用户对系统中各项功能和资源的访问。 |
| 基于资源的访问控制（Resource-Based Access Control，RBAC） | 这种方案将权限控制与资源本身关联起来。系统中的每个资源都有自己的访问权限，用户通过被授予资源的访问权限来控制其对资源的操作。 |
| 层次结构权限控制（Hierarchical Access Control）           | 这种方案基于资源和操作的层次结构来进行权限控制。系统中的资源和操作被组织成层次结构，用户被授予访问某个层次及其子层次的权限。 |
| 基于规则的访问控制（Rule-Based Access Control             | 这种方案使用预定义的规则来确定用户对系统中功能和资源的访问权限。规则可以基于用户属性、环境条件或其他因素进行定义。 |

这里我选择了**基于角色的访问控制（Role-Based Access Control，RBAC）** 这是因为RBAC提供了一种灵活且易于管理的方式来控制用户对系统功能和资源的访问，也是目前最主流的前端权限方案选择。

在RBAC中，系统中的功能和资源被组织成角色，而用户则被分配到不同的角色。每个角色都有一组权限，定义了该角色可以执行的操作和访问的资源。通过给用户分配适当的角色，可以实现对用户的权限控制。

RBAC的好处之一是它简化了权限管理的复杂性。管理员只需管理角色和分配角色给用户，而不需要为每个用户单独定义权限。当需要对用户的权限进行修改时，只需调整其角色的权限即可。

此外，RBAC还支持灵活的权限组合，允许创建具有不同权限组合的角色，以适应不同用户的需求。它也便于扩展，可以随着系统的发展和需求的变化而调整和添加角色。

## RBAC下的权限字段设计与管理模型

### 用户权限授权

是对用户身份认证的细化。可简单理解为访问控制，在用户身份认证通过后，系统对用户访问菜单或按钮进行控制。也就是说，该用户有身份进入系统了，但他不一定能访问系统里的所有菜单或按钮，而他只能访问管理员给他分配的权限菜单或按钮。 主要包括：

- Permission（权限标识、权限字符串）：针对系统访问资源的权限标识，如：用户添加、用户修改、用户删除。
- Role （角色）：可以理解为权限组，也就是说角色下可以访问和点击哪些菜单、访问哪些权限标识。

权限标识或权限字符串校验规则：

- 权限字符串：指定权限串必须和菜单中的权限标识匹配才可访问
- **权限字符串命名规范为：`模块:功能:操作`，例如：`sys:user:edit`**
- 使用冒号分隔，对授权资源进行分类，如 `sys:user:edit` 代表 `系统模块:用户功能:编辑操作`
- 设定的功能指定的`权限字符串`与当前用户的`权限字符串`进行匹配，若匹配成功说明当前用户有该功能权限
- 还可以使用简单的通配符，如 `sys:user:*`，建议省略为 `sys:user`（分离前端不能使用星号写法）
- 举例1 `sys:user` 将于 `sys:user` 或 `sys:user:` 开头的所有权限字符串匹配成功
- 举例2 `sys` 将于 `sys` 或 `sys:` 开头的所有权限字符串匹配成功 这种命名格式的好处有：

1. **可读性和可理解性**：使用模块、功能和操作的格式可以直观地表达权限的含义。每个部分都有明确的作用，模块表示特定的模块或子系统，功能表示模块内的某个功能或页面，操作表示对功能进行的具体操作。通过这种格式，权限名称可以更容易地被开发人员、管理员和其他人员理解和解释。
2. **可扩展性和灵活性：** 通过使用模块、功能和操作的格式，可以轻松地扩展和管理权限。每个模块、功能和操作都可以被单独定义和控制。当系统需要增加新的功能或操作时，可以根据需要添加新的权限字符串，而不需要修改现有的权限规则和代码。
3. **细粒度的权限控制：** 这种格式支持细粒度的权限控制，可以针对特定的功能和操作进行权限管理。通过将权限名称拆分为模块、功能和操作，可以精确地定义哪些用户或角色具有访问或操作特定功能的权限。
4. **避免权限冲突：** 使用模块、功能和操作的格式可以避免权限之间的冲突。不同模块、功能和操作的权限名称是唯一的，这样可以避免同名权限之间的混淆和冲突。

### 权限管理模型

关键数据模型如下：

- 用户：登录账号、密码、角色
- 角色：角色名称、角色权限字符、对应菜单、对应菜单下的权限
- 菜单：菜单名称、菜单URL、菜单类型
- 用户角色关系：用户编码、角色编码
- 角色菜单关系：角色编码、菜单编码

关系图如下：

```
【用户】  <---多对多--->  【角色】  <---多对多--->  【菜单/权限】
```

### 实验思路与步骤

前端权限一般分为路由级权限和按钮级权限，这里我们先实现页面路由级的权限功能，按钮级的会在后面讲到。

