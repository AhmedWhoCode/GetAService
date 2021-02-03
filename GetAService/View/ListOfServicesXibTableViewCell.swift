//
//  ListOfServicesXibTableViewCell.swift
//  GetAService
//
//  Created by Geek on 20/01/2021.
//

import UIKit

class ListOfServicesXibTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var cellView: UIView!
    var buttonClicked: (() -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        cellView.layer.cornerRadius = 18
        cellView.layer.borderWidth = 1
        listButton.layer.cornerRadius = 18
        listButton.layer.borderWidth = 1
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func listButton(_ sender: Any) {
        buttonClicked?()
       
    }
}
