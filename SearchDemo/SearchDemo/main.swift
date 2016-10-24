//
//  main.swift
//  SearchDemo
//
//  Created by ZeluLi on 16/10/23.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

func testSequentialSearch() {
    let items = ["A", "B", "C", "D", "E", "F", "G", "H"];
    var searchResult = SequentialSearch.search(itmes: items as Array<AnyObject>,
                                               item: "B" as AnyObject)
    print("B的顺序查找的索引为：\(searchResult)")
    
    searchResult = SequentialSearch.searchWithSentry(items: items as Array<AnyObject>,
                                                   item: "H" as AnyObject)
    print("H的顺序查找的索引为：\(searchResult)")
}

testSequentialSearch()


func testBinarySearch() {
    let items = ["A", "B", "C", "D", "E", "F", "G", "H"];
    let searchResult = BinarySearch.search(itmes: items,
                                               item: "G")
    print("G的二分查找的索引为：\(searchResult)")
}
testBinarySearch()


func testInterpolationSearch() {
    let items = [10, 20, 36, 39, 58, 79, 82, 98];
    let searchResult = InterpolationSearch.search(items: items,
                                                   item: 82)
    print("82的二分查找的索引为：\(searchResult)")
}
testInterpolationSearch()

