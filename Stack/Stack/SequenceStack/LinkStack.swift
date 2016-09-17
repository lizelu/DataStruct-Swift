//
//  LinkStack.swift
//  Stack
//
//  Created by ZeluLi on 16/9/17.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

class LinkStackNote {
    var data: AnyObject
    var next: LinkStackNote?
    
    init(data: AnyObject = "") {
        self.data = data
    }
    
    deinit{
        print("\(self.data)释放", separator: "", terminator: ",")
    }

}

class LinkStack: StackType {
    private var top: LinkStackNote? = nil
    private var count: Int = 0
    
    func push(item: AnyObject) {
        let note = LinkStackNote(data: item)
        note.next = top
        top = note
        count += 1
    }
    
    func pop() -> AnyObject? {
        if !stackIsEmpty() {
            let note = top
            top = top?.next
            count -= 1
            return note?.data
        }
        return nil
    }
    
    func getTop() -> AnyObject? {
        if !stackIsEmpty() {
            return top?.data
        }
        return nil
    }
    
    func stackLength() -> Int {
        return count
    }
    
    func stackIsEmpty() -> Bool {
        return top == nil
    }
    
    func clearStack() {
        while !stackIsEmpty() {
            pop()
        }
    }
    
    func display() {
        if stackIsEmpty() {
            print("栈为空")
            return
        }
        
        var cursor = top
        while cursor != nil {
            print("[_\((cursor?.data)!)_]")
            cursor = cursor?.next
        }
        print("")
    }
}