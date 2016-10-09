//
//  main.swift
//  Graph
//
//  Created by Mr.LuDashi on 16/9/19.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

let allGraphNote = ["A", "B", "C", "D", "E", "F", "G", "H", "I"];
let relation: Array<(Any, Any, Any)> =
    [("A", "B", 10), ("A", "F", 11), ("B", "C", 18), ("B", "I", 12), ("B", "G", 16),
     ("F", "G", 17), ("F", "E", 26), ("C", "I", 8), ("C", "D", 22), ("I", "D", 21),
     ("G", "H", 19), ("G", "D", 24), ("H", "D", 16), ("H", "E", 7), ("D", "E", 20)];

func testGraph(graph: GraphType) {
    graph.createGraph(notes: allGraphNote, relation: relation)
    graph.displayGraph()
    graph.depthFirstSearch()
    graph.breadthFirstSearch()
    
    graph.createMiniSpanTreePrim()
    graph.breadthFirstSearchTree()
    
    graph.createMiniSpanTreeKruskal()
    graph.breadthFirstSearchTree()
    print()
}

print("邻接矩阵:")
testGraph(graph: GraphAdjacencyMatrix())

print("\n邻接链表:")
testGraph(graph: GraphAdjacencyList())

