//
//  NotificationCell.swift
//  dealersApp
//
//  Created by Goldmedal on 15/11/18.
//  Copyright © 2018 Goldmedal. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var imvNotiImage: UIImageView!
     @IBOutlet weak var vwNotiMain: RoundView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
