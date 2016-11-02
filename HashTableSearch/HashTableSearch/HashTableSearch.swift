//
//  HashTableSearch.swift
//  HashTableSearch
//
//  Created by Mr.LuDashi on 16/11/2.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation
class HashTable {
    private var hashTable:Dictionary<Int, Int> = [:]
    private var list: Array<Int> = []
    private var count: Int {
        get {
            return list.count
        }
    }
    
    init(list: Array<Int>) {
        self.list = list
        createHashTable()
    }
    
    
    /// 创建散列表
    private func createHashTable() {
        for item in self.list {
            add(value: item)
        }
    }
    
    /// 将数据添加到散列表中
    ///
    /// - parameter value: 需要添加到散列表中的数据
    private func add(value: Int) {
        let key = createHashKey(value: value)
        hashTable[key] = value
    }
    
    /// 生成hashKey
    ///
    /// - parameter value: 生成散列key的值
    ///
    /// - returns: 返回散列key
    private func createHashKey(value: Int) -> Int {
        var key = hashFunction(value: value)
        if hashTable[key] != nil {
            key = conflictHandling(value: key)
        }
        return key
    }
    
    
    /// 处理冲突
    ///
    /// - parameter value: 冲突的key
    ///
    /// - returns: 那个不冲突的key
    private func conflictHandling(value: Int) -> Int {
        var key = value
        var cursor = hashTable[key]
        while cursor != nil {
            key = conflictHandling(value: key)     //处理冲突
            cursor = hashTable[key]
        }
        return key
    }
    
    /// 散列函数
    ///
    /// - parameter value: 散列函数的参数
    ///
    /// - returns: 返回散列函数创建的值
    private func hashFunction(value: Int) -> Int {
        return value % count
    }

    private func conflictMethod(value: Int) -> Int {
        return (value + 1) % count
    }
    
    
}

class HashTableSearch {
    
}
