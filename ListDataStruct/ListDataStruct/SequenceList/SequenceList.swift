//
//  SequenceList.swift
//  ListDataStruct
//
//  Created by ZeluLi on 16/9/11.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

class SequenceList {
    private var list: NSMutableArray
    private var count = 0
    private var capacity = 0
    
    var length: Int {
        get {
            return count
        }
    }
    
    init(capacity: Int) {
        self.capacity = capacity
        self.list = NSMutableArray(capacity: capacity)
    }
    
    func displayList() {
        for i in 0..<count {
            print("\(i) -> \(list[i])")
        }
        print("\n")
    }
    
    func addItem(item: String) {
        list[count] = item;
        count += 1
    }
    
    func fetchItem(index: Int) -> String? {
        if !checkIndex(index) {
            return nil
        }
        
        return list[index] as? String
    }
    
    func modify(index: Int, newItem: String) -> String? {
        if !checkIndex(index) {
            return nil
        }
        
        let oldItem = list[index]
        list[index] = newItem
        return oldItem as? String
    }
    
    func insert(item: String, index: Int) -> Bool {
        if !checkIndex(index) {
            return false
        }
        
        var i = count
        while i > index {
            list[i] = list[i-1]
            i -= 1
        }
        list[index] = item;
        count += 1
        return true
    }
    
    func removeItme(index: Int) -> Bool {
        if !checkIndex(index) {
            return false
        }
        
        for i in index..<count-1 {
            list[i] = list[i+1]
        }
        
        count -= 1
        list.removeLastObject()
        
        return true
    }
    
    func checkIndex(index: Int) -> Bool {
        if index < 0 || index > count  {
            print("index非法，请进行检查")
            return false
        }
        return true
    }
    
    //waiting……
}