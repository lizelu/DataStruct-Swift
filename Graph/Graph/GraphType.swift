//
//  GraphType.swift
//  Graph
//
//  Created by Mr.LuDashi on 16/9/19.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation
protocol GraphType {
    func createGraph(notes: Array<AnyObject>, relation: Array<(AnyObject,AnyObject)>)
    func displayGraph()
}