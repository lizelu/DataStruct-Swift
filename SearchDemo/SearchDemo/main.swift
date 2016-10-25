//
//  main.swift
//  SearchDemo
//
//  Created by ZeluLi on 16/10/23.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

enum SearchTypeEnum {
    case SequentialSearch
    case BinarySearch
    case InterpolationSearch
    case FibonacciSearch
}

class SearchFactory {
    static func createSearchObject (type: SearchTypeEnum) -> SearchType{
        switch type {
        case .SequentialSearch:
            print("顺序查找：")
            return SequentialSearch()
            
        case .BinarySearch:
            print("\n折半查找:")
            return BinarySearch()
            
        case .InterpolationSearch:
            print("\n插值查找:")
            return InterpolationSearch()
            
        case .FibonacciSearch:
            print("\nFibonacci查找")
            return FibonacciSearch()
        }
    }
}

class TestCase {
    private func testSearch(searchObject: SearchType) {
        let items = [20, 36, 39, 58, 79, 82, 98, 99];
        let searchResult = searchObject.search(items: items, item: 82)
        print("82的查找的索引为：\(searchResult)")
    }

    func testSequentialSearch() {
        testSearch(searchObject: SearchFactory.createSearchObject(type: .SequentialSearch))
    }
    
    func testBinarySearch() {
        testSearch(searchObject: SearchFactory.createSearchObject(type: .BinarySearch))
    }
    
    func testInterpolationSearch() {
        testSearch(searchObject:SearchFactory.createSearchObject(type: .InterpolationSearch))
    }
    
    func testFibonacciSearch() {
        testSearch(searchObject: SearchFactory.createSearchObject(type: .FibonacciSearch))
    }
}


let testCase = TestCase()
testCase.testBinarySearch()
testCase.testSequentialSearch()
testCase.testInterpolationSearch()
testCase.testFibonacciSearch()
