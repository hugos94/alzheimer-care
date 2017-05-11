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
    
    // MARK: - Properties
    
    var listOfMemories: [Memory] = []
    var recordingSession : AVAudioSession!
    var settings         = [String : Int]()
    var audioPlayer : AVAudioPlayer!
    
    func updateList() {
        listOfMemories = MemoryDAO.read()
    }
    
    // MARK: - System Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateList()
        
        startSession()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateList()
        
        tableView.reloadData()
    }

    // MARK: - Table View Data Source

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
            memoryCell.memoryDateLabel.text = MemoryDAO.getFormattedData(date: memory.date as! Date)
            memoryCell.onButtonTapped = {
                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(string: memory.url!)!)
                self.audioPlayer.prepareToPlay()
                self.audioPlayer.delegate = self
                self.audioPlayer.play()
            }
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if MemoryDAO.delete(listOfMemories[indexPath.row]){
                updateList()
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    // MARK: - AV Audio Functions
    
    func startSession() {
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("Allow")
                    } else {
                        let alert = UIAlertController(title: "Erro!", message: "Você não aceitou utilizar o microfone do seu dispositivo!", preferredStyle: .actionSheet)
                        alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                        })
                        self.present(alert, animated: true)
                        print("Dont Allow")
                    }
                }
            }
        } catch {
            let alert = UIAlertController(title: "Erro!", message: "Não foi possível ativar a gravação de áudio!", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            })
            self.present(alert, animated: true)
        }
        
        // Audio Settings
        
        settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
    }

    // MARK: - Play Functions
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print(flag)
    }
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?){
        print(error.debugDescription)
    }
    internal func audioPlayerBeginInterruption(_ player: AVAudioPlayer){
        print(player.debugDescription)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
