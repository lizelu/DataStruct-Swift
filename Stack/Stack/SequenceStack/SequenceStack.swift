//
//  SequenceStack.swift
//  Stack
//
//  Created by ZeluLi on 16/9/17.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

class SequenceStack: StackType  {
    private var items: Array<AnyObject> = []
    
    func push(item: AnyObject) {
        items.append(item)
    }
    
    func pop() -> AnyObject? {
        return items.removeLast()
    }
    
    func getTop() -> AnyObject? {
        if stackIsEmpty() {
            return nil
        }
        
        return items[items.count - 1]
    }
    
    func stackLength() -> Int {
        return items.count
    }
    
    func stackIsEmpty() -> Bool {
        return items.isEmpty
    }
    
    func clearStack() {
        items.removeAll()
    }
    
    func display() {
        var i = items.count - 1
        while i >= 0 {
            print(items[i], separator: "", terminator: ", ")
            i -= 1
        }
        print("")
    }
}
