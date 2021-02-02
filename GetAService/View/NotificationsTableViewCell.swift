//
//  NotificationsTableViewCell.swift
//  GetAService
//
//  Created by Geek on 26/01/2021.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var customerCountry: UILabel!
    @IBOutlet weak var customerImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //customerImage.layer.borderWidth = 1
         customerImage.layer.masksToBounds = true
         customerImage.layer.borderColor = UIColor.black.cgColor
         customerImage.layer.cornerRadius = customerImage.frame.size.height/2
         customerImage.contentMode = .scaleAspectFill

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


