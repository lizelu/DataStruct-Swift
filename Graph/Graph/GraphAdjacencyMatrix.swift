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
    private var miniTree: MGraph
    private var visited: Array<Bool>
    private var graphData: Array<AnyObject>
    private var bfsQueue: BFSQueue
    init() {
        relationDic = [:]
        graph = []
        miniTree = []
        visited = []
        graphData = []
        bfsQueue = BFSQueue()
    }
    
    private func configData(notes: Array<AnyObject>) {
        for i in 0..<notes.count {
            relationDic[notes[i] as! String] = i
        }
        graph = initGraph(notes.count)
    }
    
    private func initGraph(count: Int) -> MGraph{
        var graph: MGraph = MGraph()
        for _ in 0..<count {
            var temp:Array<Int> = []
            for _ in 0..<count {
                temp.append(NO_RELATION)
            }
            graph.append(temp)
        }
        return graph
    }
    
    func createGraph(notes: Array<AnyObject>, relation: Array<(AnyObject,AnyObject,AnyObject)>) {
        self.graphData = notes
        
        configData(notes)
        
        //根据关系创建图
        for item in relation {
            guard let i = relationDic[item.0 as! String],
                j = relationDic[item.1 as! String] else {
                    continue
            }
            let weightNumber: Int = Int(item.2 as! NSNumber)
            graph[i][j] = weightNumber
            graph[j][i] = weightNumber
        }
        
    }
    
    func displayGraph() {
        for i in 0..<graph.count {
            for j in 0..<graph[i].count {
                print(graph[i][j], separator: "", terminator: "\t")
            }
            print("")
        }
        print("")
    }
    
    func breadthFirstSearch() {
        print("邻接矩阵：图的广度搜索（BFS）:")
        initVisited()
        breadthFirstSearch(0)
        print(" --> end\n")
    }
    
    func depthFirstSearch() {
        print("邻接矩阵：图的深度搜索（DFS）:")
        initVisited()
        depthFirstSearch(0)
        print(" --> end\n")
    }
    
    func miniSpanTreePrim() {
        miniTree = initGraph(graph.count)       //用来存放prim-miniTree的图结构
        
        var lowcost: Array<Int> = []   //用来存放发展最小生成树要比较的路径
        
        //将图中与第一个节点所连的所有权值添加到lowconst
        for i in 0..<graph.count {
            lowcost.append(graph[0][i])
        }
        
        for i in 0..<graph.count {
            var min: Int = LONG_MAX
            var minNumberIndex = 0
            
            //循环找到lowcost中的最小值，并记录下其下标
            for i in 0..<lowcost.count {
                if lowcost[i] != 0 && lowcost[i] < min {
                    min = lowcost[i]
                    minNumberIndex = i
                }
            }
            
            //将该下标和权值，存入新的树中, 并将已经进入树中的最小值进行移除
            miniTree[i][minNumberIndex] = lowcost.removeAtIndex(minNumberIndex)
            
            //将这个进入miniTree的节点的所有权值加入到lowcost中
            for item in graph[minNumberIndex] {
                if item != 0 {
                    lowcost.append(item)
                }
            }
        }
    }
    
    private func breadthFirstSearch(index: Int) {
        
        //如果该节点未遍历，则输出该节点的值
        if visited[index] == false {
            visited[index] = true
            print(graphData[index], separator: "", terminator: "")
        }
        
        //遍历该节点所连的所有节点，并把遍历的节点入队列
        let items = graph[index]
        for i in 0..<items.count {
            if items[i] != NO_RELATION && visited[i] == false {
                print(" --\(items[i])", separator: "", terminator: "--> ")
                print(graphData[i], separator: "", terminator: "")
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
        print(graphData[index], separator: "", terminator: "")
        for subIndex in 0..<graphData.count {
            if graph[index][subIndex] != NO_RELATION && !visited[subIndex] {  //有弧，并且该弧连接的节点未被访问
                print(" --\(graph[index][subIndex])", separator: "", terminator: "--> ")
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


