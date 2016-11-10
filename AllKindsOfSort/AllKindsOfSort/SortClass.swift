//
//  BubbleSort.swift
//  AllKindsOfSort
//
//  Created by Mr.LuDashi on 16/11/4.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

/// 冒泡排序：时间复杂度----O(n^2)
class BubbleSort: SortType {
    func sort(items: Array<Int>) -> Array<Int> {
        print("冒泡排序：")
        var list = items
        for i in 0..<list.count {
            print("第\(i + 1)轮冒泡：")
            var j = list.count - 1
            while j > i {
                if list[j - 1] > list[j]  { //前边的大于后边的则进行交换
                    print("\(list[j - 1]) > \(list[j]): 进行交换")
                    let temp = list[j]
                    list[j] = list[j - 1]
                    list[j - 1] = temp
                } else {
                    print("\(list[j - 1]) <= \(list[j]): 不进行交换")
                }
                j = j - 1
            }
            print("第\(i + 1)轮冒泡结束，当前结果为：")
            print("\(list)\n")
        }
        return list
    }
}


/// 插入排序-O(n^2)
class InsertSort: SortType{
    func sort(items: Array<Int>) -> Array<Int> {
        print("插入排序")
        var list = items
        for i in 1..<list.count {   //循环无序数列
            print("第\(i)轮插入：")
            print("要选择插入的值为：\(list[i])")
            var j = i
            while j > 0 {           //循环有序数列，插入相应的值
                if list[j] < list[j - 1]  {
                    
                    let temp = list[j]
                    list[j] = list[j-1]
                    list[j-1] = temp
                    
                    j = j - 1
                } else {
                    break
                }
            }
            print("插入的位置为：\(j)")
            print("本轮插入完毕, 插入结果为：\n\(list)\n")
        }
        return list
    }
}

//希尔排序：时间复杂度----O(n^(3/2))
class ShellSort: SortType {
    func sort(items: Array<Int>) -> Array<Int> {
        print("希尔排序")
        var list = items
        var step: Int = list.count / 2
        while step > 0 {
            print("步长为\(step)的插入排序开始：")
            for i in 0..<list.count {
                var j = i + step
                while j >= step && j < list.count {
                    if list[j] < list[j - step]  {
                        let temp = list[j]
                        list[j] = list[j-step]
                        list[j-step] = temp
                        j = j - step
                    } else {
                        break
                    }
                }
            }
            print("步长为\(step)的插入排序结束")
            print("本轮排序结果为：\(list)\n")
            step = step / 2     //缩小步长
        }
        return list
    }
}

/// 简单选择排序－O(n^2)
class SimpleSelectionSort: SortType {
    func sort(items: Array<Int>) -> Array<Int> {
        print("简单选择排序")
        var list = items
        for i in 0..<list.count {
            print("第\(i+1)轮选择，选择下标的范围为\(i)----\(list.count)")
            var j = i + 1
            var minValue = list[i]
            var minIndex = i
            
            //寻找无序部分中的最小值
            while j < list.count {
                if minValue > list[j] {
                    minValue = list[j]
                    minIndex = j
                }
                j = j + 1
            }
            print("在后半部分乱序数列中，最小值为：\(minValue), 下标为：\(minIndex)")
            //与无序表中的第一个值交换，让其成为有序表中的最后一个值
            if minIndex != i {
                print("\(minValue)与\(list[i])交换")
                let temp = list[i]
                list[i] = list[minIndex]
                list[minIndex] = temp
            }
            print("本轮结果为：\(list)\n")
        }
        return list
        
    }
}



/// 堆排序
class HeapSort: SortType {
    
    func sort(items: Array<Int>) -> Array<Int> {
        print("堆排序：")
        var list = items
        var endIndex = items.count - 1
        
        //创建大顶堆，其实就是将list转换成大顶堆层次的遍历结果
        heapCreate(items: &list)

        print("原始堆：\(list)")
        while endIndex > 0 {
            //将大顶堆的顶点（最大的那个值）与大顶堆的最后一个值进行交换
            print("将list[0]:\(list[0])与list[\(endIndex)]:\(list[endIndex])交换")
            let temp = list[0]
            list[0] = list[endIndex]
            list[endIndex] = temp
            
            endIndex -= 1   //缩小大顶堆的范围
            
            //对交换后的大顶堆进行调整，使其重新成为大顶堆
            heapAdjast(items: &list, endIndex: endIndex + 1)
            print("调整后:\(list)\n")
        }
        return list
    }
    
    
    /// 构建大顶堆的层次遍历序列（f(i) > f(2i), f(i) > f(2i+1) i > 0）
    ///
    /// - parameter items:    构建大顶堆的序列
    func heapCreate(items: inout Array<Int>) {
        var cursorIndex = items.count
        while cursorIndex > 0 {
            
            //调整当前索引所有父节点，使其符合大顶堆的特点
            var maxChildIndex = cursorIndex
            while maxChildIndex / 2 > 0 {
                let fatherIndex = maxChildIndex / 2 //求出当前节点的父节点
                //找出两个子节点中较大的那个节点的下标
                if items[maxChildIndex - 1] < items[maxChildIndex - 2] {
                    maxChildIndex = maxChildIndex - 1
                }
                
                //将该节点与父节点进行交换
                if items[maxChildIndex - 1] > items[fatherIndex - 1] {
                    print("将list[\(maxChildIndex-1)]=\(items[maxChildIndex - 1])与"
                        , separator:"", terminator:"")
                    print("父节点list[\(fatherIndex-1)]=\(items[fatherIndex - 1])进行交换")
                    let temp = items[maxChildIndex - 1]
                    items[maxChildIndex - 1] = items[fatherIndex - 1]
                    items[fatherIndex - 1] = temp
                }
                
                //将结果往上传递
                maxChildIndex = fatherIndex
            }

            cursorIndex -= 2
            print("本轮调整结果如下：")
            print("\(items)\n")
        }
        print("大顶堆构层次遍历序列建完毕\n\n")
    }
    
    /// 对大顶堆的局部进行调整，使其该节点的所有父类符合大顶堆的特点
    ///
    /// - parameter items:    list
    /// - parameter endIndex: 当前要调整的节点
    func heapAdjast(items: inout Array<Int>, endIndex: Int) {
        let temp = items[0]                 //暂存要调整的根节点
        var fatherIndex = 1                 //父节点下标
        var maxChildIndex = 2 * fatherIndex //左孩子下标
        while maxChildIndex <= endIndex {
            
            //比较左右孩子并找出比较大的下标
            if maxChildIndex < endIndex &&
                items[maxChildIndex-1] < items[maxChildIndex] {
                maxChildIndex = maxChildIndex + 1
            }
            
            //如果较大的那个子节点比根节点大，就将该节点的值赋给父节点
            if temp < items[maxChildIndex-1] {
                items[fatherIndex-1] = items[maxChildIndex-1]
            } else {
                break;
            }
            fatherIndex = maxChildIndex
            maxChildIndex = 2 * fatherIndex
        }
        items[fatherIndex-1] = temp;
    }

}

class MergingSort: SortType {
    
    func sort(items: Array<Int>) -> Array<Int> {
        
        //将数组中的每一个元素放入一个数组中
        var tempArray: Array<Array<Int>> = []
        for item in items {
            var subArray: Array<Int> = []
            subArray.append(item)
            tempArray.append(subArray)
        }
        
        //对这个数组中的数组进行合并，直到合并完毕为止
        while tempArray.count != 1 {
            print(tempArray)
            var i = 0
            while i < tempArray.count - 1 {
                print("将\(tempArray[i])与\(tempArray[i+1])合并")
                tempArray[i] = mergeArray(firstList: tempArray[i], secondList: tempArray[i + 1])
                print("合并结果为：\(tempArray[i])\n")
                tempArray.remove(at: i + 1)
                i = i + 1
            }
        }

        return tempArray.first!
    }
    
    
    /// 归并排序中的“并”--合并：将两个有序数组进行合并
    ///
    /// - parameter firstList:  第一个有序数组
    /// - parameter secondList: 第二个有序数组
    ///
    /// - returns: 返回排序好的数组
    func mergeArray(firstList: Array<Int>, secondList: Array<Int>) -> Array<Int> {
        var resultList: Array<Int> = []
        var firstIndex = 0
        var secondIndex = 0
        
        while firstIndex < firstList.count && secondIndex < secondList.count {
            if firstList[firstIndex] < secondList[secondIndex] {
                resultList.append(firstList[firstIndex])
                firstIndex += 1
            } else {
                resultList.append(secondList[secondIndex])
                secondIndex += 1
            }
        }
        
        while firstIndex < firstList.count {
            resultList.append(firstList[firstIndex])
            firstIndex += 1
        }
        
        while secondIndex < secondList.count {
            resultList.append(secondList[secondIndex])
            secondIndex += 1
        }
        
        return resultList
    }
}


