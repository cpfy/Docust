//
//  HandbookManagement.swift
//  Docust
//
//  Created by sage on 2020/11/8.
//  Copyright © 2020 sage. All rights reserved.
//

import Foundation
import UIKit

class Handbook{
    func getNoString(num:Int) -> String{
        var str = "No."
        
        switch(num + 1){
        case 1...9: str = str + "00"
        case 10...99: str = str + "0"
        case 100...999: break
        default: str = "?"
        }
        str = str + String(num + 1)
        return str
    }
    
    func getImageString(num:Int) -> String{
        //print(num)
        var str = ""
        if(unlockedDot[num] == 1){
            str = "dot" + String(num)
        }
        else{
            str = "question_mark"
        }
        return str
    }
    
    func rarityColorSelect(ra:rarity) -> UIColor{
        switch(ra){
            case .common: return UIColor.gray
            case .uncommon: return UIColor.green
            case .rare: return UIColor.blue
            case .epic: return UIColor.purple
            case .legendary: return UIColor.orange
        }
    }
}

var unlockedDot : [Int] = [0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,1,0,1]
