//
//  FictionLevelHViewController.swift
//  ReadWithMe
//
//  Created by Mark Cheng on 5/23/20.
//  Copyright © 2020 Emma Finkel. All rights reserved.
//

import UIKit
import AVFoundation

class NonFictionLevelHViewController: UIViewController {

    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func listenTapped(_ sender: UIButton) {
    
        // TAGS:
        // #1: Listen Button
        
        let selectedRecording = sender.tag
        
        switch selectedRecording {
        case 1:
            let pathToRecording = Bundle.main.path(forResource: "HNonfictionText", ofType: "m4a")
            let addressToFile = URL(fileURLWithPath: pathToRecording!)
            
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: addressToFile)
                audioPlayer?.play()
            } catch {
                // error handling
            }
            
        default:
            return
        }
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
