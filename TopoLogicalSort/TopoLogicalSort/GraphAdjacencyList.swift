//
//  GraphAdjacencyList.swift
//  Graph
//
//  Created by Mr.LuDashi on 16/9/19.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation


/// 链表上的节点
class GraphAdjacencyListNote {
    var data: AnyObject
    var weightNumber: Int   //权值或者入度
    var next: GraphAdjacencyListNote?
    
    init(data: AnyObject = "" as AnyObject, weightNumber: Int = 0) {
        self.data = data
        self.weightNumber = weightNumber
    }
}


class GraphAdjacencyList {
    fileprivate var relation: Array<(Any, Any, Any)>
    fileprivate var graph: Array<GraphAdjacencyListNote>
    fileprivate var relationDic: Dictionary<String,Int>
    
    init() {
        graph = []
        relationDic = [:]
        relation = []
    }
    
    
    /// 有向图
    ///
    /// - parameter notes:          图的所有节点
    /// - parameter relations:      图中节点中的关系
    /// - parameter isNotDirection: 边是否有方向
    ///
    /// - returns: 
    init(notes: Array<Any>, relations: Array<(Any, Any, Any)>, isNotDirection: Bool) {
        graph = []
        relationDic = [:]
        relation = []
        createGraph(notes: notes, relation: relations)
    }

    
    // MARK: - GraphType
    func createGraph(notes: Array<Any>, relation: Array<(Any, Any, Any)>){
        self.relation = relation
        
        for i in 0..<notes.count {
            let note = GraphAdjacencyListNote(data: notes[i] as AnyObject)
            graph.append(note)
            relationDic[notes[i] as! String] = i
        }
        
        for item in relation {
            guard let i = relationDic[item.0 as! String],
                let j = relationDic[item.1 as! String] else {
                    continue
            }
            
            let weightNumber: Int = Int(item.2 as! NSNumber)
            
            //将该节点挂在邻接链表上
            let note = GraphAdjacencyListNote(data: j as AnyObject, weightNumber: weightNumber)
            note.next = graph[i].next
            graph[i].next = note
        
            graph[j].weightNumber += 1  //将被挂上的节点的入度加1
        }
    }
    
    
    func displayGraph() {
        print("有向图：AOV网")
        for i in 0..<graph.count {
            print("(\(i))", separator: "", terminator: "")
            var cursor: GraphAdjacencyListNote? = graph[i]
            while cursor != nil {
                print("\(cursor!.data)(\(cursor!.weightNumber))", separator: "", terminator: "\t->  ")
                cursor = cursor?.next
            }
            print("nil")
        }
        print()
    }
}
