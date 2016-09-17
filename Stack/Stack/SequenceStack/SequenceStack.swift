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
    
    func push(imte: AnyObject) {
        items.append(items)
    }
    
    func pop() -> AnyObject {
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
}
