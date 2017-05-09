//
//  AddMemoryViewController.swift
//  Alzheimer Care
//
//  Created by Hugo Santos Piauilino Neto on 06/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import UIKit
import AVFoundation

// protocol used for sending data back
protocol MemoryEnteredDelegate: class {
    func userDidEnterInformation(memory: Memory)
}

class AddMemoryViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    // MARK: - Properties
    var recordingSession : AVAudioSession!
    var audioRecorder    :AVAudioRecorder!
    var settings         = [String : Int]()
    var audioPlayer : AVAudioPlayer!
    
    weak var delegate: MemoryEnteredDelegate? = nil
    
    @IBOutlet weak var nameMemoryTextField: UITextField!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    // MARK: - Record Functions
    
    @IBAction func recordAudio(_ sender: Any) {
        if audioRecorder == nil {
            self.recordButton.setTitle("Stop", for: UIControlState.normal)
            self.recordButton.backgroundColor = UIColor(red: 119.0/255.0, green: 119.0/255.0, blue: 119.0/255.0, alpha: 1.0)
            self.startRecording()
        } else {
            self.recordButton.setTitle("Record", for: UIControlState.normal)
            self.recordButton.backgroundColor = UIColor(red: 221.0/255.0, green: 27.0/255.0, blue: 50.0/255.0, alpha: 1.0)
            self.finishRecording(success: true)
        }
    }
    
    func startRecording() {
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
        } else {
            audioRecorder = nil
            print("Somthing Wrong.")
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
    
    // MARK: - Configurations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        // making this a weak variable so that it won't create a strong reference cycle
        
        navigationItem.title = "Adicionar Memória"
        
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
    
    func directoryURL() -> NSURL? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.appendingPathComponent("sound.m4a")
        print(soundURL)
        return soundURL as NSURL?
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

    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func returnButton(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveMemoryButton(_ sender: Any) {
            if delegate != nil {
            let actualDate = Date()
            let audioName = "\(actualDate.description).m4a"
            let memory = Memory(name: nameMemoryTextField.text!, date: actualDate, audio: audioName)
            
            // call this method on whichever class implements our delegate protocol
            delegate?.userDidEnterInformation(memory: memory)
            
            navigationController?.dismiss(animated: true, completion: nil)
        }else{
            print("delegate ta nil")
        }
    }
        
}
