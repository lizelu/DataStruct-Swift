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
    
    init(capacity: Int) {
        self.capacity = capacity
        self.list = NSMutableArray(capacity: capacity)
    }
    
    func displayList() {
        for i in 0..<count {
            print(list[i])
        }
        print("\n")
    }
    
    func addItem(item: String) {
        list[count] = item;
        count += 1
    }
    
    func insert(item: String, index: Int) {
        if index < 0 || index > count  {
            print("插入位置非法，请进行检查")
            return;
        }
        
        var i = count
        while i > index {
            list[i] = list[i-1]
            i -= 1
        }
        list[index] = item;
        count += 1
    }
    
    //waiting……
}