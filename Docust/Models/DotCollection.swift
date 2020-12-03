//
//  DotCollection.swift
//  Docust
//
//  Created by sage on 2020/11/6.
//  Copyright © 2020 sage. All rights reserved.
//

import Foundation

enum rarity{
    case common
    case uncommon
    case rare
    case epic
    case legendary
}

class Dot{
    var num : Int
    var quality: rarity
    var probability: Double{
        var tmp : Double
        switch(quality){
            case rarity.common: tmp = 0.30
            case rarity.uncommon: tmp = 0.40
            case rarity.rare: tmp = 0.20
            case rarity.epic: tmp = 0.08
            case rarity.legendary: tmp = 0.02
        }
        return tmp
    }
    var pattern: [Int]
    
    init(num:Int, quality:rarity, pattern:[Int]){
        self.num = num
        self.quality = quality
        //self.probability = probability
        self.pattern = pattern
    }
}

let dot1 = Dot(num:1, quality:rarity.common, pattern:[0,1,0,0,1,0,0,1,0])   //竖直线*3
let dot2 = Dot(num:2, quality:rarity.common, pattern:[0,0,0,1,1,1,0,0,0])   //一条横线
let dot3 = Dot(num:3, quality:rarity.common, pattern:[1,0,0,0,1,0,0,0,1])   //左上->右下（玉米蝇）
let dot4 = Dot(num:4, quality:rarity.uncommon, pattern:[0,1,0,1,0,1,0,1,0])     //四周+中空（西红柿）
let dot5 = Dot(num:5, quality:rarity.uncommon, pattern:[0,1,0,1,1,1,0,0,0])     //大米米法师
let dot6 = Dot(num:6, quality:rarity.uncommon, pattern:[0,1,1,0,1,0,0,1,])      //胡烛魂（旋转L型）
let dot7 = Dot(num:7, quality:rarity.rare, pattern:[0,1,0,1,1,1,0,1,0])     //十字
let dot8 = Dot(num:8, quality:rarity.rare, pattern:[1,1,1,0,1,0,0,1,0])     //T字
let dot9 = Dot(num:9, quality:rarity.epic, pattern:[1,0,1,1,1,1,0,1,0])   //逗比牛
let dot10 = Dot(num:10, quality:rarity.common, pattern:[0,1,0,1,1,0,0,0,0])   //左小三角
let dot11 = Dot(num:11, quality:rarity.common, pattern:[0,1,0,1,0,1,0,0,0])   //“品”字
let dot12 = Dot(num:12, quality:rarity.uncommon, pattern:[1,0,0,0,1,0,1,0,1])   //海胆宝宝
let dot13 = Dot(num:13, quality:rarity.uncommon, pattern:[0,0,0,1,1,0,1,1,0])     //石头蚝
let dot14 = Dot(num:14, quality:rarity.rare, pattern:[1,0,0,1,0,0,1,1,1])     //奶蜗牛L
let dot15 = Dot(num:15, quality:rarity.rare, pattern:[1,0,0,1,1,0,1,1,0])      //土豆大猩猩
let dot16 = Dot(num:16, quality:rarity.epic, pattern:[0,0,0,1,1,1,1,1,1])     //万圣猫
let dot17 = Dot(num:17, quality:rarity.legendary, pattern:[1,0,1,0,1,0,1,1,1])     //火龙果鸭
let dot18 = Dot(num:18, quality:rarity.legendary, pattern:[1,1,1,0,1,0,1,1,1])   //“工”字豆腐

let dotsData = [dot1, dot2, dot3,
                dot4, dot5, dot6,
                dot7, dot8, dot9,
                dot10, dot11, dot12,
                dot13, dot14, dot15,
                dot16, dot17, dot18]

