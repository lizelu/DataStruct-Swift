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
        displayGraph(graph)
    }
    
    func breadthFirstSearch() {
        print("邻接矩阵：图的广度搜索（BFS）:")
        initVisited()
        breadthFirstSearch(0)
        print("\n")
    }
    
    func depthFirstSearch() {
        print("邻接矩阵：图的深度搜索（DFS）:")
        initVisited()
        depthFirstSearch(0)
        print("\n")
    }
    
    func depthFirstSearchTree() {
//        print("最小生成树：深度搜索（DFS）:")
//        initVisited()
//        depthFirstSearch(0, graph: miniTree)
//        print(" --> end\n")
    }
    
    func breadthFirstSearchTree() {
        print("邻接矩阵：树的广度搜索（BFS）:")
        initVisited()
        breadthFirstSearchTree(0)
        print("\n")
    }

    
    func createMiniSpanTreePrim(index: Int, leafNote: Array<(Int,Int,Int)>, adjvex: Array<Int>) {
        if !adjvex.contains(index) {
            
            var newLeafNote = leafNote
            
            //去除已经入树，但与当前节点有弧度的点
            for i in 0..<newLeafNote.count {
                if newLeafNote[i].2 == index {
                    newLeafNote[i].1 = 0
                }
            }

            //将未入树，并且与当前节点有关联的弧添加到lowconst数组中
            for i in 1..<graph[index].count {
                if graph[index][i] != 0 && !adjvex.contains(i) {
                    newLeafNote.append((index, graph[index][i], i))
                }
            }
            
            var min: Int = LONG_MAX
            var minIndex = 0
            
            //循环找到lowcost中的最小值，并记录下其下标
            for i in 0..<newLeafNote.count {
                if newLeafNote[i].1 != 0 && newLeafNote[i].1 < min {
                    min = newLeafNote[i].1
                    minIndex = i
                }
            }
        
            
            //0 --1--> 2
            let currentIndex = newLeafNote[minIndex].0
            let minWeight = newLeafNote[minIndex].1
            let nextIndex = newLeafNote[minIndex].2
            
            miniTree[currentIndex][nextIndex] = minWeight
            newLeafNote.removeAtIndex(minIndex)
            
            var tempAdjvex = adjvex
            tempAdjvex.append(index)
            createMiniSpanTreePrim(nextIndex, leafNote: newLeafNote, adjvex: tempAdjvex)
        }
    }

    
    func miniSpanTreePrim() {
        miniTree = initGraph(graph.count)       //用来存放prim-miniTree的图结构
        createMiniSpanTreePrim(0, leafNote: [], adjvex: [])
        displayGraph(miniTree)
    }
    
    private func displayGraph(graph: MGraph) {
        for i in 0..<graph.count {
            for j in 0..<graph[i].count {
                print(graph[i][j], separator: "", terminator: "\t")
            }
            print("")
        }
        print("")
    }
    
    private func breadthFirstSearch(index: Int) {
        
        //如果该节点未遍历，则输出该节点的值
        if visited[index] == false {
            visited[index] = true
            print(graphData[index], separator: "", terminator: " ")
        }
        
        //遍历该节点所连的所有节点，并把遍历的节点入队列
        let items = graph[index]
        for i in 0..<items.count {
            if items[i] != NO_RELATION && visited[i] == false {
                print(graphData[i], separator: "", terminator: " ")
                visited[i] = true
                bfsQueue.push(i)
            }
        }
        
        //递归遍历队列中的子图
        while !bfsQueue.queueIsEmpty() {
            breadthFirstSearch(bfsQueue.pop())
        }
    }
    
    
    private func breadthFirstSearchTree(index: Int) {
        
        //遍历该节点所连的所有节点，并把遍历的节点入队列
        let items = miniTree[index]
        
        for i in 0..<items.count {
            if items[i] != NO_RELATION && visited[i] == false {
                print("\(graphData[index]) --\(miniTree[index][i])-->\(graphData[i])")
                visited[i] = true
                bfsQueue.push(i)
            }
        }
        
        //递归遍历队列中的子树
        while !bfsQueue.queueIsEmpty() {
            breadthFirstSearchTree(bfsQueue.pop())
        }
    }


    
    private func depthFirstSearch(index: Int) {
        visited[index] = true
        print(graphData[index], separator: "", terminator: " ")
        for subIndex in 0..<graphData.count {
            if graph[index][subIndex] != NO_RELATION && !visited[subIndex] {  //有弧，并且该弧连接的节点未被访问
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


