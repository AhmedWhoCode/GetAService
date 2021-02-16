//
//  ListOfServicesXibTableViewCell.swift
//  GetAService
//
//  Created by Geek on 20/01/2021.
//

import UIKit

// defining protocol to inform the class that the button is pressed and act accordingly
//protocol ButtonClickedServices {
//    func didButtonPressed(with value : String)
//}

class ListOfServicesXibTableViewCell: UITableViewCell {

      // initilzaing delegant so that the other class can access the delegant
    var buttonDelegantServices:ButtonPressed?
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var cellView: UIView!
    //alternative way of sending data , commented out
    //var buttonClicked: (() -> Void)?
    //var services=ListOfServices()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        listButton.layer.masksToBounds = true
        listButton.layer.borderColor = UIColor.black.cgColor
        listButton.layer.cornerRadius = 15
        listButton.contentMode = .scaleAspectFill
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func listButton(_ sender: Any) {
        
        // calling the delegant , now the classes confirmed the above protocol will be  informed
        buttonDelegantServices?.didButtonPressed(with: "Hy im pressed")
    
        //could be used if needed
      //  buttonClicked?()
       
    }
}
