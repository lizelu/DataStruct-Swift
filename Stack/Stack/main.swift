//
//  main.swift
//  Stack
//
//  Created by ZeluLi on 16/9/17.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

let items = "a,b,c,d,e".componentsSeparatedByString(",")

func testStack(stack: StackType) {
    for item in items {
        stack.push(item)
    }
    print("栈的初始值如下：")
    stack.display()
    
    print("将e, d出栈后")
    print(stack.pop())
    print(stack.pop())
    stack.display()
    
    print("将x,y,z入栈")
    stack.push("x")
    stack.push("y")
    stack.push("z")
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

