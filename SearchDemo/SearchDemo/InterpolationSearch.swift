//
//  InterpolationSearch.swift
//  SearchDemo
//
//  Created by Mr.LuDashi on 16/10/24.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation
class InterpolationSearch {
    /// 二分查找
    ///
    /// - parameter itmes: 存储数据的数组
    /// - parameter item:  关键字
    ///
    /// - returns: 该关键字对应订的索引，返回0时说明没有找到该值
    static func search(items: Array<Int>, item: Int) -> Int {
        var low = 0
        var high = items.count - 1
        
        
        while low <= high {
            let difference = items[high] - items[low]
            let weight = Float(item - items[low]) / Float(difference)   //计算插值使用的权值
            let middle = low + Int(weight * Float(high - low))    //计算插值
            
            //let middle = low + 1/2 * (high - low)    //二分查找的权值为1/2
            
            if item  > items[middle] {
                low = middle + 1               //low的值得是middle的值加一，因为上面的计算结果有可能是low = middle
            } else if item < items[middle] {
                high = middle - 1              //height的值得是middle的值减一，因为上面的计算结果有可能是low = middle
            } else {
                return middle + 1           //返回值得索引
            }
        }
        return 0;
    }

}
