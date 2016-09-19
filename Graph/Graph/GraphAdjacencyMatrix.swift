//
//  GraphAdjacencyMatrix.swift
//  Graph
//
//  Created by Mr.LuDashi on 16/9/19.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation
let NO_RELATION = 0
let HAVE_RELATION = 1

class GraphAdjacencyMatrix: GraphType {
    private var relationDic: Dictionary<String,Int>
    private var graph:Array<Array<Int>>
    
    init() {
        relationDic = [:]
        graph = []
    }
    
    func createGraph(notes: Array<AnyObject>, relation: Array<(AnyObject,AnyObject)>) {
        configData(notes)
        
        //根据关系创建图
        for item in relation {
            guard let i = relationDic[item.0 as! String],
                      j = relationDic[item.1 as! String] else {
                    continue
            }
            graph[i][j] = HAVE_RELATION
            graph[j][i] = HAVE_RELATION
        }
        
    }
    
    private func configData(notes: Array<AnyObject>) {
        for i in 0..<notes.count {
            relationDic[notes[i] as! String] = i
        }
        
        for _ in 0..<notes.count {
            var temp:Array<Int> = []
            for _ in 0..<notes.count {
                temp.append(NO_RELATION)
            }
            graph.append(temp)
        }
    }
    
    func displayGraph() {
        for i in 0..<graph.count {
            for j in 0..<graph[i].count {
                print(graph[i][j], separator: "", terminator: " ")
            }
            print("")
        }
        print("")
    }
    
}


