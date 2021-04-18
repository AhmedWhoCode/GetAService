//
//  PortfolioImagesTableViewCell.swift
//  GetAService
//
//  Created by Geek on 17/04/2021.
//

import UIKit

class PortfolioImagesTableViewCell: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet weak var portfolioImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 1
        
        scrollView.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return portfolioImage
    }
}
