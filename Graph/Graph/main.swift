//
//  main.swift
//  Graph
//
//  Created by Mr.LuDashi on 16/9/19.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

let allGraphNote = ["A", "B", "C", "D", "E", "F", "G", "H", "I"];
let relation: Array<(AnyObject, AnyObject)> = [("A","B"), ("A","F"), ("B","C"), ("B","I"), ("B","G"),
                                               ("F","G"), ("F","E"), ("C","I"), ("C","D"), ("I","D"),
                                               ("G","H"), ("G","D"), ("H","D"), ("H","E"), ("D","E")];

func testGraph(graph: GraphType) {
    
    graph.createGraph(allGraphNote, relation: relation)
    graph.displayGraph()
    graph.depthFirstSearch()
    print()
}

print("邻接矩阵:")
testGraph(GraphAdjacencyMatrix())

print("\n邻接链表:")
testGraph(GraphAdjacencyList())