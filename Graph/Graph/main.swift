//
//  main.swift
//  Graph
//
//  Created by Mr.LuDashi on 16/9/19.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

let allGraphNote = ["A", "B", "C", "D", "E"];
let relation: Array<(AnyObject, AnyObject)> = [("A","B"), ("A","C"), ("B","D"), ("B","E"), ("D","E"), ("C","E")];


let adjacencyMatrix = GraphAdjacencyMatrix()
adjacencyMatrix.createGraph(allGraphNote, relation: relation)
adjacencyMatrix.displayGraph()
        