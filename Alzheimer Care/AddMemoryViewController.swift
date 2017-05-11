//
//  AddMemoryViewController.swift
//  Alzheimer Care
//
//  Created by Hugo Santos Piauilino Neto on 06/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import UIKit
import AVFoundation

class AddMemoryViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    // MARK: - Properties
    
    weak var delegate: MemoryEnteredDelegate? = nil
    
    var actualDate: NSDate!
    var soundURL: NSURL = NSURL()
    var audioName: String = ""
    
    var recordingSession : AVAudioSession!
    var audioRecorder    :AVAudioRecorder!
    var settings         = [String : Int]()
    var audioPlayer : AVAudioPlayer!
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameMemoryTextField: UITextField!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    // MARK: - System Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        playButton.isHidden = true
        
        actualDate = NSDate()
        
        audioName = "\(actualDate.description).m4a"
        
        navigationItem.title = "Adicionar Memória"
        
        createRecordSession()
    }
    
    // MARK: - AV Audio Functions
    
    func createRecordSession() {
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
    
    // MARK: - Record Functions
    
    @IBAction func recordAudio(_ sender: Any) {
        if audioRecorder == nil {
            self.recordButton.setTitle("Stop", for: UIControlState.normal)
            self.recordButton.backgroundColor = UIColor(red: 119.0/255.0, green: 119.0/255.0, blue: 119.0/255.0, alpha: 1.0)
            self.startSession()
        } else {
            self.recordButton.setTitle("Record", for: UIControlState.normal)
            self.recordButton.backgroundColor = UIColor(red: 221.0/255.0, green: 27.0/255.0, blue: 50.0/255.0, alpha: 1.0)
            self.finishRecording(success: true)
        }
    }
    
    func startSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
        } catch {
            print("Não foi possivel utilizar o speaker padrão!")
        }
        
        do {
            audioRecorder = try AVAudioRecorder(url: self.directoryURL()! as URL,
                                                settings: settings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        } catch {
            finishRecording(success: false)
        }
        do {
            try audioSession.setActive(true)
            audioRecorder.record()
        } catch {
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        if success {
            print(success)
            playButton.isHidden = false
        } else {
            audioRecorder = nil
            print("Something Wrong.")
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    // MARK: - Play Functions
    
    @IBAction func playAudio(_ sender: Any) {
        if !audioRecorder.isRecording {
            self.audioPlayer = try! AVAudioPlayer(contentsOf: audioRecorder.url)
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.delegate = self
            self.audioPlayer.play()
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print(flag)
    }
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?){
        print(error.debugDescription)
    }
    internal func audioPlayerBeginInterruption(_ player: AVAudioPlayer){
        print(player.debugDescription)
    }
    
    // MARK: - Storage Audio Configurations
    
    func directoryURL() -> NSURL? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.appendingPathComponent(audioName) as NSURL?
        return soundURL
    }
    
    // MARK: - Actions
    
    @IBAction func returnButton(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveMemoryButton(_ sender: Any) {
        if delegate != nil {
            let memory = Memory()
            memory.name = nameMemoryTextField.text!
            memory.date = actualDate
            memory.url = String(describing: audioRecorder.url)

            if MemoryDAO.create(memory) {
                print("A memória \(memory.name!) foi inserida com sucesso!")
            } else {
                print("Não foi possível inserir a memória \(memory.name!)!")
            }
            
            // call this method on whichever class implements our delegate protocol
            delegate?.userDidEnterInformation(memory: memory)
            
            navigationController?.dismiss(animated: true, completion: nil)
            
        }
    }
        
}

// MARK: - Protocols
//protocol used for sending data back
protocol MemoryEnteredDelegate: class {
    func userDidEnterInformation(memory: Memory)
}
