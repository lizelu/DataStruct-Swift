//
//  main.swift
//  HashTableSearch
//
//  Created by Mr.LuDashi on 16/11/2.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

let list: Array<Int> = [62, 88, 58, 47, 62, 35, 73, 51, 99, 37, 93]

func hashTableTest(hashTable: HashTable) {
    
    hashTable.displayHashTable()
    let key = hashTable.search(value: 35)
    print(key)
}


hashTableTest(hashTable: HashTableWithMod(list: list))
