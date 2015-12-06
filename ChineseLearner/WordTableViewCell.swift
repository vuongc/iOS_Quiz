//
//  WordTableViewCell.swift
//  ChineseLearner
//
//  Created by Alex Michaux on 12/4/15.
//  Copyright © 2015 Alex Michaux. All rights reserved.
//

import UIKit

class WordTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var pinyinsLabel: UILabel!
    @IBOutlet weak var charactersLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
