//
//  TimeManage.swift
//  Docust
//
//  Created by sage on 2020/11/4.
//  Copyright © 2020 sage. All rights reserved.
//

import Foundation

class Times{
    //var totalTimeOfMinute : Int
    var totalTimeOfSecond : Int
    var remainTimeOfSecond : Int
    var defaultTimeLabel : String = "25:00"
    
    init(){
        //totalTimeOfMinute = 0
        totalTimeOfSecond = 12
        remainTimeOfSecond = 10
        print("class 'time' is inited.")
    }
    
    deinit {
        print("class 'time' is deinited.")
    }
    
    func currentTime() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"// 自定义时间格式  // GMT时间 转字符串，直接是系统当前时间
        return dateformatter.string(from: Date())
    }
    
    func cutTime(time:String, tag:String) -> Int{
        var result : Int
        switch tag{
            case "hour":
                let index1 = time.index(time.startIndex, offsetBy:11)
                let index2 = time.index(time.startIndex, offsetBy:12)
                result = Int(time[index1...index2])!
            case "minute":
                let index1 = time.index(time.startIndex, offsetBy:14)
                let index2 = time.index(time.startIndex, offsetBy:15)
                result = Int(time[index1...index2])!
            case "second":
                let index1 = time.index(time.startIndex, offsetBy:17)
                let index2 = time.index(time.startIndex, offsetBy:18)
                result = Int(time[index1...index2])!
            default: return 0
        }
        return result
    }
    
    func getWelcomeText() -> String{
        let time : String = currentTime()
        var hour : Int
        //print(time)
        
        hour = cutTime(time:time, tag:"hour")
        //print(hour)
        
        switch hour{
            case 0...4 : return "Good Night!"
            case 5...8 : return "早安！"
            case 9...10 : return "上午好！"
            case 11...13 : return "中午好！"
            case 14...16 : return "下午好！"
            case 17...21 : return "晚上好！"
            case 22...23 : return "Good Night!"
            default : return "Hey！"
        }
    }
    
    func updateTimeLabel(num:Int) -> String{
        var str = ""
        
        let minute : Int = num / 60
        if(minute < 10){
            str = "0" + String(minute)
        }
        else{
            str = String(minute)
        }
        str = str + ":"
        
        let second : Int = num % 60
        if(second < 10){
            str = str + "0" + String(second)
        }
        else{
            str = str + String(second)
        }
        return str
    }
    
    func resetTimeLabel() -> String{
        return defaultTimeLabel
    }

}
