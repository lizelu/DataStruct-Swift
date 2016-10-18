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
        bfsQueue = BFSQueue()
        miniTree = []
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
            
            print("\(beginNoteIndex)--\(weightNumber)-->\(endNoteIndex)")
            
            if preEndIndex != nextEndIndex {
                
                parent[preEndIndex] = nextEndIndex //更新尾部节点
                insertNoteToMiniTree(preIndex: beginNoteIndex,
                                     linkIndex: endNoteIndex,
                                     weightNumber: weightNumber);
            }
        }
        
        displayGraph(graph: miniTree)
    }
    
    ///将合适的节点插入到新的邻接链表中
    private func insertNoteToMiniTree(preIndex: Int,
                                      linkIndex: Int,
                                      weightNumber: Int) {
        let note = GraphAdjacencyListNote(data: linkIndex as AnyObject,
                                          weightNumber: weightNumber,
                                          preNoteIndex: preIndex)
        note.next = miniTree[preIndex].next
        miniTree[preIndex].next = note
    }
    
    
    /// 查找当前节点的尾部节点
    ///
    /// - parameter parent: 存储尾部节点的个个信息
    /// - parameter index:  当前结点
    ///
    /// - returns: endIndex
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
    
    private func createMiniSpanTreePrim(index: Int,
                                        leafNotes: Array<GraphAdjacencyListNote>,
                                        adjvex: Array<Int>)  {
        
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
            
            let newLeafNote1 = GraphAdjacencyListNote(data: minLeafNode.data,
                                                      weightNumber: minLeafNode.weightNumber,
                                                      preNoteIndex: preIndex)
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
            createMiniSpanTreePrim(index: minLeafNoteData,
                                   leafNotes: varLeafNotes,
                                   adjvex: tempAdjvex)
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
