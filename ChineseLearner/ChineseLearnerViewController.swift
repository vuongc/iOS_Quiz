//
//  ChineseLearnerViewController.swift
//  ChineseLearner
//
//  Created by Alex Michaux on 12/5/15.
//  Copyright © 2015 Alex Michaux. All rights reserved.
//

import UIKit

class ChineseLearnerViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet var menuButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
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
