//
//  StatsViewController.swift
//  Docust
//
//  Created by sage on 2020/11/8.
//  Copyright © 2020 sage. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var timeStatsLabel: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        timeStatsLabel.text = changeTimeToString(time: dt.data[0].totalTime)
         // Do any additional setup after loading the view.
    }
    
    
    @IBAction func pressToday(_ sender: UIButton) {
        timeStatsLabel.text = changeTimeToString(time: dt.data[0].totalTime)
    }
    
    @IBAction func pressYesterday(_ sender: UIButton) {
        timeStatsLabel.text = changeTimeToString(time: dt.data[1].totalTime)
    }
    
    @IBAction func pressSevenDay(_ sender: UIButton) {
        let sum = sumSevenDayTotalTime(dt:dt)
        timeStatsLabel.text = changeTimeToString(time: sum)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
