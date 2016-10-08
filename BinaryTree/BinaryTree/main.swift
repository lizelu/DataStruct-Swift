//
//  main.swift
//  DataStructDemo
//
//  Created by Mr.LuDashi on 16/9/5.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

let items: Array<String> = ["A", "B", "D", "", "", "E", "", "", "C", "","F", "", ""]
let generalBinaryTree: GeneralBinaryTree = GeneralBinaryTree(items: items)

generalBinaryTree.preOrderTraverse()
generalBinaryTree.inOrderTraverse()
generalBinaryTree.afterOrderTraverse()

func testGeneralBinaryTree() {
    
    
}


func testThreadTree() {
    let binaryThreadTree = BinaryThreadTree(items: items)
    binaryThreadTree.inThread()
    binaryThreadTree.displayThreadTree()
    binaryThreadTree.preOrderTraverse()
    
}
testGeneralBinaryTree()
testThreadTree()
