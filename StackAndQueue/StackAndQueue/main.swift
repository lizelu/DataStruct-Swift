//
//  main.swift
//  Stack
//
//  Created by ZeluLi on 16/9/17.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

let items = "a,b,c,d,e".components(separatedBy: ",")

func testStack(_ stack: StackType) {
    for item in items {
        stack.push(item as AnyObject)
    }
    print("栈的初始值如下：")
    stack.display()
    
    print("将e, d出栈后")
    print(stack.pop())
    print(stack.pop())
    stack.display()
    
    print("将x,y,z入栈")
    stack.push("x" as AnyObject)
    stack.push("y" as AnyObject)
    stack.push("z" as AnyObject)
    stack.display()
    
    if let topItem = stack.getTop() {
        print("顶部元素: \(topItem)")
    }
    
    print("栈的长度为：\(stack.stackLength())")
    
    //将栈清空
    if !stack.stackIsEmpty() {
        stack.clearStack()
    }
    
    stack.display()
}

testStack(SequenceStack())
testStack(LinkStack())


func testQueue(_ queue: QueueType) {
    for item in items {
        queue.enQueue(item as AnyObject)
    }
    
    print("队列中的原始值如下：")
    queue.display()
    
    print("将a, b出队列")
    if (queue.deQueue() != nil) &&
       (queue.deQueue() != nil) {
        queue.display()
    }
    
    print("将x, y, z入队列")
    queue.enQueue("x" as AnyObject)
    queue.enQueue("y" as AnyObject)
    queue.enQueue("z" as AnyObject)
    queue.display()
    
    if let topItem = queue.getHead() {
        print("队首元素: \(topItem)")
    }
    
    if let tailItem = queue.getTail() {
        print("队首元素: \(tailItem)")
    }
    
    print("队列的长度为：\(queue.queueLength())")
    
    //将栈清空
    if !queue.queueIsEmpty() {
        queue.clearQueue()
    }
    
    queue.display()

}

//testQueue(SequenceQueue())
//testQueue(LinkQueue())
//

