//
//  LinkQueue.swift
//  StackAndQueue
//
//  Created by Mr.LuDashi on 16/9/18.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

class LinkQueue: QueueType {
    
    // MARK: - QueueType
    
    /**
     获取队头结点值
     
     - returns: 头结点
     */
    func getHead() -> AnyObject? {
        return nil
    }
    
    /**
     进入队列
     
     - returns: 空
     */
    func enQueue(item: AnyObject) -> Void {
        
    }
    
    /**
     获取尾结点值
     
     - returns: 返回队尾的结点值
     */
    func getTail() -> AnyObject? {
        return nil
    }
    
    /**
     出队列
     
     - returns: 出队列的值
     */
    func deQueue() -> AnyObject? {
        return nil
    }
    
    /**
     队列的长度
     
     - returns: 队列中元素的个数
     */
    func queueLength() -> Int {
        return 0
    }
    
    /**
     判断队列是否为空
     
     - returns: true - 空，  false - 不为空
     */
    func queueIsEmpty() -> Bool {
        return true
    }
    
    /**
     清空队列中的值
     */
    func clearQueue() {
    
    }
    
    /**
     遍历输出队列中的值
     
     - returns:
     */
    func display() -> Void {
        
    }

}