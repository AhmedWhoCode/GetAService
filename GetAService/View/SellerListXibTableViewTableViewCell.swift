//
//  ArtistListXibTableViewTableViewCell.swift
//  GetAService
//
//  Created by Geek on 21/01/2021.
//

import UIKit

//protocol ButtonClickedArtist {
//    func didButtonPressed(with value : String)
//}

class SellerListXibTableViewTableViewCell: UITableViewCell {

    @IBOutlet weak var sellerInfoButton: UIButton!
    @IBOutlet weak var sellerPriceLabel: UILabel!
    @IBOutlet weak var sellerImage: UIImageView!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var sellerCountryLabel: UILabel!
    @IBOutlet weak var sellerAvailabilityLabel: UILabel!
   // var buttonClicked: (() -> Void)? = nil

    var artistButtonDelegant : ButtonPressed?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        designingViews()
        
    }

    func designingViews() {
        sellerImage.layer.masksToBounds = true
        sellerImage.layer.borderColor = UIColor.black.cgColor
       sellerImage.layer.cornerRadius = sellerImage.frame.size.height/2
        sellerImage.contentMode = .scaleAspectFill
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    @IBAction func buttonClicked(_ sender: UIButton) {
        artistButtonDelegant?.didButtonPressed(with: sender.title(for: .normal)!)
    }
    
}
