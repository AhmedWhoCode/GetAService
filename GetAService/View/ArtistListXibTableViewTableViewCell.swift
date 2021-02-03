//
//  ArtistListXibTableViewTableViewCell.swift
//  GetAService
//
//  Created by Geek on 21/01/2021.
//

import UIKit

class ArtistListXibTableViewTableViewCell: UITableViewCell {

    @IBOutlet weak var artistPriceLabel: UILabel!
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistCountryLabel: UILabel!
    @IBOutlet weak var artistAvailabilityLabel: UILabel!
    var buttonClicked: (() -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        designingViews()
        
    }

    func designingViews() {
        artistImage.layer.masksToBounds = true
        artistImage.layer.borderColor = UIColor.black.cgColor
       artistImage.layer.cornerRadius = artistImage.frame.size.height/2
        artistImage.contentMode = .scaleAspectFill
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    @IBAction func buttonClicked(_ sender: UIButton) {
        buttonClicked?()
    }
    
}
