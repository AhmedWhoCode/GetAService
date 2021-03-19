//
//  LocationTableViewCell.swift
//  GetAService
//
//  Created by Geek on 17/03/2021.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    var pressed:ButtonPressed2?

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
    
        pressed!.didButtonPressed(with: sender)
    }
}
