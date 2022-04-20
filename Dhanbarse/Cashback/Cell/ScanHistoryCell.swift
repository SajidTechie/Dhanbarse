//
//  ScanHistoryCell.swift
//  Dhanbarse
//
//  Created by Goldmedal on 3/29/20.
//  Copyright © 2020 Goldmedal. All rights reserved.
//

import UIKit

class ScanHistoryCell: UITableViewCell {

    @IBOutlet weak var lblTransDate: UILabel!
    @IBOutlet weak var lblTransId: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblCashbackType: UILabel!
    @IBOutlet weak var lblRemark: UILabel!
    @IBOutlet weak var lblPayoutStatus: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
