//
//  BinaryThreadTree.swift
//  BinaryTree
//
//  Created by Mr.LuDashi on 16/9/19.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

class BinaryThreadTreeNote {
    var data: String
    
    var leftChild: BinaryThreadTreeNote!    //左节点
    var rightChild: BinaryThreadTreeNote!   //右节点
    
    var leftTag: Bool = true        //true - 指向左子树， false-指向前驱
    var rightTag: Bool = true       //true - 指向右子树， false-指向后继
    
    init(data: String) {
        self.data = data
    }
}

class BinaryThreadTree {
    var rootNote: BinaryThreadTreeNote!
    
    fileprivate var items: Array<String>
    fileprivate var index = -1
    fileprivate var preNote: BinaryThreadTreeNote?
    fileprivate var headNote: BinaryThreadTreeNote?
    
    init(items: Array<String>) {
        self.items = items
        self.rootNote = self.createTree()
        
        self.headNote = BinaryThreadTreeNote(data: "")
        self.headNote?.leftChild = self.rootNote
        self.headNote?.leftTag = true
        
        self.preNote = headNote
    }
    
    /**
     以先序递归的方式创建二叉树
     
     - parameter dataArray: 创建二叉树所需要的先序遍历的数据
     */
    fileprivate func createTree() -> BinaryThreadTreeNote! {
        self.index = self.index + 1
        if index < self.items.count && index >= 0 {
            
            let item = self.items[index]
            
            if item == "" {
                return nil
            } else {
                let note = BinaryThreadTreeNote(data: item)
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
        print("\n")
    }
    
    fileprivate func preOrderTraverse (_ note: BinaryThreadTreeNote!) {
        guard let note = note else {
            return
        }
        print(note.data, separator: "", terminator: " ")
        if note.leftTag {
            preOrderTraverse(note.leftChild)
        }
        
        if note.rightTag {
            preOrderTraverse(note.rightChild)
        }
    }

    
    /**
     使用中序遍历将二叉树进行线索化，该线索化，是将中序遍历的结果生成一个双向链表
     
     - parameter note:
     */
    func inThread() {
        self.inThreading(note: self.rootNote)
    }
    
    private func inThreading(note: BinaryThreadTreeNote?) {
        if note != nil {
            inThreading(note: note?.leftChild)
            
            //如果节点的左节点为nil, 那么将该节点指向其中序遍历的前驱
            if note?.leftChild == nil {
                note?.leftTag = false
                note?.leftChild = preNote
            }
            
            //如果该节点的中序遍历的前驱的右节点为nil, 那么将该前驱节点的右节点指向该节点进行关联
            if preNote?.rightChild == nil {
                preNote?.rightTag = false
                preNote?.rightChild = note
            }
            
            preNote = note
            inThreading(note: note?.rightChild)
        }
    }
    
    func displayThreadTree() {
        print("遍历线索化二叉树")
        var cursor = self.headNote?.rightChild
        while cursor != nil {
            print((cursor?.data)!, separator: "", terminator: " -> ")
            cursor = cursor?.rightChild
        }
        print("end\n")
    }

}
