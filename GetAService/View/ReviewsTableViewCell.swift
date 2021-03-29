//
//  ReviewsTableViewCell.swift
//  GetAService
//
//  Created by Geek on 29/03/2021.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var oneStar: UIImageView!
    @IBOutlet weak var twoStar: UIImageView!
    @IBOutlet weak var threeStar: UIImageView!
    @IBOutlet weak var fourStar: UIImageView!
    @IBOutlet weak var fiveStar: UIImageView!

    
    @IBOutlet weak var reviewTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.reviewTextView.layer.borderColor = UIColor.lightGray.cgColor
//        self.reviewTextView.layer.borderWidth = 1        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
