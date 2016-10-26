//
//  BinarySearchTree.swift
//  BinarySearchTree
//
//  Created by Mr.LuDashi on 16/10/26.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

class BinaryTreeNote {
    var data: Int
    
    var leftChild: BinaryTreeNote!    //左节点
    var rightChild: BinaryTreeNote!   //右节点
    
    init(data: Int) {
        self.data = data
    }
    
    deinit {
        print("\(self.data)释放")
    }
}


/// 存储二叉排序树查找的结果
class SearchResult {
    //存储查找的节点，如果查找成功就是当前查找成功的节点
    var searchNote: BinaryTreeNote?
    
    //存储当前查找节点的直属父节点
    var fatherNote: BinaryTreeNote?
    
    //查找成功为true，查找失败为false
    var isFound: Bool = false
}

class BinarySearchTree {
    var rootNote: BinaryTreeNote?
    
    fileprivate var items: Array<Int>
    fileprivate var index = -1
    
    init(items: Array<Int>) {
        self.items = items
        createBinarySearchTree()
    }
    
    
    /// 根据提供的数据创建二叉排序树
    func createBinarySearchTree() {
        for key in items {
            //对key进行查找
            let searchResult = searchBST(currentRoot: rootNote, faterNote: nil, key: key)
            
            //如果查找失败，则插入到二叉排序树上
            if !searchResult.isFound {
                insertNote(faterNote: searchResult.fatherNote, key: key)
            }
        }
        inOrderTraverse()
    }
    
    
    
    /// 查找二叉排序树
    ///
    /// - parameter currentRoot: 当前二叉排序树的根节点或者子树的根节点
    /// - parameter faterNote: 该根节点的父节点，如果是整个二叉排序树的根节点的话就为nil
    /// - parameter key: 查找的关键字
    ///
    /// - returns:返回查找的结果对象
    func searchBST(currentRoot: BinaryTreeNote?, faterNote: BinaryTreeNote?, key: Int) -> SearchResult {
        let searchResult = SearchResult()
        
        //查找失败, 返回该节点的父类节点
        if currentRoot == nil {
            searchResult.fatherNote = faterNote
            searchResult.isFound = false
            return searchResult
        }
        
        //查找成功，返回查找成功的节点，然后将isFound设置成true
        if key == currentRoot?.data {
            searchResult.searchNote = currentRoot
            searchResult.fatherNote = faterNote
            searchResult.isFound = true
            return searchResult
        }
        
        if key < (currentRoot?.data)! {
            return searchBST(currentRoot: currentRoot?.leftChild, faterNote: currentRoot, key: key)
        } else {
            return searchBST(currentRoot: currentRoot?.rightChild, faterNote: currentRoot, key: key)
        }
    }
    
    
    /// 往二叉排序树上插入节点
    ///
    /// - parameter faterNote: 插入节点的父节点
    /// - parameter key: 插入的数据
    func insertNote(faterNote: BinaryTreeNote?, key: Int) {
        let note = BinaryTreeNote(data: key)
        
        if faterNote == nil { //创建根节点
            rootNote = note
            return
        }
        
        if key < (faterNote?.data)! {
            faterNote?.leftChild = note
        } else {
            faterNote?.rightChild = note
        }
    }
    
    func deleteNote(key: Int) {
        let searchResult = searchBST(currentRoot: rootNote, faterNote: nil, key: key)
        guard let searchNote = searchResult.searchNote else {
            print("没有要删除的值")
            return
        }
        
        if searchNote.leftChild == nil && searchNote.rightChild == nil {
            deleteNoChildNote(searchResult: searchResult)
            return
        }
        
        if searchNote.leftChild == nil && searchNote.rightChild != nil {
            deleteNoteOnlyHaveRightChild(searchResult: searchResult)
            return
        }
        
        if searchNote.leftChild != nil && searchNote.rightChild == nil {
            deleteNoteOnlyHaveLeftChild(searchResult: searchResult)
            return
        }
        
        if searchNote.leftChild != nil && searchNote.rightChild != nil {
//            deleteNoteOnlyHaveLeftChild(searchResult: searchResult)
            return
        }
        
    }
    
    
    /// 删除叶子节点
    ///
    /// - parameter searchResult: 查找结果
    func deleteNoChildNote(searchResult: SearchResult) {
        deleteNoteHaveZeroOrOneChild(searchResult: searchResult,
                                           subNote: nil)
    }
    
    /// 要删除的节点只有左子树的情况
    ///
    /// - parameter searchResult: 查找结果
    func deleteNoteOnlyHaveLeftChild(searchResult: SearchResult) {
        deleteNoteHaveZeroOrOneChild(searchResult: searchResult,
                                           subNote: (searchResult.searchNote?.leftChild)!)
    }
    
    /// 要删除的节点只有右子树的情况
    ///
    /// - parameter searchResult: 查找结果
    func deleteNoteOnlyHaveRightChild(searchResult: SearchResult) {
        deleteNoteHaveZeroOrOneChild(searchResult: searchResult,
                                           subNote: (searchResult.searchNote?.rightChild)!)
    }
    
    /// 要删除的节点是叶子节点，有一个子节点的情况
    ///
    /// - parameter searchResult: 查找结果
    func deleteNoteHaveZeroOrOneChild(searchResult: SearchResult, subNote: BinaryTreeNote?) {
        guard let fatherNote = searchResult.fatherNote else {
            //删除的节点为根节点
            self.rootNote = subNote
            searchResult.searchNote?.rightChild = nil
            searchResult.searchNote?.leftChild = nil
            return
        }
        
        if (searchResult.searchNote?.data)! < fatherNote.data {
            fatherNote.leftChild = subNote
        } else {
            fatherNote.rightChild = subNote
        }
        
        searchResult.searchNote?.rightChild = nil
        searchResult.searchNote?.leftChild = nil
    }


    
    /**
     中序遍历
     */
    func inOrderTraverse() {
        print("中序遍历：")
        self.inOrderTraverse(note: rootNote)
        print("\n")
    }
    
    private func inOrderTraverse (note: BinaryTreeNote!) {
        guard let note = note else {
//            print("空", separator: "", terminator: " ")
            return
        }
        inOrderTraverse(note: note.leftChild)
        print(note.data, separator: "", terminator: " ")
        inOrderTraverse(note: note.rightChild)
    }


}
