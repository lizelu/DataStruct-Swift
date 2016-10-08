//
//  Tree.swift
//  DataStructDemo
//
//  Created by Mr.LuDashi on 16/9/5.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

class GeneralBinaryTreeNote {
    var data: String
    
    var leftChild: GeneralBinaryTreeNote!    //左节点
    var rightChild: GeneralBinaryTreeNote!   //右节点
    
    init(data: String) {
        self.data = data
    }
}

class GeneralBinaryTree {
    var rootNote: GeneralBinaryTreeNote!
    
    fileprivate var items: Array<String>
    fileprivate var index = -1
    
    init(items: Array<String>) {
        self.items = items
        self.rootNote = self.createTree()
    }
    
    /**
     以先序递归的方式创建二叉树
     
     - parameter dataArray: 创建二叉树所需要的先序遍历的数据
     */
    fileprivate func createTree() -> GeneralBinaryTreeNote! {
        self.index = self.index + 1
        if index < self.items.count && index >= 0 {
            
            let item = self.items[index]
            
            if item == "" {
                return nil
            } else {
                let note = GeneralBinaryTreeNote(data: item)
                note.leftChild = createTree()       //递归创建左子树
                note.rightChild = createTree()      //递归创建右子树
                return note
            }
        }
        return nil;
    }
    
    /**
     先序遍历：先遍历根节点，再遍历左子树，让后遍历右子树
     */
    func preOrderTraverse() {
        print("先序遍历：")
        self.preOrderTraverse(note: rootNote)
        print("\n")
    }
    
    private func preOrderTraverse (note: GeneralBinaryTreeNote!) {
        //遍历根节点
        guard let note = note else {
            print("空", separator: "", terminator: " ")
            return
        }
        print(note.data, separator: "", terminator: " ")
        
        //递归遍历左子树
        preOrderTraverse(note: note.leftChild)
        
        //递归遍历右子树
        preOrderTraverse(note: note.rightChild)
    }
    
    
    /**
     中序遍历
     */
    func inOrderTraverse() {
        print("中序遍历：")
        self.inOrderTraverse(note: rootNote)
        print("\n")
    }
    
    private func inOrderTraverse (note: GeneralBinaryTreeNote!) {
        guard let note = note else {
            print("空", separator: "", terminator: " ")
            return
        }
        inOrderTraverse(note: note.leftChild)
        print(note.data, separator: "", terminator: " ")
        inOrderTraverse(note: note.rightChild)
    }
    
    /**
     后续遍历
     */
    func afterOrderTraverse() {
        print("后序遍历：")
        self.afterOrderTraverse(note: rootNote)
        print("\n")
    }
    
    private func afterOrderTraverse (note: GeneralBinaryTreeNote!) {
        guard let note = note else {
            print("空", separator: "", terminator: " ")
            return
        }
        afterOrderTraverse(note: note.leftChild)
        afterOrderTraverse(note: note.rightChild)
        print(note.data, separator: "", terminator: " ")
    }
}
