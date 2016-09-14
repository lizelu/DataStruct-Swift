//
//  main.swift
//  ListDataStruct
//
//  Created by ZeluLi on 16/9/11.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

let array = "a,b,c,d,e,f,g".componentsSeparatedByString(",")

//let sequcenceList: SequenceList = SequenceList(capacity: 10)
//
//for item in array {
//    sequcenceList.addItem(item)
//}
//sequcenceList.displayList()
//
//sequcenceList.insert("z", index: 0)
//sequcenceList.removeItme(1)
//sequcenceList.modify(3, newItem: "m")
//
//sequcenceList.displayList()

let oneDirectionLinkList = OneDirectionLinkList()
oneDirectionLinkList.forwardDirectionCreateList(array)
oneDirectionLinkList.display()
oneDirectionLinkList.removeAllItem()
oneDirectionLinkList.reverseDirectionCreateList(array)
oneDirectionLinkList.display()
        