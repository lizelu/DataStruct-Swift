//
//  main.swift
//  Stack
//
//  Created by ZeluLi on 16/9/17.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation
let items = "a,b,c,d,e,f,g,h,i".componentsSeparatedByString(",")
print(items)
func testStack(stack: StackType) {
    for item in items {
        stack.push(item)
    }
    stack.display()
}

testStack(SequenceStack())

