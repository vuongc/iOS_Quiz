//
//  ChooseModeViewController.swift
//  ChineseLearner
//
//  Created by Alex Michaux on 12/5/15.
//  Copyright © 2015 Alex Michaux. All rights reserved.
//

import UIKit

class ChooseModeViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet var modeButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let quizzViewController = segue.destinationViewController as! QuizzViewController
        
        switch segue.identifier! {
        case "SetModeEngToPin" :
            quizzViewController.questionType = "english"
            quizzViewController.answerType = "pinyins"
        case "SetModeEngToChar" :
            quizzViewController.questionType = "english"
            quizzViewController.answerType = "characters"
        case "SetModePinToEng" :
            quizzViewController.questionType = "pinyins"
            quizzViewController.answerType = "english"
        case "SetModePinToChar" :
            quizzViewController.questionType = "pinyins"
            quizzViewController.answerType = "characters"
        case "SetModeCharToEng" :
            quizzViewController.questionType = "characters"
            quizzViewController.answerType = "english"
        case "SetModeCharToPin" :
            quizzViewController.questionType = "characters"
            quizzViewController.answerType = "pinyins"
        default :
            quizzViewController.questionType = "english"
            quizzViewController.answerType = "pinyins"
        }
    }

}
