//
//  NotificationsTableViewCell.swift
//  GetAService
//
//  Created by Geek on 26/01/2021.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var requestedByLabel: UILabel!
    @IBOutlet weak var typeOfServiceLabel: UILabel!
    @IBOutlet weak var availabileLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
