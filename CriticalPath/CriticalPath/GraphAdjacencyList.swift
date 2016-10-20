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
    var index: Int
    var weightNumber: Int   //权值或者入度
    var next: GraphAdjacencyListNote?
    
    init(index: Int, weightNumber: Int = 0) {
        self.index = index
        self.weightNumber = weightNumber
    }
}

class Stack {
    private var stack: Array<GraphAdjacencyListNote> = []
    
    func isEmpty() -> Bool {
        return stack.isEmpty
    }
    
    func push(note: GraphAdjacencyListNote) {
        stack.append(note)
    }
    
    func top() -> GraphAdjacencyListNote? {
        if !isEmpty() {
            return stack.last
        }
        return nil
    }

    func popAllItem() {
        stack.removeAll()
    }
    
    func pop() -> GraphAdjacencyListNote? {
        if !isEmpty() {
           return stack.removeLast()
        }
        return nil
    }
}

class Queue {
    private var queue: Array<GraphAdjacencyListNote> = []
    
    func count() -> Int {
        return queue.count
    }
    
    func isEmpty() -> Bool {
        return queue.isEmpty
    }
    
    func enQueue(note: GraphAdjacencyListNote) {
        queue.append(note)
    }
    
    func deQueue() -> GraphAdjacencyListNote? {
        if !isEmpty() {
            return queue.removeFirst()
        }
        return nil
    }
    
    func display() {
        for item in queue {
            print(item.index, separator: "", terminator: " ")
        }
        print()
    }
    
    func getQueueArray() -> Array<GraphAdjacencyListNote> {
        return queue;
    }
}



class GraphAdjacencyList {
    fileprivate var relation: Array<(Any, Any, Any)>
    fileprivate var graph: Array<GraphAdjacencyListNote>
    fileprivate var relationDic: Dictionary<String,Int>
    fileprivate var notes: Array<Any>
    
    fileprivate var topoLogicalNoteQueue: Queue = Queue()
    
    fileprivate var etv: Array<Int> = []
    
    
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
        self.notes = notes
        createGraph(notes: notes, relation: relations)
    }

    
    // MARK: - GraphType
    func createGraph(notes: Array<Any>, relation: Array<(Any, Any, Any)>){
        self.relation = relation
        
        for i in 0..<notes.count {
            let note = GraphAdjacencyListNote(index: i)
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
            let note = GraphAdjacencyListNote(index: j, weightNumber: weightNumber)
            note.next = graph[i].next
            graph[i].next = note
        
            graph[j].weightNumber += 1  //将被挂上的节点的入度加1
        }
    }
    
    
    
    func topoLogicalSort() {
        let stack: Stack = Stack()
        
        for _ in 0..<graph.count {
            etv.append(0)
        }
        
        //将入度为0的结点入栈
        for item in graph {
            if item.weightNumber == 0 {
                stack.push(note: item)
            }
        }
        
        while !stack.isEmpty() {
            guard let note = stack.pop() else {
                return
            }
            topoLogicalNoteQueue.enQueue(note: note)
            
            var cursor = note.next
            while cursor != nil {
                //因为index对应的节点进入了Topo排序的队列，所以将该节点到达的结点的入度减一
                let index = (cursor?.index)!
                graph[index].weightNumber -= 1
                
                //减一后，如果入度为0，则进入栈
                if graph[index].weightNumber == 0  {
                    stack.push(note: graph[index])
                }
                
                //求出每个事件的最早发生的时间
                let updateDistance = etv[note.index] + (cursor?.weightNumber)!
                if updateDistance > etv[(cursor?.index)!] {
                    etv[(cursor?.index)!] = updateDistance
                }
                
                cursor = cursor?.next
            }
        }
        displaytopoLogicalNoteQueue()
        print("\n事件最小时间序列为：")
        print(etv)
        
    }

    
    func criticalPath() {
        let topoLogicalNoteStack: Stack = Stack()
        for note in topoLogicalNoteQueue.getQueueArray() {
            topoLogicalNoteStack.push(note: note)
        }
        
        var ltv: Array<Int> = []
        for _ in 0..<graph.count {
            ltv.append(etv[(topoLogicalNoteStack.top()?.index)!])
        }
        
        
        while !topoLogicalNoteStack.isEmpty() {
            let note = topoLogicalNoteStack.pop()
            var cursor = note?.next
            while cursor != nil {
                let updateDistance = ltv[(cursor?.index)!] - (cursor?.weightNumber)!
                if updateDistance < ltv[(note?.index)!]{
                    ltv[(note?.index)!] = updateDistance
                }
                cursor = cursor?.next
            }
        }
        print("\n事件最大时间序列为：")
        print(ltv)
        
        print("\n关键路径为：")
        var sum = 0
        for i in 0..<graph.count {
            var cursor = graph[i].next
            while cursor != nil {
                guard let index = cursor?.index,
                    let weightNumber = cursor?.weightNumber else {
                    return
                }
                
                //如果最小时间与最大时间相等，那么该结点就是关键点
                if etv[i] == ltv[index] - weightNumber {
                    print("\(notes[graph[i].index])--\(weightNumber)-->\(notes[index])")
                    sum += weightNumber
                }
                cursor = cursor?.next
            }
        }
        
        print("\n所需总时间为：")
        print(sum)

    }
    
    
    
    func displaytopoLogicalNoteQueue() {
        
        if topoLogicalNoteQueue.count() == graph.count {
            //输出topo排序的序列
            print("拓扑排序的序列为：")
            for note in topoLogicalNoteQueue.getQueueArray() {
                print(notes[note.index], separator: "", terminator: ", ")
            }
            print()
        } else {
            print("图中存在环路，不存在topo序列")
        }
    }
    
    func displayGraph() {
        print("有向图：AOV网")
        for i in 0..<graph.count {
            print("(\(i))", separator: "", terminator: "")
            print("\(notes[i])(\(graph[i].weightNumber))", separator: "", terminator: "\t->  ")
            var cursor: GraphAdjacencyListNote? = graph[i].next
            while cursor != nil {
                print("\(cursor!.index)(\(cursor!.weightNumber))", separator: "", terminator: "\t->  ")
                cursor = cursor?.next
            }
            print("nil")
        }
        print()
    }
}
