//
//  TreeNote.swift
//  DataStructDemo
//
//  Created by Mr.LuDashi on 16/9/5.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//


class GeneralBinaryTreeNote {
    var data: String
    
    var leftChild: GeneralBinaryTreeNote!    //左节点
    var rightChild: GeneralBinaryTreeNote!   //右节点
    
    init(data: String) {
        self.data = data
    }
}
