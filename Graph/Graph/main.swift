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

func testGraph(graph: GraphType) {
    graph.createGraph(allGraphNote, relation: relation)
    graph.displayGraph()
}

testGraph(GraphAdjacencyMatrix())

testGraph(GraphAdjacencyList())