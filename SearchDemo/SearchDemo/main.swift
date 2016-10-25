//
//  main.swift
//  SearchDemo
//
//  Created by ZeluLi on 16/10/23.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

func testSearch(searchObject: SearchType) {
    let items = [20, 36, 39, 58, 79, 82, 98, 99];
    let searchResult = searchObject.search(items: items, item: 82)
    print("82的查找的索引为：\(searchResult)")
}
print("顺序查找：")
testSearch(searchObject: SequentialSearch())

print("\n折半查找")
testSearch(searchObject: BinarySearch())

print("\n插值查找")
testSearch(searchObject: InterpolationSearch())

print("\nFibonacci查找")
testSearch(searchObject: FibonacciSearch())
