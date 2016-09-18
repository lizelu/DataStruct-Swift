//
//  Tree.swift
//  DataStructDemo
//
//  Created by Mr.LuDashi on 16/9/5.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

class GeneralBinaryTree {
    var rootNote: GeneralBinaryTreeNote!
    
    private var items: Array<String>
    private var index = -1
    
    init(items: Array<String>) {
        self.items = items
        self.rootNote = self.createTree()
    }
    
    /**
     以先序递归的方式创建二叉树
     
     - parameter dataArray: 创建二叉树所需要的先序遍历的数据
     */
    private func createTree() -> GeneralBinaryTreeNote! {
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
        self.preOrderTraverse(rootNote)
    }
    
    private func preOrderTraverse (note: GeneralBinaryTreeNote!) {
        guard let note = note else {
            return
        }
        print(note.data)
        preOrderTraverse(note.leftChild)
        preOrderTraverse(note.rightChild)
    }
    
    
    /**
     中序遍历
     */
    func inOrderTraverse() {
        print("中序遍历：")
        self.inOrderTraverse(rootNote)
    }
    
    private func inOrderTraverse (note: GeneralBinaryTreeNote!) {
        guard let note = note else {
            return
        }
        inOrderTraverse(note.leftChild)
        print(note.data)
        inOrderTraverse(note.rightChild)
    }
    
    /**
     后续遍历
     */
    func afterOrderTraverse() {
        print("后序遍历：")
        self.afterOrderTraverse(rootNote)
    }
    
    private func afterOrderTraverse (note: GeneralBinaryTreeNote!) {
        guard let note = note else {
            return
        }
        afterOrderTraverse(note.leftChild)
        afterOrderTraverse(note.rightChild)
        print(note.data)
    }

}
