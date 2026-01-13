---
title: echarts
categories:
  - echarts
tags:
  - echarts
abbrlink: 35704d68
date: 2025-01-02 18:12:38
---

**本文讲述了echarts的相关问题**

<!-- more -->

# 柱状图和折线图

## 简介

echart的折线图和柱状图配置只有在series中type的区别，当type为bar时就为柱状图，当type为line就为折线图,其他配置项都是通用的，而且柱状图和折线图可以出现在同一个容器中

最简单的柱状图配置

```js
option = {
  xAxis: {
    type: 'category',
    data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
  },
  yAxis: {
    type: 'value'
  },
  series: [
    {
      data: [120, 200, 150, 80, 70, 110, 130],
      type: 'bar'
    }
  ]
};
```

我们可以将项目的中echart部分编写为一个公共组件便于后续使用，当使用时只需要提供配置项，不需要重复编写echart的引入，刷新，检查页面大小变换,柱状图和折线图的vue文件如下

```vue
<script setup>
import * as echarts from "echarts";
import ElementResize from 'element-resize-detector'
import { nextTick, onUnmounted } from "vue";
import { comptedFontSize } from "#/utils/erp";
import { computed, ref, watch } from "vue";

const erd = ElementResize();
const props = defineProps({
    echartsData: {
        type: Object,
        default: () => {
            return {
                xAxis: {},
                yAxis: [],
                series: [],
            };
        },
    },
});
const emits = defineEmits(["handleClick"]);
function clickHandle() {
    emits("handleClick");
}
const echartsRef = ref(null);
let myCharts = null;
const createChart = ({
    xAxis = {},
    yAxis = [],
    series = [],
    grid = {},
    tooltip = {},
    legend = {},
    title = {},
    dataZoom = [],
}) => {
    let option = {
        title: {
            textStyle: {
                fontSize: comptedFontSize(18),
            },
            ...title,
        },
        grid: {
            left: "8%",
            right: "6%",
            top: "20%",
            bottom: "13%",
            ...grid,
        },
        dataZoom: [...dataZoom],
        legend: {
            textStyle: { color: "#000", fontSize: comptedFontSize(14) },
            ...legend,
        },
        tooltip: {
            confine: true,
            textStyle: {
                fontSize: comptedFontSize(18),
            },

            padding: comptedFontSize(8),
            ...tooltip,
        },
        xAxis: {
            type: "category",
            axisLine: {
                lineStyle: {
                    color: "#000",
                },
            },
            axisTick: {
                show: true,
                lineStyle: {
                    color: "#000",
                },
            },
            axisLabel: {
                show: true,
                color: "#000",
                fontSize: comptedFontSize(14),
            },
            splitLine: { show: false },
            nameTextStyle: {
                fontSize: comptedFontSize(12),
            },
            ...xAxis,
        },
        yAxis: yAxis.map((singleYAxis) => {
            return {
                type: "value",
                axisLine: {
                    show: true,
                    lineStyle: {
                        color: "#000",
                    },
                },
                splitLine: {
                    lineStyle: {
                        color: "#000",
                        type: "dashed",
                    },
                },
                axisTick: {
                    show: true,
                    lineStyle: {
                        color: "#000",
                    },
                },
                axisLabel: {
                    show: true,
                    color: "#000",
                    fontSize: comptedFontSize(14),
                },
                nameTextStyle: {
                    fontSize: comptedFontSize(12),
                },
                ...singleYAxis,
            };
        }),
        series: [...series],
    };

    option && myCharts.setOption(option);
};


const sleep = (delay) => new Promise((resolve) => setTimeout(resolve, delay));

const resizeObserver = new ResizeObserver((entries) => {
    myCharts && myCharts.resize();
});

watch(
    () => props.echartsData,
    async (newValue) => {
        if (!myCharts) {
            await sleep(100);
            myCharts = echarts.init(echartsRef.value);
        }
        nextTick(() => {
            erd.listenTo(echartsRef.value, () => {
                myCharts.resize();
            });
        });
        createChart(props.echartsData);
        myCharts.resize();
        resizeObserver.observe(echartsRef.value);
    },
    { deep: true, immediate: true }
);
onUnmounted(() => {
    erd.uninstall(echartsRef.value)
})
</script>
<template>
    <div class="line-bar-echarts" @click="clickHandle" ref="echartsRef"></div>
</template>
<style lang="scss">
.line-bar-echarts {
    width: 100%;
    height: 100%;
    min-height: 100px;
    min-width: 300px;
}
</style>

```

## 常用的配置项

### title

title配置项决定这个图表的标题，其中text为标题文字，textStyle为标题文字的样式，还可以使用top、left、right、bottom来控制标题在容器中的位置

```js
title: {
    text:'122'
    textStyle: {
        fontSize: comptedFontSize(18),
    },
},
```

### girid

grid是指图表本身位于容器内部的位置

```
grid: {
	left: "8%",
	right: "6%",
	top: "20%",
	bottom: "13%",
},
```

### legend

legend是指图表的图例部分也可以使用top、left、right、bottom来控制图例的位置textStyle为图例文字的样式，orient为图例的布局方式为水平（horizontal）或者竖直（vertical）

```
top: '10%',
orient: horizontal
textStyle: {
	color: "#fff", 
	fontSize: comptedFontSize(14)
}
```

### xAxis和yAxis

```js
xAxis: {
        type: 'category',
        data: [],
        axisLine: {//坐标轴横线
            lineStyle: {
                color: "#4174c3",
            },
        },
            splitLine: {//坐标轴刻度
                    lineStyle: {
                        width: 1,
                        type: 'dashed',
                        color: ['rgba(51,121,255,0.3255)']
                    }
                }
        axisTick: {//坐标轴交互
            show: false,
            lineStyle: {
                color: "#fff",
            },
        },
        axisLabel: {//坐标轴坐标
            show: true,
            color: "#fff",
            interval: 0, //使x轴文字显示全
            formatter: function (params) {
                var newParamsName = '';
                var paramsNameNumber = params.length;
                var provideNumber = 4; //一行显示几个字
                var rowNumber = Math.ceil(paramsNameNumber / provideNumber);
                if (paramsNameNumber > provideNumber) {
                    for (var p = 0; p < rowNumber; p++) {
                        var tempStr = '';
                        var start = p * provideNumber;
                        var end = start + provideNumber;
                        if (p == rowNumber - 1) {
                            tempStr = params.substring(start, paramsNameNumber);
                        } else {
                            tempStr = params.substring(start, end) + '\n';
                        }
                        newParamsName += tempStr;
                    }
                } else {
                    newParamsName = params;
                }
                return newParamsName;
            },
        },
    },
    yAxis: [
        {
            name: '数量（个）',
            type: 'value',
            min: 0,
            minInterval: 1,
            axisLine: {
                show: false,
                lineStyle: {
                    color: "#fff",
                },
            },
            splitLine: {
                show: true,
                lineStyle: {
                    color: "#194caf",
                    type: "soiled",
                },
            },
            axisTick: {
                show: false,
                lineStyle: {
                    color: "#000",
                },
            },
            axisLabel: {
                show: true,
                color: "#fff",
            },
        }
    ],
```

