//
//  main.swift
//  AllKindsOfSort
//
//  Created by Mr.LuDashi on 16/11/4.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation


func testSort(sortObject: SortType) {
    let list: Array<Int> = [62, 88, 58, 47, 62, 35, 73, 51, 99, 37, 93]
    let sortList = sortObject.sort(items: list)
    print(sortList)
}

testSort(sortObject: BubbleSort())
