//
//  main.swift
//  BinarySearchTree
//
//  Created by Mr.LuDashi on 16/10/26.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

let searchTable: Array<Int> = [62, 88, 58, 47, 62, 35, 73, 51, 99, 37, 93]
let binarySearchTree = BinarySearchTree(items: searchTable)

binarySearchTree.deleteNote(key: 99)
binarySearchTree.inOrderTraverse()


binarySearchTree.deleteNote(key: 35)
binarySearchTree.inOrderTraverse()

binarySearchTree.deleteNote(key: 37)
binarySearchTree.inOrderTraverse()



