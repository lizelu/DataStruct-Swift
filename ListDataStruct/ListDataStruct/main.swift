//
//  main.swift
//  ListDataStruct
//
//  Created by ZeluLi on 16/9/11.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

let array = "a,b,c,d,e,f,g".components(separatedBy: ",")

func testSqueueList() {
    let sequcenceList: SequenceList = SequenceList(capacity: 10)
    
    for item in array {
        sequcenceList.addItem(item)
    }
    sequcenceList.displayList()
    
    let insertResult = sequcenceList.insert("z", index: 0)
    let removeResult = sequcenceList.removeItme(1)
    let modifyResult = sequcenceList.modify(3, newItem: "m")
    
    if insertResult && removeResult && (modifyResult != nil) {
        sequcenceList.displayList()
    }
}



func testLinkedList(_ list: ListProtocalType) {
    var callResult =  false
    
    callResult = list.forwardDirectionCreateList(items: array as Array<AnyObject>)
    if callResult {
        print("正向创建链表")
        list.display()
    }
    
    print("\n链表正向清空")
    list.removeAllItemFromHead()
    
    callResult = list.reverseDirectionCreateList(items: array as Array<AnyObject>)
    if callResult {
        print("\n逆向创建链表")
        list.display()
    }
    
    print("\n链表逆向清空")
    list.removeAllItemFromLast()
    
    
    if list.insertItem(item: "非法" as AnyObject, index: 100) &&
    list.insertItem(item: "header" as AnyObject, index: 0) &&
    list.insertItem(item: "mid" as AnyObject, index: list.count()/2 + 1) &&
    list.insertItem(item: "tail" as AnyObject, index: list.count()) {
        print("\n插入元素")
        list.display()
    }
    
    if (list.removeLastNote() != nil) &&
    (list.removeFirstNote() != nil) &&
    (list.removeItme(index: 0) != nil) {
        print("\n移除元素，并返回值")
        list.display()
    }
}



testSqueueList()
//testLinkedList(OneDirectionLinkList())
//testLinkedList(DoublyLinkedList())

        
