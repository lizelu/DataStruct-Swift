//
//  GraphAdjacencyList.swift
//  Graph
//
//  Created by Mr.LuDashi on 16/9/19.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

class GraphAdjacencyListNote {
    var data: AnyObject
    var next: GraphAdjacencyListNote?
    
    init(data: AnyObject = "") {
        self.data = data
    }
    
    
}

class GraphAdjacencyList: GraphType {
    private var graph: Array<GraphAdjacencyListNote>
    private var relationDic: Dictionary<String,Int>
    
    init() {
        graph = []
        relationDic = [:]
    }
    
    // MARK: - GraphType
    func createGraph(notes: Array<AnyObject>, relation: Array<(AnyObject,AnyObject)>){
        for i in 0..<notes.count {
            let note = GraphAdjacencyListNote(data: notes[i])
            graph.append(note)
            relationDic[notes[i] as! String] = i
        }
        
        for item in relation {
            guard let i = relationDic[item.0 as! String],
                j = relationDic[item.1 as! String] else {
                    continue
            }
            
            let note1 = GraphAdjacencyListNote(data: i)
            note1.next = graph[j].next
            graph[j].next = note1
            
            let note2 = GraphAdjacencyListNote(data: j)
            note2.next = graph[i].next
            graph[i].next = note2
        }
    
    }
    
    func displayGraph() {
        for i in 0..<graph.count {
            
            print("(\(i))", separator: "", terminator: "")
            var cursor: GraphAdjacencyListNote? = graph[i]
            while cursor != nil {
                print(cursor!.data, separator: "", terminator: "->")
                cursor = cursor?.next
            }
            print("nil")
        }
        print()
    
    }
}