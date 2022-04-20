//
//  QnAViewCell.swift
//  Dhanbarse
//
//  Created by Goldmedal on 4/24/20.
//  Copyright © 2020 Goldmedal. All rights reserved.
//

import UIKit

protocol GetAnswerDelegate {
    func GetAnswer(cell: QnAViewCell)
}

class QnAViewCell: UITableViewCell {
    
    @IBOutlet var lblQuestion: UILabel!
       @IBOutlet var edtAnswer: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
