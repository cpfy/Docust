//
//  RandomSelection.swift
//  Docust
//
//  Created by sage on 2020/11/8.
//  Copyright © 2020 sage. All rights reserved.
//

import Foundation

class RandomSelection{
    var commonPool : [Int] = []
    var uncommonPool : [Int] = []
    var rarePool : [Int] = []
    var epicPool : [Int] = []
    var legendaryPool : [Int] = []
    
    var luckyValue : Double = 1.0
    let bscCommon = 0.3, bscUncommon = 0.4, bscRare = 0.2, bscEpic = 0.08, bscLegendary = 0.02
    var advCommon, advUncommon, advRare, advEpic, advLegendary : Double
    
    init(){
        advCommon = 0.0
        advUncommon = 0.0
        advRare = 0.0
        advEpic = 0.0
        advLegendary = 0.0
    }
    
    func initRarityPool(){
        for i in 0...17{
            switch(dotsData[i].quality){
            case .common : commonPool.append(i)
            case .uncommon : uncommonPool.append(i)
            case .rare : rarePool.append(i)
            case .epic : epicPool.append(i)
            case .legendary : legendaryPool.append(i)
            }
        }
    }
    
    func updateChance(){
        advLegendary = bscLegendary * luckyValue
        advEpic = bscEpic * luckyValue
        advRare = bscRare * luckyValue
        
        let tmp = advLegendary + advEpic + advRare
        advCommon = (1 - tmp) * 3.0 / 7.0
        advUncommon = (1 - tmp) * 4.0 / 7.0
    }
    
    func chooseRarity() -> rarity{
        let p = drand48()
        print("Random p = \(p)")
        updateChance()
        
        switch(p){
        case 0...advLegendary : return rarity.legendary
        case advLegendary...advLegendary + advEpic : return rarity.epic
        case advLegendary + advEpic...advLegendary + advEpic + advRare: return rarity.rare
        case advLegendary + advEpic + advRare...advLegendary + advEpic + advRare + advUncommon: return rarity.uncommon
        case advLegendary + advEpic + advRare + advUncommon...1: return rarity.common
        default: return rarity.common
        }
    }
    
    func rarityToNum(ra:rarity) -> Int{
        var num : Int
        switch(ra){
            case .common : num = commonPool.randomElement()!
            case .uncommon : num = uncommonPool.randomElement()!
            case .rare : num = rarePool.randomElement()!
            case .epic : num = epicPool.randomElement()!
            case .legendary : num = legendaryPool.randomElement()!
        }
        return num
    }
    
    func translateRarity(r:rarity) -> String{
        switch(r){
            case .common: return "普通"
            case .uncommon: return "高级"
            case .rare: return "稀有"
            case .epic: return "史诗"
            case .legendary: return "传说"
        }
    }
    
    func unlockADot() -> String{
        let rar = chooseRarity()
        let num = rarityToNum(ra: rar)
        let chineseRarity = translateRarity(r:rar)
        var str = ""
        //print("随机No：\(num)")
        //print("随机品质：\(rar)")
        //print(chineseRarity)
        
        if unlockedDot[num] == 1{
            str = String(format:"本次专注重复获得了No.%03i号Dot，已转化为幸运点数,下次概率提升", num+1)
            luckyValue *= 1.01
        }
        else if unlockedDot[num] == 0{
            unlockedDot[num] = 1
            luckyValue = 1.0
            str = String(format:"本次专注解锁了【%@】品质的No.%03i号Dot，请前往图鉴查看", chineseRarity, num+1)
        }
        else{
            print("error!")
        }
        return str
    }
}
