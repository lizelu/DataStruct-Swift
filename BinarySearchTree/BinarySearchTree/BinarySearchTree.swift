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
    var leftChild: BinaryTreeNote!    //左节点指针
    var rightChild: BinaryTreeNote!   //右节点指针
    
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
    func searchBST(currentRoot: BinaryTreeNote?,
                   faterNote: BinaryTreeNote?, key: Int) -> SearchResult {
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
            return searchBST(currentRoot: currentRoot?.leftChild,   //递归左子树
                             faterNote: currentRoot,
                             key: key)
        } else {
            return searchBST(currentRoot: currentRoot?.rightChild,  //递归右子树
                             faterNote: currentRoot,
                             key: key)
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
        print("要删除的值为：\(key)")
        let searchResult = searchBST(currentRoot: rootNote, faterNote: nil, key: key)
        deleteNote(searchResult: searchResult)
    }
    
    
    /**
     中序遍历
     */
    func inOrderTraverse() {
        print("中序遍历：")
        self.inOrderTraverse(note: rootNote)
        print("\n")
    }
    
    private func deleteNote(searchResult: SearchResult) {
        guard let searchNote = searchResult.searchNote else {
            print("没有要删除的值")
            return
        }
        //叶子节点
        if searchNote.leftChild == nil && searchNote.rightChild == nil {
            print("该结点为叶子节点")
            deleteNoteHaveZeroOrOneChild(searchResult: searchResult,
                                         subNote: nil)
            return
        }
        
        //只有左子树的结点
        if searchNote.leftChild != nil && searchNote.rightChild == nil {
            print("该结点只有左子树")
            deleteNoteHaveZeroOrOneChild(searchResult: searchResult,
                                         subNote: searchNote.leftChild)
            return
        }
        
        //只有右子树结点
        if searchNote.leftChild == nil && searchNote.rightChild != nil {
            print("该结点只有右子树")
            deleteNoteHaveZeroOrOneChild(searchResult: searchResult,
                                         subNote: searchNote.rightChild)
            return
        }
        
        //既有左子树也有右子树结点
        if searchNote.leftChild != nil && searchNote.rightChild != nil {
            print("该结点既有左子树也有右子树")
            deleteNoteHaveTowChild(searchResult: searchResult)
            return
        }
    }
    
    /// 要删除的结点既有左子树也有右子树
    ///
    /// - parameter searchResult: 查找结果对象
    private func deleteNoteHaveTowChild(searchResult: SearchResult) {
        //初始化查询结果对象，用于存储右子树最左边的结点
        let cursorSearchResult = SearchResult()
        cursorSearchResult.fatherNote = searchResult.searchNote
        cursorSearchResult.searchNote = searchResult.searchNote?.rightChild
        cursorSearchResult.isFound = true
        
        //寻找删除结点右子树最左边的结点
        while cursorSearchResult.searchNote?.leftChild != nil {
            cursorSearchResult.fatherNote = cursorSearchResult.searchNote
            cursorSearchResult.searchNote = cursorSearchResult.searchNote?.leftChild
        }
        //将右子树最左边的结点的值赋给要删除的结点
        searchResult.searchNote?.data = (cursorSearchResult.searchNote?.data)!
        
        //删除右子树最左边的结点
        deleteNote(searchResult: cursorSearchResult)
    }
    
    /// 要删除的节点是叶子节点或者有一个子节点的情况
    ///
    /// - parameter searchResult: 查找结果
    private func deleteNoteHaveZeroOrOneChild(searchResult: SearchResult, subNote: BinaryTreeNote?) {
        setNilForNote(note: searchResult.searchNote!)   //将要即将删除的结点的左右孩子的指针置空
        guard let fatherNote = searchResult.fatherNote else {
            self.rootNote = subNote //更新根节点
            return
        }
        
        if (searchResult.searchNote?.data)! < fatherNote.data {
            fatherNote.leftChild = subNote  //要删除的结点是父节点的左孩子
        } else {
            fatherNote.rightChild = subNote //要删除的结点是父节点的右孩子
        }
    }
    
    /// 将节点的左右子节点指针置为空
    ///
    /// - parameter note: <#note description#>
    private func setNilForNote(note: BinaryTreeNote) {
        note.leftChild = nil
        note.rightChild = nil
    }
    
    /// 中序遍历二叉排序树
    ///
    /// - parameter note:
    private func inOrderTraverse (note: BinaryTreeNote!) {
        guard let note = note else {
            return
        }
        inOrderTraverse(note: note.leftChild)
        print(note.data, separator: "", terminator: " ")
        inOrderTraverse(note: note.rightChild)
    }


}
