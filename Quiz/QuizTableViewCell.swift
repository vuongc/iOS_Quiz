//
//  QuizTableViewCell.swift
//  Quiz
//
//  Created by Christopher Vuong on 12/4/15.
//  Copyright © 2015 Christopher Vuong. All rights reserved.
//

import UIKit

class QuizTableViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answersLabel: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
