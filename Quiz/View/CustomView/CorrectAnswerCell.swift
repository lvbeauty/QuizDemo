//
//  CorrectAnswerCell.swift
//  Quiz
//
//  Created by Tong Yi on 6/5/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

class CorrectAnswerCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
