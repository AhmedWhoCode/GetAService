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
//extension UIImage {
//    var circleMask: UIImage? {
//        let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
//        let imageView = UIImageView(frame: .init(origin: .init(x: 0, y: 0), size: square))
//        imageView.contentMode = .scaleAspectFill
//        imageView.image = self
//        imageView.layer.cornerRadius = square.width/2
//        imageView.layer.borderColor = UIColor.white.cgColor
//        imageView.layer.borderWidth = 5
//        imageView.layer.masksToBounds = true
//        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
//        defer { UIGraphicsEndImageContext() }
//        guard let context = UIGraphicsGetCurrentContext() else { return nil }
//        imageView.layer.render(in: context)
//        return UIGraphicsGetImageFromCurrentImageContext()
//    }

