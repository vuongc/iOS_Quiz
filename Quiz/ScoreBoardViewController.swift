//
//  ScoreBoardViewController.swift
//  Quiz
//
//  Created by Christopher Vuong on 12/5/15.
//  Copyright © 2015 Christopher Vuong. All rights reserved.
//

import UIKit

class ScoreBoardViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var finalScoreLabel: UILabel!
    
    var scoreValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        finalScoreLabel.text = scoreValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
