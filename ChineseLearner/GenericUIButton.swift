//
//  GenericUIButton.swift
//  ChineseLearner
//
//  Created by Alex Michaux on 12/6/15.
//  Copyright © 2015 Alex Michaux. All rights reserved.
//

import UIKit

class GenericUIButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = UIColor(red: 0.36, green: 0.67, blue: 0.95, alpha: 1.0)
        layer.cornerRadius = 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.blackColor().CGColor
        setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSizeMake(2, 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.5
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
