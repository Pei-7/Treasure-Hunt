//
//  map.swift
//  Treasure Hunt
//
//  Created by 陳佩琪 on 2023/6/8.
//

import Foundation

enum Map {
    case lion, hills, swamp, forest, lake, cabin, key, none, startPoint, endPoint
    
    var imageName: String {
        switch self {
        case .lion:
            return "lion"
        case .hills:
            return "hills"
        case .swamp:
            return "swamp"
        case .forest:
            return "forest"
        case .lake:
            return "lake"
        case .cabin:
            return "cabin"
        case .key:
            return "key"
        case .none:
            return " "
        case .startPoint:
            return " "
        case .endPoint:
            return " "
        }
    }
        
        
    var description: String {
        switch self {
        case .lion:
            return "遇到了獅子快逃跑！\n- ⚡️⚡️⚡️⚡️⚡️"
        case .hills:
            return "翻越了好高的山。\n-  ⚡️⚡️⚡️⚡️"
        case .swamp:
            return "渡過了沼澤。\n- ⚡️⚡️⚡️"
        case .forest:
            return "在森林中迷路了。\n- ⚡️⚡️"
        case .lake:
            return "在湖邊梳洗一番。\n+ ⚡️"
        case .cabin:
            return "在小木屋中睡了一夜。\n+ ⚡️⚡️"
        case .key:
            return "找到了寶箱鑰匙！\n- ⚡️"
        case .none:
            return "什麼也沒有發生。\n- ⚡️"
        case .startPoint:
            return "什麼也沒有發生。\n- ⚡️"
        case .endPoint:
            return "抵達終點。"
        }
    }
            

    var energyChange: Int {
            switch self {
            case .lion:
                return -5
            case .hills:
                return -4
            case .swamp:
                return -3
            case .forest:
                return -2
            case .lake:
                return 1
            case .cabin:
                return 2
            case .key:
                return -1
            case .none:
                return -1
            case .startPoint:
                return 0
            case .endPoint:
                return -1
            }
    }
    

    static var iconsArray: [Map] = Array(repeating: .lion, count: 1) + Array(repeating: .hills, count: 2) + Array(repeating: .swamp, count: 3) + Array(repeating: .forest, count: 4) + Array(repeating: .lake, count: 4) + Array(repeating: .cabin, count: 1) + [.key] + Array(repeating: .none, count: 7)


}
