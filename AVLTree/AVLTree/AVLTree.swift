//
//  AVLTree.swift
//  AVLTree
//
//  Created by ZeluLi on 2016/10/29.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation
class AVLTreeNote {
    //该结点对应树的深度
    var depth: Int {
        get {
            if leftChild != nil && rightChild != nil {
                if leftChild.depth < rightChild.depth {
                    return rightChild.depth + 1
                } else {
                    return leftChild.depth + 1
                }
            }
            if leftChild != nil {
                return leftChild.depth + 1
            }
            if rightChild != nil {
                return rightChild.depth + 1
            }
            return 0
        }
    }
    
    //结点的平衡因子为（平衡二叉树中的平衡因子为-1, 0, 1）
    var balanceFactor: Int {
        get {
            if leftChild != nil && rightChild != nil {
                return leftChild.depth - rightChild.depth
            }
            if leftChild != nil {
                return leftChild.depth + 1
            }
            if rightChild != nil {
                return -rightChild.depth - 1
            }
            return 0
        }
    }
    
    var data: Int                  //结点的值
    var fatherNote: AVLTreeNote?   //指向父节点的指针
    var leftChild: AVLTreeNote!    //左节点指针
    var rightChild: AVLTreeNote!   //右节点指针
    
    init(data: Int) {
        self.data = data
    }
    
    deinit {
        print("\(self.data)被释放掉")
    }
}

/// 存储二叉排序树查找的结果
class SearchResult {
    //存储查找的节点，如果查找成功就是当前查找成功的节点
    var searchNote: AVLTreeNote?
    
    //存储当前查找节点的直属父节点
    var fatherNote: AVLTreeNote?
    
    //查找成功为true，查找失败为false
    var isFound: Bool = false
}


class AVLTree {
    var rootNote: AVLTreeNote?
    
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
    func searchBST(currentRoot: AVLTreeNote?,
                   faterNote: AVLTreeNote?, key: Int) -> SearchResult {
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
    func insertNote(faterNote: AVLTreeNote?, key: Int) {
        let note = AVLTreeNote(data: key)
        note.fatherNote = faterNote
        
        if faterNote == nil { //创建根节点
            rootNote = note
            return
        }
        
        if key < (faterNote?.data)! {
            faterNote?.leftChild = note
        } else {
            faterNote?.rightChild = note
        }
        
        findNoBalanceNote(currentNote: note)
    }
    
    
    /// 寻找不平衡子树的根节点
    ///
    /// - parameter currentNote: 返回该不平衡的结点
    ///
    /// - returns:
    private func findNoBalanceNote(currentNote: AVLTreeNote) {
        var cursor = currentNote.fatherNote
        while cursor != nil {
            let banlaceFactor = (cursor?.balanceFactor)!
            
            if banlaceFactor < -1 || banlaceFactor > 1 {
                print("不平衡点：值为\(cursor?.data), 深度为\(cursor?.depth), 平衡因子为\(cursor?.balanceFactor)")
                adjustBalance(noBalanceNote: cursor!)
                return
            }
            cursor = cursor?.fatherNote
        }
    }

    enum NoBalanceType {
        case LL //左左
        case LR //左右
        case RR //右右
        case RL //右左
    }

    func adjustBalance(noBalanceNote: AVLTreeNote) {
        guard let noBalanceType = fixNoBalanceType(noBalanceNote: noBalanceNote) else {
            return
        }
        switch noBalanceType {
        case .LL:
            print("左左")
            adjustBalanceLL(noBalanceNote: noBalanceNote)
           
        case .LR:
            print("左右")
            adjustBalanceLR(noBalanceNote: noBalanceNote)
            
        case .RR:
            print("右右")
            adjustBalanceRR(noBalanceNote: noBalanceNote)
            
        case .RL:
            print("右左")
            adjustBalanceRL(noBalanceNote: noBalanceNote)
        }
        print()
    }
    
    
    /// 调整左左的情况
    ///
    /// - parameter noBalanceNote: 要调整的结点
    func adjustBalanceLL(noBalanceNote: AVLTreeNote) {
        
        let currentLeftChild = noBalanceNote.leftChild
        noBalanceNote.leftChild = currentLeftChild?.rightChild
        currentLeftChild?.rightChild = noBalanceNote
        
        //获取要调整结点的父节点
        guard let fatherNote = noBalanceNote.fatherNote else {
            self.rootNote = currentLeftChild
            noBalanceNote.fatherNote = currentLeftChild //更新父结点
            currentLeftChild?.fatherNote = nil
            return
        }
        
        if (currentLeftChild?.data)! > fatherNote.data {
            fatherNote.rightChild = currentLeftChild
        } else {
            fatherNote.leftChild = currentLeftChild
        }
        
        //更新父结点
        noBalanceNote.fatherNote = currentLeftChild
        currentLeftChild?.fatherNote = fatherNote
    }
    
    /// 调整左右的情况
    ///
    /// - parameter noBalanceNote: 要调整的结点
    func adjustBalanceLR(noBalanceNote: AVLTreeNote) {
        
        let currentLeftChild = noBalanceNote.leftChild
        noBalanceNote.leftChild = currentLeftChild?.rightChild
        currentLeftChild?.rightChild = currentLeftChild?.rightChild.leftChild
        noBalanceNote.leftChild.leftChild = currentLeftChild
        
        //更新父节点
        currentLeftChild?.fatherNote = noBalanceNote.leftChild
        currentLeftChild?.rightChild?.fatherNote = currentLeftChild
        noBalanceNote.leftChild.fatherNote = noBalanceNote
        
        adjustBalanceLL(noBalanceNote: noBalanceNote)
    }

    
    /// 调整右右的情况
    ///
    /// - parameter noBalanceNote: 要调整的结点
    func adjustBalanceRR(noBalanceNote: AVLTreeNote) {
        let currentRightChild = noBalanceNote.rightChild
        noBalanceNote.rightChild = currentRightChild?.leftChild
        currentRightChild?.leftChild = noBalanceNote
        
        guard let fatherNote = noBalanceNote.fatherNote else {
            self.rootNote = currentRightChild
            noBalanceNote.fatherNote = currentRightChild //更新父结点
            currentRightChild?.fatherNote = nil
            return
        }
        
        if (currentRightChild?.data)! > fatherNote.data {
            fatherNote.rightChild = currentRightChild
        } else {
            fatherNote.leftChild = currentRightChild
        }
        
        //更新父结点
        noBalanceNote.fatherNote = currentRightChild
        currentRightChild?.fatherNote = fatherNote
    }
    
    /// 调整右左的情况
    ///
    /// - parameter noBalanceNote: 要调整的结点
    func adjustBalanceRL(noBalanceNote: AVLTreeNote) {
        let currentRightChild = noBalanceNote.rightChild
        noBalanceNote.rightChild = currentRightChild?.leftChild
        currentRightChild?.leftChild = currentRightChild?.leftChild.rightChild
        noBalanceNote.rightChild.rightChild = currentRightChild
        
        //更新父节点
        currentRightChild?.fatherNote = noBalanceNote.rightChild
        currentRightChild?.leftChild?.fatherNote = currentRightChild
        noBalanceNote.rightChild.fatherNote = noBalanceNote
        adjustBalanceRR(noBalanceNote: noBalanceNote)
    }


    
    /// 确定不平衡的类型
    ///
    /// - parameter noBalanceNote: 不平衡子树的根节点
    ///
    /// - returns: 不平衡类型
    func fixNoBalanceType(noBalanceNote: AVLTreeNote) -> NoBalanceType? {
        let noBalanceFactor = noBalanceNote.balanceFactor
        if noBalanceFactor == 2 {   //LL或者LR的情况
            let leftChildBalanceFactor = noBalanceNote.leftChild.balanceFactor
            if leftChildBalanceFactor == 1 {
                return NoBalanceType.LL
            }
            
            if leftChildBalanceFactor == -1 {
                return NoBalanceType.LR
            }
            return NoBalanceType.LL //删除结点时使用
        }
        
        if noBalanceFactor == -2 {  //RR或者RL的情况
            let leftChildBalanceFactor = noBalanceNote.rightChild.balanceFactor
            if leftChildBalanceFactor == -1 {
                return NoBalanceType.RR
            }
            
            if leftChildBalanceFactor == 1 {
                return NoBalanceType.RL
            }
            
            return NoBalanceType.RR     //删除结点时使用
        }
        return nil
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
    private func deleteNoteHaveZeroOrOneChild(searchResult: SearchResult, subNote: AVLTreeNote?) {
        setNilForNote(note: searchResult.searchNote!)   //将要即将删除的结点的左右孩子的指针置空
        guard let fatherNote = searchResult.fatherNote else {
            self.rootNote = subNote //更新根节点
            subNote?.fatherNote = self.rootNote
            return
        }
        
        if (searchResult.searchNote?.data)! < fatherNote.data {
            fatherNote.leftChild = subNote  //要删除的结点是父节点的左孩子
        } else {
            fatherNote.rightChild = subNote //要删除的结点是父节点的右孩子
        }
        subNote?.fatherNote = fatherNote
        
        findNoBalanceNote(currentNote: fatherNote)
    }
    
    /// 将节点的左右子节点指针置为空
    ///
    /// - parameter note: <#note description#>
    private func setNilForNote(note: AVLTreeNote) {
        note.leftChild = nil
        note.rightChild = nil
        note.fatherNote = nil
    }
    
    /// 中序遍历二叉排序树
    ///
    /// - parameter note:
    private func inOrderTraverse (note: AVLTreeNote!) {
        guard let note = note else {
            return
        }
        inOrderTraverse(note: note.leftChild)
        print("结点值\(note.data)", separator: "", terminator: ", ")
        print("深度\(note.depth)", separator: "", terminator: ", ")
        print("平衡因子\(note.balanceFactor)")
        inOrderTraverse(note: note.rightChild)
    }
    
    
}

