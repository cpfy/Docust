//
//  BgmPickerViewController.swift
//  Docust
//
//  Created by sage on 2020/11/17.
//  Copyright © 2020 sage. All rights reserved.
//

import UIKit

class BgmPickerViewController: UITableViewController {
    var musics : [String] = []
    var selectedBgm: String? = BgData.selectedMusic
    var selectedBgmIndex: Int? = BgData.selectedMusicIndex

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backAction))
        musics = BgData.musics
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return musics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath)
        cell.textLabel?.text = musics[indexPath.row]
        
        if indexPath.row == selectedBgmIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at:indexPath, animated: true)
        
        //Other row is selected - need to deselect it
        if let index = selectedBgmIndex{
            let cell = tableView.cellForRow(at:IndexPath(row: index,section: 0))
            cell?.accessoryType = .none
        }
        
        selectedBgmIndex = indexPath.row
        selectedBgm = musics[indexPath.row]
        BgData.selectedMusicIndex = selectedBgmIndex
        BgData.selectedMusic = selectedBgm
        
        //update the checkmark for the current row
        let cell = tableView.cellForRow(at:indexPath)
        cell?.accessoryType = .checkmark
    }
    
    @objc func backAction(){
        //print("Back Button Clicked")
        dismiss(animated: true, completion: nil)
    }
}
