//
//  FamilyCardCell.swift
//  Dhanbarse
//
//  Created by Goldmedal on 10/12/21.
//  Copyright © 2021 Goldmedal. All rights reserved.
//

import UIKit

class FamilyCardCell: UITableViewCell {
    
    @IBOutlet weak var lblCardName: UILabel!
    @IBOutlet weak var btnManage: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
