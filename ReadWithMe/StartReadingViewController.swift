//
//  StartReadingViewController.swift
//  ReadWithMe
//
//  Created by Emma Finkel on 5/20/20.
//  Copyright © 2020 Emma Finkel. All rights reserved.
//

import UIKit

class StartReadingViewController: UIViewController {
    
    @IBOutlet weak var textsRead: UILabel!
    
    var countTextsRead = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
        if let finishedReading = segue.destination as? NonFictionLevelHViewController {
            finishedReading.previousVC = self
        }
    }
   

    @IBAction func  unwindToStartReadingViewController(_ sender: UIStoryboardSegue) {}
}
