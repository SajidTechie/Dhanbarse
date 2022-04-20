//
//  ScanHistoryCell.swift
//  Dhanbarse
//
//  Created by Goldmedal on 11/11/19.
//  Copyright © 2019 Goldmedal. All rights reserved.
//

import UIKit

class ScanHistoryDetailCell: UITableViewCell {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRange: UILabel!
    @IBOutlet weak var lblItemName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
