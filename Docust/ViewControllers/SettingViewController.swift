//
//  SettingViewController.swift
//  Docust
//
//  Created by sage on 2020/11/16.
//  Copyright © 2020 sage. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {
    
    @IBOutlet weak var musicSwitch: UISwitch!
    
    @IBAction func switchValueChanged(_ sender: Any) {
        BgData.musicOn = musicSwitch.isOn
        print(BgData.musicOn)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
