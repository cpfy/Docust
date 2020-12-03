//
//  BackgroundPickerViewController.swift
//  Docust
//
//  Created by sage on 2020/11/17.
//  Copyright © 2020 sage. All rights reserved.
//

import UIKit

class BackgroundPickerViewController: UITableViewController {
    var backgrounds : [String] = []
    var selectedBackground: String? = BgData.selectedBg
    var selectedBackgroundIndex: Int? = BgData.selectedBgIndex
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backAction))
        backgrounds = BgData.backgrounds
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return backgrounds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BackgroundCell", for: indexPath)
        cell.textLabel?.text = backgrounds[indexPath.row]
        
        if indexPath.row == selectedBackgroundIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at:indexPath, animated: true)
        
        //Other row is selected - need to deselect it
        if let index = selectedBackgroundIndex{
            let cell = tableView.cellForRow(at:IndexPath(row: index,section: 0))
            cell?.accessoryType = .none
        }
        
        selectedBackgroundIndex = indexPath.row
        selectedBackground = backgrounds[indexPath.row]
        BgData.selectedBgIndex = selectedBackgroundIndex
        BgData.selectedBg = selectedBackground
        
        //update the checkmark for the current row
        let cell = tableView.cellForRow(at:indexPath)
        cell?.accessoryType = .checkmark
    }
    
    @objc func backAction(){
        //print("Back Button Clicked")
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
