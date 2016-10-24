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
    print("B的索引为：\(searchResult)")
    
    searchResult = SequentialSearch.searchWithSentry(items: items as Array<AnyObject>,
                                                   item: "H" as AnyObject)
    print("H的索引为：\(searchResult)")
}

testSequentialSearch()
