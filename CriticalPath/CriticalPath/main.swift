//
//  main.swift
//  Graph
//
//  Created by Mr.LuDashi on 16/9/19.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

//let allGraphNote = ["A", "B", "C", "D", "E", "F", "G", "H", "I"];
//
//let relationDirectedGraph: Array<(Any, Any, Any)> =
//    [("A", "B", 10), ("A", "F", 11), ("B", "C", 18), ("B", "I", 12), ("B", "G", 16),
//     ("F", "G", 17), ("F", "E", 26), ("C", "I", 8), ("C", "D", 22), ("I", "D", 21),
//     ("G", "H", 19), ("G", "D", 24), ("H", "D", 16), ("E", "H", 7), ("E", "D", 20)];
//

let allGraphNote = ["v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7", "v8", "v9"];
let relationDirectedGraph: Array<(Any, Any, Any)> =
    [("v0", "v1", 3), ("v0", "v2", 4), ("v1", "v3", 5), ("v1", "v4", 6),("v2", "v3", 8),
     ("v2", "v5", 7), ("v3", "v4", 3), ("v4", "v6", 9), ("v4", "v7", 4), ("v5", "v7", 6),
     ("v6", "v9", 2), ("v7", "v8", 5), ("v8", "v9", 3)];

let graph = GraphAdjacencyList(notes: allGraphNote,
                               relations: relationDirectedGraph,
                               isNotDirection: false)
graph.displayGraph()

graph.topoLogicalSort()



