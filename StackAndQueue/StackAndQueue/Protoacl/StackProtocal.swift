//
//  StackProtocal.swift
//  Stack
//
//  Created by ZeluLi on 16/9/17.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

protocol StackType {
    /**
     入栈
     
     - parameter item: 入栈元素
     
     - returns: 无
     */
    func push(item: AnyObject)
    
    /**
     出栈
     
     - returns: 出栈的值
     */
    func pop() -> AnyObject?
    
    /**
     获取栈顶元素
     
     - returns: 返回栈顶元素
     */
    func getTop() -> AnyObject?
    
    /**
     栈的长度
     
     - returns: length
     */
    func stackLength() -> Int
    
    /**
     判断栈是否为空
     
     - returns: true - 空，false - 不为空
     */
    func stackIsEmpty() -> Bool
    
    /**
     清除栈中的元素
     */
    func clearStack()
    
    /**
     对栈中的元素，从上到下进行遍历输出
     */
    func display()
}