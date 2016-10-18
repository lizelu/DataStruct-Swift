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

class GraphAdjacencyList {
    fileprivate var relation: Array<(Any, Any, Any)>
    fileprivate var graph: Array<GraphAdjacencyListNote>
    fileprivate var relationDic: Dictionary<String,Int>
    
    init() {
        graph = []
        relationDic = [:]
        relation = []
    }
    
    
    /// 创建无向图或者有向图
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
        createGraph(notes: notes, relation: relations, isNotDirection: isNotDirection)
    }
    
    // MARK: - GraphType
    func createGraph(notes: Array<Any>, relation: Array<(Any, Any, Any)>){
        createGraph(notes: notes, relation: relation, isNotDirection: true)
    }
    
    // MARK: - GraphType
    func createGraph(notes: Array<Any>, relation: Array<(Any, Any, Any)>, isNotDirection: Bool){
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
            
            //无向图
            if isNotDirection {
                let note1 = GraphAdjacencyListNote(data: i as AnyObject, weightNumber: weightNumber, preNoteIndex: j)
                note1.next = graph[j].next
                graph[j].next = note1
            }
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
    
    
    ///MARK: -- 迪杰斯特拉-最短路径
    
    //记录每个结点到起始结点的距离信息
    class DistanceInfo {
        var previousNoteIndex: Int = -1     //该结点的直属结点索引
        var distance: Int = LONG_MAX        //起始节点到该结点的距离
        var isInPath = false                //标记该节点是否在已生成的路径上
    }
    
    
    /// 最短路径--迪杰斯特拉算法
    ///
    /// - parameter beginIndex: 最短路径的起始结点
    /// - parameter endIndex:   最短路径的结束结点
    func shortestPathDijkstra(beginIndex: Int, endIndex: Int) {
        if beginIndex < self.graph.count && endIndex < self.graph.count {
            
            var distanceInfos: Array<DistanceInfo> = initDistanceInfo()
            distanceInfos[beginIndex].isInPath = true   //标记起始位置
            distanceInfos[beginIndex].distance = 0      //起始最短路径为0
            
            var index = beginIndex;
            while index != endIndex {
                //第一步：在目前已知的最短路径的基础上发展新的路径
                distanceInfos = countCurrentNoteAllDistance(index: index, distanceInfos: distanceInfos)
                
                //输出距离信息数组
                displayDistanceInfo(distanceInfos: distanceInfos)
                
                //第二步：查找目前已知路径中最短路径，并返回已知最短路径的下标
                index = findCurrentMiniDistanceIndex(distanceInfos: distanceInfos)
                distanceInfos[index].isInPath = true //修改标志位
            }
            
            displayShortPath(endIndex: endIndex, distanceInfo: distanceInfos)
        } else {
            print("索引非法")
        }
    }
    
    
    /// 初始化距离信息数组
    ///
    /// - returns: 返回初始化后的信息数组
    private func initDistanceInfo() -> Array<DistanceInfo> {
        var distanceInfos: Array<DistanceInfo> = []
        for _ in 0..<self.graph.count {
            distanceInfos.append(DistanceInfo())
        }
        return distanceInfos
    }
    
    
    /// 输出最短路径信息
    ///
    /// - parameter endIndex:     最短路径结束索引
    /// - parameter distanceInfo: 存储最短路径的数组
    private func displayShortPath(endIndex: Int, distanceInfo: Array<DistanceInfo>) {
        var path: Array<Int> = []  //存储最短路径的数组
        
        //串联最小路径
        var index = endIndex
        while index != -1 {
            path.append(index)
            index = distanceInfo[index].previousNoteIndex
        }
        
        //将最小路径进行进行逆转
        path.reverse()

        print("\n最短路径为：")
        for i in 0..<path.count-1 {
            let index = path[i]
            print("\(self.graph[index].data)", separator: "", terminator: "")
            var corsur = self.graph[index].next
            while corsur != nil {
                if Int(corsur?.data as! NSNumber) == path[i+1] {
                    print("--\((corsur?.weightNumber)!)", separator: "", terminator: "-->")
                    break
                }
                corsur = corsur?.next
            }
        }
        print("\(self.graph[endIndex].data)", separator: "", terminator: "")
        
        print("\n最短路径距离为：\(distanceInfo[endIndex].distance)")
    }
    
    /// 输出距离信息数组中的内容
    ///
    /// - parameter distanceInfos:
    private func displayDistanceInfo(distanceInfos: Array<DistanceInfo>) {
        //test
        for i in 0..<distanceInfos.count {
            let item = distanceInfos[i]
            
            if item.distance == LONG_MAX {
                print("\(graph[i].data)(-1)", separator: "", terminator: " ")
            } else {
                print("\(graph[i].data)(\(item.distance))", separator: "", terminator: " ")
            }
        }
        print("")
    }
    
    /// 计算链接链表数组中某一个索引对应的节点，到该节点所对应链上的每个结点的距离
    ///
    /// - parameter index:                 邻接链表上链的索引
    /// - parameter preIndexsAndDistances: 记录起始节点到每个结点的距离的数组
    ///
    /// - returns: <#return value description#>
    private func countCurrentNoteAllDistance(index: Int,
    distanceInfos: Array<DistanceInfo>) -> Array<DistanceInfo> {
        var distanceInfo = distanceInfos
        
        //遍历当前索引在邻接链表中所对应的链上的所有节点
        var listCursor = self.graph[index].next
        
        while listCursor != nil {
            
            //取出该结点对应的下标
            guard let currentNoteIndex: Int = listCursor?.data as! Int? else {
                return distanceInfos
            }
            
            //取出当前索引所对应的距离信息
            let currentDistanceInfo = distanceInfo[currentNoteIndex]
            
            //获取index节点的最短路径
            let indexNoteDistance = distanceInfo[index].distance
            
            //计算上个结点到当前节点的路径距离
            let distance: Int = indexNoteDistance + (listCursor?.weightNumber)!
            
            //如果现在的距离比之前记录的距离要小，则更新前面节点的索引以及距离。
            if distance < currentDistanceInfo.distance {
                currentDistanceInfo.previousNoteIndex = index
                currentDistanceInfo.distance = distance
                distanceInfo[currentNoteIndex] = currentDistanceInfo
            }
            
            listCursor = listCursor?.next
        }
        return distanceInfo
    }

    
    /// 查找那些未被探测的点中最小距离的下标并返回
    ///
    /// - parameter preIndexsAndDistance:每个节点距离起始结点最短距离的集合
    ///
    /// - returns:最小距离的下标
    private func findCurrentMiniDistanceIndex(distanceInfos: Array<DistanceInfo>) -> Int {
        //将当前链中的所有结点计算完路径完毕后，找出未到达且最小的那个节点继续下一轮的循环
        var minDistace = LONG_MAX
        var minIndex = 0
        for i in 0..<distanceInfos.count {
            let item = distanceInfos[i]
            //该点未探测
            if !item.isInPath {
                if item.distance < minDistace {    //找出最短的那个路径
                    minDistace = item.distance
                    minIndex = i
                }
            }
        }
        return minIndex
    }
    
}
