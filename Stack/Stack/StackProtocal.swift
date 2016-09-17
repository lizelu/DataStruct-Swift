//
//  StackProtocal.swift
//  Stack
//
//  Created by ZeluLi on 16/9/17.
//  Copyright © 2016年 zeluli. All rights reserved.
//

import Foundation

protocol StackType {
    func push(imte: AnyObject)
    func pop() -> AnyObject
    func getTop() -> AnyObject?
    func stackLength() -> Int
    func stackIsEmpty() -> Bool
    func clearStack()
}