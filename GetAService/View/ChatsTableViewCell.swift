//
//  ChatsTableViewCell.swift
//  GetAService
//
//  Created by Geek on 30/01/2021.
//

import UIKit

class ChatsTableViewCell: UITableViewCell {

    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var chatName: UILabel!
    @IBOutlet weak var chatCountry: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        chatImage.layer.masksToBounds = true
        chatImage.layer.borderColor = UIColor.black.cgColor
       chatImage.layer.cornerRadius = chatImage.frame.size.height/2
        chatImage.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
