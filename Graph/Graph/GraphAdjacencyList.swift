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
    var weightNumber: Int   //权值，最小生成树使用
    var preNoteIndex: Int   //最小生成树使用, 记录该节点挂在那个链上
    
    var next: GraphAdjacencyListNote?
    var visited: Bool = false
    
    init(data: AnyObject = "" as AnyObject, weightNumber: Int = 0, preNoteIndex: Int = 0) {
        self.data = data
        self.weightNumber = weightNumber
        self.preNoteIndex = preNoteIndex
    }
}

class GraphAdjacencyList: GraphType {
    fileprivate var relation: Array<(Any, Any, Any)>
    fileprivate var graph: Array<GraphAdjacencyListNote>
    fileprivate var miniTree: Array<GraphAdjacencyListNote>
    fileprivate var relationDic: Dictionary<String,Int>
    fileprivate var bfsQueue: BFSQueue
    
    init() {
        graph = []
        relationDic = [:]
        bfsQueue = BFSQueue()
        miniTree = []
        relation = []
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
            let note2 = GraphAdjacencyListNote(data: j as AnyObject, weightNumber: weightNumber,preNoteIndex: i)
            note2.next = graph[i].next
            graph[i].next = note2
            
            let note1 = GraphAdjacencyListNote(data: i as AnyObject, weightNumber: weightNumber, preNoteIndex: j)
            note1.next = graph[j].next
            graph[j].next = note1
        }
    }
    
    func displayGraph() {
        displayGraph(graph: graph)
    }
    
    func displayGraph(graph: Array<GraphAdjacencyListNote>) {
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

    
    func breadthFirstSearch() {
        print("邻接链表：图的广度搜索（BFS）:")
        initVisited()
        breadthFirstSearch(index: 0)
        print("\n")
    }
    
    func depthFirstSearch() {
        print("邻接链表：图的深度搜索（DFS）:")
        initVisited()
        depthFirstSearch(index: 0)
        print("\n")
    }
    
    func breadthFirstSearchTree() {
        print("最小生成树边的遍历:")
        for index in 0..<miniTree.count {
            //遍历该节点所连的所有节点，并把遍历的节点入队列
            var cousor = miniTree[index].next
            while cousor != nil {
                let nextIndex: Int = Int((cousor?.data)! as! NSNumber)
                print("\(miniTree[index].data)--\((cousor?.weightNumber)!)-->\(miniTree[nextIndex].data)")
                cousor = cousor?.next
            }
        }
        print("\n")
    }
    
    /**
     创建最小生成树: Kruskal
     */
    func createMiniSpanTreeKruskal(){
        print("克鲁斯卡尔算法：")
        configMiniTree()
        //对权值从小到大进行排序
        let sortRelation = relation.sorted { (item1, item2) -> Bool in
            return  Int(item1.2 as! NSNumber) < Int(item2.2 as! NSNumber)
        }
        
        //记录节点的尾部节点，避免出现闭环
        var parent = Array.init(repeating: -1, count: miniTree.count)
        
        for item in sortRelation {
            let beginNoteIndex = self.relationDic[item.0 as! String]!
            let endNoteIndex = self.relationDic[item.1 as! String]!
            let weightNumber = item.2 as! Int
            
            let preEndIndex = findEndIndex(parent: parent, index: beginNoteIndex)
            let nextEndIndex = findEndIndex(parent: parent, index: endNoteIndex)
            
            
            if preEndIndex != nextEndIndex {
                parent[preEndIndex] = nextEndIndex
            
                insertNoteToMiniTree(preIndex: beginNoteIndex, linkIndex: endNoteIndex, weightNumber: weightNumber);
            }
        }
        
        displayGraph(graph: miniTree)
    }
    
    private func insertNoteToMiniTree(preIndex: Int, linkIndex: Int, weightNumber: Int) {
        let note = GraphAdjacencyListNote(data: linkIndex as AnyObject, weightNumber: weightNumber, preNoteIndex: preIndex)
        note.next = miniTree[preIndex].next
        miniTree[preIndex].next = note
    }
    
    private func findEndIndex(parent: Array<Int>, index: Int) -> Int {
        var endIndex = index
        while parent[endIndex] > -1 {
            endIndex = parent[endIndex]
        }
        return endIndex
    }

    
    /**
     创建最小生成树: Prim
     */
    func createMiniSpanTreePrim() {
        print("prim算法: ")
        configMiniTree()
        createMiniSpanTreePrim(index: 0, leafNotes: [], adjvex: [0])
        displayGraph(graph: miniTree)
    }
    
    private func configMiniTree() {
        miniTree.removeAll()
        for i in 0..<graph.count {
            let note = GraphAdjacencyListNote(data: graph[i].data)
            miniTree.append(note)
        }

    }
    
    private func createMiniSpanTreePrim(index: Int, leafNotes: Array<GraphAdjacencyListNote>, adjvex: Array<Int>)  {
        if adjvex.count != graph.count {
            
            var varLeafNotes = leafNotes
            
            //1、添加候选叶子节点
            var cousor = graph[index].next

            while cousor != nil {
                let cousorData: Int = Int((cousor?.data)! as! NSNumber)
                if !adjvex.contains(cousorData) && cousor?.weightNumber != 0 {
                    varLeafNotes.append(cousor!)
                }
                cousor = cousor?.next
            }
            
            //2、寻找候选叶子节点中最小的权值，确定其能转正
            var minNoteIndex = 0
            var min = LONG_MAX
            for i in 0..<varLeafNotes.count {
                let weightNumber: Int = varLeafNotes[i].weightNumber
                if weightNumber != 0 && weightNumber < min {
                    minNoteIndex = i
                    min = weightNumber
                }
            }
            
            //3、将这个最小的候选叶子节点添加到最小生成树中
            let minLeafNode = varLeafNotes[minNoteIndex]
            let preIndex = minLeafNode.preNoteIndex
            
            let newLeafNote1 = GraphAdjacencyListNote(data: minLeafNode.data, weightNumber: minLeafNode.weightNumber, preNoteIndex: preIndex)
            newLeafNote1.next = miniTree[preIndex].next
            miniTree[preIndex].next = newLeafNote1
            
            
            //4、将已经转正的叶子节点从候选叶子节点中删除
            let minLeafNoteData: Int = Int(minLeafNode.data as! NSNumber)
            for i in 0..<varLeafNotes.count {
                let cousorData: Int = Int(varLeafNotes[i].data as! NSNumber)
                if cousorData == minLeafNoteData {
                    varLeafNotes[i].weightNumber = 0
                }
            }
            
            //5.记录下已转正的节点
            var tempAdjvex = adjvex
            tempAdjvex.append(minLeafNoteData)
            
            //6.递归下一个节点
            createMiniSpanTreePrim(index: minLeafNoteData, leafNotes: varLeafNotes, adjvex: tempAdjvex)
        }
    }
    
    
    private func breadthFirstSearch(index: Int) {
        if graph[index].visited == false {      //如果该节点未遍历，则输出该节点的值
            print(graph[index].data, separator: "", terminator: " ")
            graph[index].visited = true
            
            //遍历完当前结点后，将与该结点相连接的并且未被遍历的结点进入队列
            var cousor = graph[index].next
            while cousor != nil {
                let nextIndex: Int = Int((cousor?.data)! as! NSNumber)
                if graph[nextIndex].visited == false {
                    bfsQueue.enQueue(item: nextIndex)
                }
                cousor = cousor?.next
            }
            
            //递归遍历队列中的子图
            while !bfsQueue.queueIsEmpty() {
                breadthFirstSearch(index: bfsQueue.deQueue())
            }
        }
    }

    
    private func depthFirstSearch(index: Int) {
        print(graph[index].data, separator: "", terminator: " ")
        graph[index].visited = true
        
        var cousor = graph[index].next
        while cousor != nil {
            let nextIndex: Int = Int((cousor?.data)! as! NSNumber)
            if graph[nextIndex].visited == false {
                depthFirstSearch(index: Int((cousor?.data)! as! NSNumber))
            }
            cousor = cousor?.next
        }
    }
    
    fileprivate func initVisited() {
        for item in graph {
            item.visited = false
        }
    }
}

