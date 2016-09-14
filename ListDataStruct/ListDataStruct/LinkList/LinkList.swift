//
//  LinkList.swift
//  ListDataStruct
//
//  Created by Mr.LuDashi on 16/9/14.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

/// 单向链表的节点
class OneDirectionLinkListNote {
    var data: String
    var next: OneDirectionLinkListNote?
    
    init(data: String = "") {
        self.data = data
    }
    
    deinit{
        print("\(self.data)释放", separator: "", terminator: "->")
    }
}

class OneDirectionLinkList {
    var headNote: OneDirectionLinkListNote?
    var tailNote: OneDirectionLinkListNote?
    var length: UInt
    
    init() {
        self.headNote = OneDirectionLinkListNote()
        self.tailNote = self.headNote
        self.length = 0
    }
    
    /**
     根据数组正向创建链表
     
     - parameter items: 数组
     
     - returns: true-创建成功， false-创建失败
     */
    func forwardDirectionCreateList(items: Array<String>) -> Bool {
        for item in items {
            let newLinkListNote = OneDirectionLinkListNote(data: item)
            if self.tailNote == nil {
                return false
            }
            self.tailNote?.next = newLinkListNote
            self.tailNote = newLinkListNote
            self.length += 1
        }
        return true
    }
    
    /**
     
     根据数组逆向创建数组
     - parameter items: 数组
     
     - returns: true-创建成功， false-创建失败
     */
    func reverseDirectionCreateList(items: Array<String>) -> Bool {
        for item in items {
            let newLinkListNote = OneDirectionLinkListNote(data: item)
            if self.headNote == nil {
                return false
            }
            newLinkListNote.next = headNote?.next
            self.headNote?.next = newLinkListNote
            self.length += 1
            if length == 1 {
                self.tailNote = newLinkListNote;
            }
        }
        return true
    }
    
    /**
     移除链表中所有的数据
     */
    func removeAllItem() {
        var removeItem: OneDirectionLinkListNote? = self.headNote?.next
        
        if removeItem == nil {
            return
        }
        
        while self.length != 0 {
            self.headNote?.next = removeItem?.next
            removeItem?.next = nil
            self.length -= 1
            if self.headNote?.next != nil {
                removeItem = (self.headNote?.next)!
            } else {
                self.tailNote = self.headNote
                break
            }
        }
        removeItem = nil
        print("Over")
    }
    
    /**
     单向链表的遍历
     */
    func display() {
        var currentNote = self.headNote?.next
        for _ in 0..<self.length {
            if currentNote == nil {
                break
            }
            guard let item = currentNote?.data else {
                return
            }
            print(item, separator: "", terminator: " -> ")
            currentNote = currentNote?.next
        }
        print("nil")
    }
    
}