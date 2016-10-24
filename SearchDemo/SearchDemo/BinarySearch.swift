//
//  BinarySearch.swift
//  SearchDemo
//
//  Created by Mr.LuDashi on 16/10/24.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation
class BinarySearch {
    /// 从头到尾顺序匹配
    ///
    /// - parameter itmes: 存储数据的数组
    /// - parameter item:  关键字
    ///
    /// - returns: 该关键字对应订的索引，返回0时说明没有找到该值
    static func search(itmes: Array<String>, item: String) -> Int {
        var low = 0
        var middle = itmes.count / 2
        var high = itmes.count - 1
        
        while low < high {
            if item  > itmes[middle] {
                low = middle
                middle = (low + high) / 2
                continue
            }
            
            if item < itmes[middle] {
                high = middle
                middle = (low + high) / 2
                continue
            }
            return middle + 1
        }

        return 0;
    }

}
