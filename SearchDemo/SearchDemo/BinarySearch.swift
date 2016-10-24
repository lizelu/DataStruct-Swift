//
//  BinarySearch.swift
//  SearchDemo
//
//  Created by Mr.LuDashi on 16/10/24.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation
class BinarySearch {
    /// 二分查找
    ///
    /// - parameter itmes: 存储数据的数组
    /// - parameter item:  关键字
    ///
    /// - returns: 该关键字对应订的索引，返回0时说明没有找到该值
    static func search(itmes: Array<String>, item: String) -> Int {
        var low = 0
        var high = itmes.count - 1
        
        while low <= high {
            let middle = (low + high) / 2   //计算本轮循环中间的位置
            
            if item  > itmes[middle] {
                low = middle + 1               //查找后半边，更新low的值
            } else if item < itmes[middle] {
                high = middle - 1               //查找前半边，更新high的值
            } else {
                return middle + 1           //返回值得索引
            }
        }
        return 0;
    }

}
