//
//  TimelineTableViewController.swift
//  Alzheimer Care
//
//  Created by Hugo Santos Piauilino Neto on 07/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController, MemoryEnteredDelegate {
    
    let dateFormatter = DateFormatter()
    var listOfMemories: [Memory] = []
    var memoryTest = Memory(name: "Teste", date: Date.init(), audio: "audio")
    var memoryTest2 = Memory(name: "Teste2", date: Date.init(), audio: "audio")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listOfMemories.append(memoryTest)
        listOfMemories.append(memoryTest2)
        
        dateFormatter.dateFormat = "EEE, dd MMM yyy - hh:mm:ss"


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listOfMemories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoryCell", for: indexPath)
        
        let memory = self.listOfMemories[indexPath.row]
        
        if let memoryCell = cell as? MemoryTableViewCell {
            memoryCell.memoryNameLabel.text = memory.name
            memoryCell.memoryDateLabel.text = dateFormatter.string(from: memory.date)
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
            let addMemoryViewController = segue.destination as! AddMemoryViewController
            addMemoryViewController.delegate = self
        }
    }
    
    func userDidEnterInformation(memory: Memory) {
        listOfMemories.append(memory)
    }
    

}
