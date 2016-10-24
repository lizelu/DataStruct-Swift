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
                                               item: "F")
    print("F的二分查找的索引为：\(searchResult)")
}
testBinarySearch()
