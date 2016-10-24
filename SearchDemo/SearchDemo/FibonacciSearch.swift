//
//  FibonacciSearch.swift
//  SearchDemo
//
//  Created by Mr.LuDashi on 16/10/24.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation
class FibonacciSearch: SearchType {
    
    /// 创建Fibonacci数列，F(n) = F(n-1) + F(n-2)，（n >= 2）
    ///
    /// - returns: 返回创建好的Fibonacci数列
    private func createFibonacciSequence() -> Array<Int> {
        var fibonacciSequence = [0, 1];
        for i in 2..<30 {
            fibonacciSequence.append(fibonacciSequence[i-1] + fibonacciSequence[i-2])
        }
        return fibonacciSequence
    }
    func search(items: Array<Int>, item: Int) -> Int {
        let fibonacciSequence = createFibonacciSequence()
        print(fibonacciSequence)
        return 0
    }
}
