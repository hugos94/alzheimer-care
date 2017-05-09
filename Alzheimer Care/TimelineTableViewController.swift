//
//  TimelineTableViewController.swift
//  Alzheimer Care
//
//  Created by Hugo Santos Piauilino Neto on 07/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import UIKit
import AVFoundation

class TimelineTableViewController: UITableViewController, AVAudioPlayerDelegate, MemoryEnteredDelegate {
    
    var listOfMemories: [Memory] = []
    
    var audioRecorder    :AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfMemories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoryCell", for: indexPath)
        
        let memory = self.listOfMemories[indexPath.row]
        
        if let memoryCell = cell as? MemoryTableViewCell {
            memoryCell.memoryNameLabel.text = memory.name
            memoryCell.memoryDateLabel.text = memory.getFormattedData()
            memoryCell.onButtonTapped = {
            }
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listOfMemories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addMemorySegue" {
            if let addNavigationController = segue.destination as? UINavigationController {
                if let addMemoryViewController: AddMemoryViewController = addNavigationController.viewControllers.first as? AddMemoryViewController {
                    addMemoryViewController.delegate = self
                }
            }
        }
        
    }
    
    func userDidEnterInformation(memory: Memory) {
        listOfMemories.append(memory)
    }

}
