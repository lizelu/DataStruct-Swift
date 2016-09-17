//
//  main.swift
//  ListDataStruct
//
//  Created by ZeluLi on 16/9/11.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

let array = "a,b,c,d,e,f,g".componentsSeparatedByString(",")

func testSqueueList() {
    let sequcenceList: SequenceList = SequenceList(capacity: 10)
    
    for item in array {
        sequcenceList.addItem(item)
    }
    sequcenceList.displayList()
    
    sequcenceList.insert("z", index: 0)
    sequcenceList.removeItme(1)
    sequcenceList.modify(3, newItem: "m")
    
    sequcenceList.displayList()
}



func testLinkedList(list: ListProtocalType) {
    print("正向创建链表")
    list.forwardDirectionCreateList(array)
    list.display()
    
    print("\n链表正向清空")
    list.removeAllItemFromHead()
    
    print("\n逆向创建链表")
    list.reverseDirectionCreateList(array)
    list.display()
    
    print("\n链表逆向清空")
    list.removeAllItemFromLast()
    
    print("\n插入元素")
    list.insertItem("非法", index: 100)
    list.insertItem("header", index: 0)
    list.insertItem("mid", index: list.count()/2 + 1)
    list.insertItem("tail", index: list.count())
    list.display()
    
    print("\n移除元素，并返回值")
    list.removeLastNote()
    list.removeFirstNote()
    list.removeItme(0)
    
    list.display()
}



//testSqueueList()
testLinkedList(OneDirectionLinkList())
//testLinkedList(DoublyLinkedList())

        