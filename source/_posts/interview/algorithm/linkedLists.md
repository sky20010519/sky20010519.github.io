---
title: 链表
categories:
  - 面试
  - 链表
tags:
  - 链表
abbrlink: 2362a8ea
date: 2025-01-02 18:12:38
---

##### 本文讲述了算法链表面试的相关问题
<!-- more -->

# 链表

## 1.简单的反转链表

反转一个单链表

示例：

```properties
输入: 1->2->3->4->5->NULL
输出: 5->4->3->2->1->NULL
```

### 循环解决方案

这道题是链表中的经典题目，充分体现链表这种数据结构点。 

那在实现上应该注意一些什么问题呢？ 

操作思路简单, 但是实现上并没有那么简单的特保存后续节点。作为新手来说，很容易将当前节点的next 指针直接指向前一个节点，但其实当前节点下一个节点的指针也就丢失了。因此，需要在遍历的过程当中，先将下一个节点保存，然后再操作 指向。

链表结构声定义如下:

```javascript
function ListNode(val){
	this.val = val;
	this.next = next
}
```

实现如下：

```javascript
 /**
 * @param {ListNode} head
 * @return {ListNode}
 */
 let reverseList =  (head) => {
 	if (!head)
 		return null;
 	let pre = null, cur = head;
 	while (cur) {
 		// 关键: 保存下一个节点的值
		let next = cur.next;
 		cur.next = pre;
 		pre = cur;
 		cur = next;
 	}
 	return pre;
 };
```

