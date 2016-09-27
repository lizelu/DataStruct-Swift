//
//  SequenceQueue.swift
//  StackAndQueue
//
//  Created by Mr.LuDashi on 16/9/18.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

class SequenceQueue: QueueType {
    
    fileprivate var queueItems: Array<AnyObject>
    
    init() {
        queueItems = []
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
        return queueItems[0]
    }
    
    /**
     进入队列
     
     - returns: 空
     */
    func enQueue(_ item: AnyObject) -> Void {
        queueItems.append(item)
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
        return queueItems[queueLength() - 1]
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
        
        return queueItems.removeFirst()
    }
    
    /**
     队列的长度
     
     - returns: 队列中元素的个数
     */
    func queueLength() -> Int {
        return queueItems.count
    }
    
    /**
     判断队列是否为空
     
     - returns: true - 空，  false - 不为空
     */
    func queueIsEmpty() -> Bool {
        return queueItems.isEmpty
    }
    
    /**
     清空队列中的值
     */
    func clearQueue() {
        queueItems.removeAll()
    }
    
    /**
     遍历输出队列中的值
     
     - returns:
     */
    func display() -> Void {
        for item in queueItems {
            print(item, separator: "", terminator: "<-")
        }
        print("end\n")
    }

}
