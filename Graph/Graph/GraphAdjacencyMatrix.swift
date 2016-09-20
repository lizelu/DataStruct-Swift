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
typealias MGraph = Array<Array<Int>>

class BFSQueue {
    private var queue: Array<Int> = []
    
    func pop() -> Int {
        return queue.removeFirst()
    }
    
    func push(item: Int) {
        queue.append(item)
    }
    
    func queueIsEmpty() -> Bool {
        return queue.isEmpty
    }
}

class GraphAdjacencyMatrix: GraphType {
    private var relationDic: Dictionary<String,Int>
    private var graph: MGraph
    private var visited: Array<Bool>
    private var graphData: Array<AnyObject>
    private var bfsQueue: BFSQueue
    init() {
        relationDic = [:]
        graph = []
        visited = []
        graphData = []
        bfsQueue = BFSQueue()
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
    
    func createGraph(notes: Array<AnyObject>, relation: Array<(AnyObject,AnyObject)>) {
        self.graphData = notes
        
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
    
    func displayGraph() {
        for i in 0..<graph.count {
            for j in 0..<graph[i].count {
                print(graph[i][j], separator: "", terminator: " ")
            }
            print("")
        }
        print("")
    }
    
    func breadthFirstSearch() {
        print("邻接矩阵：图的广度搜索（BFS）:")
        initVisited()
        breadthFirstSearch(0)
        print("end")
    }
    
    func depthFirstSearch() {
        print("邻接矩阵：图的深度搜索（DFS）:")
        initVisited()
        depthFirstSearch(0)
        print("end")
    }
    
    private func breadthFirstSearch(index: Int) {
        
        //如果该节点未遍历，则输出该节点的值
        if visited[index] == false {
            visited[index] = true
            print(graphData[index], separator: "", terminator: " -> ")
        }
        
        //遍历该节点所连的所有节点，并把遍历的节点入队列
        let items = graph[index]
        for i in 0..<items.count {
            if items[i] == 1 && visited[i] == false {
                print(graphData[i], separator: "", terminator: " -> ")
                visited[i] = true
                bfsQueue.push(i)
            }
        }
        
        //递归遍历队列中的子图
        while !bfsQueue.queueIsEmpty() {
            breadthFirstSearch(bfsQueue.pop())
        }
    }

    
    private func depthFirstSearch(index: Int) {
        visited[index] = true
        print(graphData[index], separator: "", terminator: " -> ")
        for subIndex in 0..<graphData.count {
            if graph[index][subIndex] == 1 && !visited[subIndex] {  //有弧，并且该弧连接的节点未被访问
                depthFirstSearch(subIndex)
            }
        }
    }
    
    private func initVisited() {
        visited.removeAll()
        for _ in 0..<graph.count {
            visited.append(false)
        }
    }
}


