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

# ui中的字体样式

看到公司ui设计图中的字体样式，不能直接复制粘贴，因为本项目中不一定有样式中的字体包，需要我们在项目中引用字体包

首先要获取字体包可以选择和公司ui要或者网上直接下载

![image-20250210171206872]()

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

