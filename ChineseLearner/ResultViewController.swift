//
//  ResultViewController.swift
//  ChineseLearner
//
//  Created by Alex Michaux on 12/5/15.
//  Copyright © 2015 Alex Michaux. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    // MARK: Properties

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var errors = 0
    var numberOfQuestions = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        loadLabel()
        loadButton()
    }

    // MARK: Methods
    
    func loadButton() {
        backButton.backgroundColor = UIColor(red: 0.36, green: 0.67, blue: 0.95, alpha: 1.0)
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.blackColor().CGColor
        backButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }
    
    func loadLabel() {
        resultLabel.text = "You did " + String(errors) + " errors out of " + String(numberOfQuestions) + " questions"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    */
}
