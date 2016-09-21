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
    
    func breadthFirstSearchTree() {
        print("邻接矩阵：树的广度搜索（BFS）:")
        initVisited()
        breadthFirstSearchTree(0)
        print("\n")
    }

    func createMiniSpanTreePrim() {
        miniTree = initGraph(graph.count)       //用来存放prim-miniTree的图结构
        createMiniSpanTreePrim(0, leafNotes: [], adjvex: [0])
        displayGraph(miniTree)
    }
    
    /**
     Prim算法思想：从已经生成的树中，遍历该树所有叶子节点所连的节点，选出一个最小的作为新的叶子节点，以此递归
     
     - parameter index:    将index对应的节点的子节点添加到候选叶子节点中
     - parameter leafNote: 所有可以发展的叶子节点
     - parameter adjvex:   已经添加到树上的节点
     */
    func createMiniSpanTreePrim(index: Int, leafNotes: Array<(Int,Int,Int)>, adjvex: Array<Int>) {
        if adjvex.count != graph.count {
            var newLeafNote = leafNotes
    
            //将该节点的所有叶子节点添加到最小生成树的候选叶子节点集合中，这些候选叶子节点是可以作为最小生成树的发展对象，不过还未加入最小生成树中
            for i in 1..<graph[index].count {
                if graph[index][i] != 0 && !adjvex.contains(i) {
                    newLeafNote.append((index, graph[index][i], i))
                }
            }
            
            var min: Int = LONG_MAX
            var minIndex = 0
            
            //找到所有最小生成树的候选叶子节点中弧度最小的那个节点，并记录下标
            for i in 0..<newLeafNote.count {
                if newLeafNote[i].1 != 0 && newLeafNote[i].1 < min {
                    min = newLeafNote[i].1
                    minIndex = i
                }
            }
        
            //0 --1--> 2
            let currentIndex = newLeafNote[minIndex].0  //节点前驱
            let minWeight = newLeafNote[minIndex].1     //权值
            let leafNoteIndex = newLeafNote[minIndex].2 //即将转正的叶子节点索引
            
            //将从候选叶子节点中选出的最小叶子节点添加到最小生成树中，进行转正
            miniTree[currentIndex][leafNoteIndex] = minWeight
            
            //转正后从候选节点中剔除转正后的叶子节点
            newLeafNote.removeAtIndex(minIndex)
            for i in 0..<newLeafNote.count {
                if newLeafNote[i].2 == leafNoteIndex {
                    newLeafNote[i].1 = 0                //将转正的候选节点的权值标记为零等效于将其删除
                }
            }
            
            //记录转正后的节点
            var tempAdjvex = adjvex
            tempAdjvex.append(leafNoteIndex)
            
            //使用转正后的节点进行递归操作
            createMiniSpanTreePrim(leafNoteIndex, leafNotes: newLeafNote, adjvex: tempAdjvex)
        }
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


