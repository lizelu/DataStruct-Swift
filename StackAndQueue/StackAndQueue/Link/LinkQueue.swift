//
//  LinkQueue.swift
//  StackAndQueue
//
//  Created by Mr.LuDashi on 16/9/18.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

class LinkQueueNote {
    var data: AnyObject
    var next: LinkQueueNote?
    
    init(data: AnyObject = "" as AnyObject) {
        self.data = data
    }
    
    deinit{
        print("\(self.data)释放", separator: "", terminator: ",")
    }
}

class LinkQueue: QueueType {
    
    fileprivate var queueHead: LinkQueueNote?
    fileprivate var queueTail: LinkQueueNote?
    fileprivate var count: Int
    
    init() {
        queueHead = LinkQueueNote()
        queueTail = queueHead
        count = 0
    }
    
    
    // MARK: - QueueType
    
    /**
     获取队头结点值
     
     - returns: 头结点
     */
    func getHead() -> AnyObject? {
        if queueIsEmpty() {
            print("队列为空")
            return nil
        }
        return queueHead?.next?.data
    }
    
    /**
     进入队列
     
     - returns: 空
     */
    func enQueue(_ item: AnyObject) -> Void {
        let note = LinkQueueNote(data: item)
        queueTail?.next = note
        queueTail = note
        count += 1
    }
    
    /**
     获取尾结点值
     
     - returns: 返回队尾的结点值
     */
    func getTail() -> AnyObject? {
        if queueIsEmpty() {
            print("队列为空")
            return nil
        }
        return queueTail?.data
    }
    
    /**
     出队列
     
     - returns: 出队列的值
     */
    func deQueue() -> AnyObject? {
        if queueIsEmpty() {
            print("队列为空")
            return nil
        }
        let deNote = queueHead?.next
        queueHead?.next = deNote?.next
        deNote?.next = nil
        count -= 1
        if queueHead?.next == nil {
            queueTail = queueHead
        }
        return deNote?.data
    }
    
    /**
     队列的长度
     
     - returns: 队列中元素的个数
     */
    func queueLength() -> Int {
        return count
    }
    
    /**
     判断队列是否为空
     
     - returns: true - 空，  false - 不为空
     */
    func queueIsEmpty() -> Bool {
        return queueHead?.next == nil
    }
    
    /**
     清空队列中的值
     */
    func clearQueue() {
        while deQueue() != nil {}
    }
    
    /**
     遍历输出队列中的值
     
     - returns:
     */
    func display() -> Void {
        var cursor = queueHead?.next
        while cursor != nil {
            print((cursor?.data)!, separator: "", terminator: "<-")
            cursor = cursor?.next
        }
        print("end\n")
    }
}

