---
title: 代码优化
categories:
  - js
tags:
  - js
abbrlink: d59ddab2
date: 2025-01-02 18:12:38
---

**本文讲述了平时遇见的一些代码进行优化**

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

