//
//  QueueProtocal.swift
//  StackAndQueue
//
//  Created by Mr.LuDashi on 16/9/18.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

protocol QueueType {
    /**
     获取队头结点值
     
     - returns: 头结点
     */
    func getHead() -> AnyObject?
    
    /**
     进入队列
     
     - returns: 空
     */
    func enQueue(_ item: AnyObject) -> Void
    
    /**
     获取尾结点值
     
     - returns: 返回队尾的结点值
     */
    func getTail() -> AnyObject?
    
    /**
     出队列
     
     - returns: 出队列的值
     */
    func deQueue() -> AnyObject?
    
    /**
     队列的长度
     
     - returns: 队列中元素的个数
     */
    func queueLength() -> Int
    
    /**
     判断队列是否为空
     
     - returns: true - 空，  false - 不为空
     */
    func queueIsEmpty() -> Bool
    
    /**
     清空队列中的值
     
     - returns:
     */
    func clearQueue() -> Void;
    
    /**
     遍历输出队列中的值
     
     - returns:
     */
    func display() -> Void
}
