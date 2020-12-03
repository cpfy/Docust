//
//  StatsManagement.swift
//  Docust
//
//  Created by sage on 2020/11/8.
//  Copyright © 2020 sage. All rights reserved.
//

import Foundation

class timeRecord{
    var time: Int
    var date: Date
    
    init(time:Int, date:Date){
        self.time = time
        self.date = date
    }
}

class dayRecord{
    var date : Date
    var recordArray: [timeRecord]
    var totalTime: Int{
        var ans = 0
        for i in recordArray{
            ans = ans + i.time
        }
        return ans
    }
    
    init(date:Date){
        self.date = date
        recordArray = []
    }
}

class Record{
    var data: [dayRecord]
    
    init(){
        data = []
    }
}

func createData() -> Record{
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "yyyy-mm-dd"
    
    let string1 = "2020-11-07"
    let newDate1 = dateformatter.date(from: string1)
    let tR1 = timeRecord(time: 30, date: newDate1!)
    
    _ = "2020-11-06"
    let newDate2 = dateformatter.date(from: string1)
    let tR2 = timeRecord(time: 70, date: newDate2!)
    
    let dayData1: dayRecord = dayRecord(date: newDate1!)
    dayData1.recordArray.append(tR1)
    
    let dayData2: dayRecord = dayRecord(date: newDate2!)
    dayData2.recordArray.append(tR2)
    
    let emptyTime = timeRecord(time: 0, date: newDate1!)
    let emptyDay = dayRecord(date: newDate1!)
    emptyDay.recordArray.append(emptyTime)
    
    let sampleData : Record = Record()
    sampleData.data.append(dayData1)
    sampleData.data.append(dayData2)
    
    while(sampleData.data.count < 7){
        sampleData.data.append(emptyDay)
    }

    return sampleData
}

func changeTimeToString(time:Int) -> String{
    let hour : Int = time / 60
    var str = String(hour) + " " + "HR" + " "
        
    let minute : Int = time % 60
    if(minute < 10){
        str = str + "0" + String(minute)
    }
    else{
        str = str + String(minute)
    }
    str = str + " " + "MIN"
    return str
}

func sumSevenDayTotalTime(dt:Record) -> Int{
    var sum : Int = 0
    for i in 0...6{
        sum += dt.data[i].totalTime
    }
    return sum
}

func updateStats(dt:Record, sec:Int){
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "yyyy-mm-dd"
    
    let string1 = "2020-11-15"
    let newDate1 = dateformatter.date(from: string1)
    let tr1 = timeRecord(time: sec/60, date: newDate1!)
    
    dt.data[0].recordArray.append(tr1)
}

var dt : Record = createData()
