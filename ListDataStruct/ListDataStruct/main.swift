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

func testOneDirectionLinkList() {
    let oneDirectionLinkList = OneDirectionLinkList()
    print("正向创建链表")
    oneDirectionLinkList.forwardDirectionCreateList(array)
    oneDirectionLinkList.display()
    
    print("\n链表正向清空")
    oneDirectionLinkList.removeAllItemFromHead()
    
    print("\n逆向创建链表")
    oneDirectionLinkList.reverseDirectionCreateList(array)
    oneDirectionLinkList.display()
    
    print("\n链表逆向清空")
    oneDirectionLinkList.removeAllItemFromLast()
    
    print("\n插入元素")
    oneDirectionLinkList.insertItem("非法", index: 100)
    oneDirectionLinkList.insertItem("header", index: 0)
    oneDirectionLinkList.insertItem("mid", index: oneDirectionLinkList.length/2 + 1)
    oneDirectionLinkList.insertItem("tail", index: oneDirectionLinkList.length)
    oneDirectionLinkList.display()
    
    print("\n移除元素，并返回值")
    print(oneDirectionLinkList.removeLastNote()!)
    print(oneDirectionLinkList.removeFirstNote()!)
    print(oneDirectionLinkList.removeItme(0)!)
    
    oneDirectionLinkList.display()
}


//testSqueueList()
//testOneDirectionLinkList()

        