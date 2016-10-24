//
//  SequentialSearch.swift
//  SearchDemo
//
//  Created by Mr.LuDashi on 16/10/24.
//  Copyright © 2016年 zeluli. All rights reserved.
//
//顺var查找

import Foundation

class SequentialSearch {
    
    
    /// 从头到尾顺序匹配
    ///
    /// - parameter itmes: 存储数据的数组
    /// - parameter item:  关键字
    ///
    /// - returns: 该关键字对应订的索引，返回0时说明没有找到该值
    static func search(itmes: Array<AnyObject>, item: AnyObject) -> Int {
        for i in 0..<itmes.count {
            if item.isEqual(itmes[i]){
                return i + 1
            }
        }
        return 0;
    }
    
    /// 将关键字设置成哨兵，从后往前进行查找
    ///
    /// - parameter itmes: 存储数据的数组
    /// - parameter item:  关键字
    ///
    /// - returns: 该关键字对应订的索引，返回0时说明没有找到该值
    static func searchWithSentry(items: Array<AnyObject>, item: AnyObject) -> Int {
        var itemsWithSentry = items
        itemsWithSentry.insert(item, at: 0) //将关键字设置成哨兵
        
        var i = itemsWithSentry.count - 1
        while !item.isEqual(itemsWithSentry[i]) {
            i -= 1
        }
        
        return i
    }
    
}
