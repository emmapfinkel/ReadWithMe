//
//  FictionLevelHViewController.swift
//  ReadWithMe
//
//  Created by Mark Cheng on 5/23/20.
//  Copyright © 2020 Emma Finkel. All rights reserved.
//

import UIKit
import AVFoundation

class NonFictionLevelHViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    var previousVC = StartReadingViewController()
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var listenButton: UIButton!
    
    var audioPlayer: AVAudioPlayer!
    var audioRecorder: AVAudioRecorder!
    
    // Change the audioRecordingName for each different reading
    var audioRecordingName : String = "NonFictionLevelH.m4a"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordSetup()
        playButton.isEnabled = false
        listenButton.isEnabled = false
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func recordSetup() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent(audioRecordingName)
        let audioFormat = [AVFormatIDKey : kAudioFormatAppleLossless,
                            AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue ,
                            AVEncoderBitRateKey : 320000,
                            AVNumberOfChannelsKey : 2,
                            AVSampleRateKey : 44100.2 ] as [String : Any]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: audioFormat)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        } catch {
            print(error)
        }
    }
    
    func setupPlayer() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent(audioRecordingName)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
        } catch {
            print(error)
        }
    }
    
    func setupPlayerForListen() {
        // Change the pathToRecording for each different reading
        let pathToPrerecording = Bundle.main.path(forResource: "HNonfictionText", ofType: "m4a")
        let audioFilename = URL(fileURLWithPath: pathToPrerecording!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
        } catch {
            print(error)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        recordButton.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
        playButton.setTitle("Play", for: .normal)
        listenButton.setTitle("Listen", for: .normal)
    }
    
    @IBAction func recordTapped(_ sender: UIButton) {
        if recordButton.titleLabel?.text == "Record" {
            audioRecorder.record()
            recordButton.setTitle("Stop", for: .normal)
            playButton.isEnabled = false
            listenButton.isEnabled = false
        } else {
            audioRecorder.stop()
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = true
            listenButton.isEnabled = true
        }
    }
    
    @IBAction func playTapped(_ sender: UIButton) {
        if playButton.titleLabel?.text == "Play" {
            playButton.setTitle("Stop", for: .normal)
            recordButton.isEnabled = false
            listenButton.isEnabled = false
            setupPlayer()
            audioPlayer.play()
        } else {
            audioPlayer.stop()
            playButton.setTitle("Play", for: .normal)
            recordButton.isEnabled = true
            listenButton.isEnabled = true
        }
    }
    
    
    @IBAction func listenTapped(_ sender: UIButton) {
        if listenButton.titleLabel?.text == "Listen" {
            listenButton.setTitle("Stop", for: .normal)
            recordButton.isEnabled = false
            playButton.isEnabled = false
            setupPlayerForListen()
            audioPlayer.play()
        } else {
            audioPlayer.stop()
            playButton.setTitle("Play", for: .normal)
            recordButton.isEnabled = true
            playButton.isEnabled = true
        }
       
    }
    
    @IBAction func finishReading(_ sender: Any) {
        
        previousVC.countTextsRead = previousVC.countTextsRead + 1
        
        previousVC.textsRead.text = "\(previousVC.countTextsRead)"
        
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
