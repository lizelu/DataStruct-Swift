//
//  ListProtocal.swift
//  ListDataStruct
//
//  Created by ZeluLi on 16/9/17.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

protocol ListProtocalType {
    
    func count() -> UInt
    
    // MARK: - 链表的创建
    /**
     根据数组正向创建链表
     
     - parameter items: 数组
     
     - returns: true-创建成功， false-创建失败
     */
    func forwardDirectionCreateList(items: Array<AnyObject>) -> Bool
    
    
    /**
     
     根据数组逆向创建数组
     - parameter items: 数组
     
     - returns: true-创建成功， false-创建失败
     */
    func reverseDirectionCreateList(items: Array<AnyObject>) -> Bool
    
    
    // MARK: - 链表元素的增加
    /**
     往链表前方追加元素
     
     - parameter item: 所追加的元素
     
     - returns: true-追加成功，false-追加失败
     */
    func addItemToTail(item: AnyObject) -> Bool
    
    
    /**
     往链表后方追加元素
     
     - parameter item: 所追加的元素
     
     - returns: true-追加成功，false-追加失败
     */
    func addItemToHead(item: AnyObject) -> Bool
    
    
    
    /**
     根据指定索引来插入item
     
     - parameter item:  插入链表中的元素
     - parameter index: 要插入的位置（0-length）
     
     - returns: true-插入成功，false-插入失败
     */
    func insertItem(item: AnyObject, index: UInt) -> Bool
   
    
    
    //MARK: - 链表元素的移除
    /**
     正向移除链表中所有的数据
     */
    func removeAllItemFromHead()
    
    
    /**
     逆向移除链表中所有的数据
     */
    func removeAllItemFromLast()
    
    /**
     移除第一个元素
     
     - returns: 移除成功就返回节点数据，如果移除失败则返回nil
     */
    func removeFirstNote() -> AnyObject?
    
    /**
     移除最后一个节点
     
     - returns: 被移除的节点值
     */
    func removeLastNote() -> AnyObject?
    
    /**
     根据索引移除节点
     
     - parameter index: 索引
     
     - returns: 被移除的节点值
     */
    func removeItme(index: UInt) -> AnyObject?
    
    
    //MARK: - 链表的遍历
    /**
     单向链表的遍历
     */
    func display()
    
    
    // MARK: - 数据验证
    /**
     检查index是否合法
     
     - parameter index: 索引
     
     - returns: true合法，false不合法
     */
    func checkIndex(index: UInt) -> Bool
}
