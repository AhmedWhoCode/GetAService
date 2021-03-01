//
//  CustomerRequestScreen.swift
//  GetAService
//
//  Created by Geek on 30/01/2021.
//

import UIKit

class CustomerRequestScreen: UIViewController {

    @IBOutlet weak var customerImage: UIImageView!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var customerInfoView: UIView!
    @IBOutlet weak var changeLocationButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var customerBudgetLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        desigingView()

        // Do any additional setup after loading the view.
    }
    
    func desigingView(){
        //hides back button of top navigation
        navigationItem.hidesBackButton = false

        //MARK: - adding roundness to image
        customerImage.layer.masksToBounds = true
        customerImage.layer.borderWidth = 1
        customerImage.layer.borderColor = UIColor.black.cgColor
        customerImage.layer.cornerRadius = customerImage.frame.size.height/2
        customerImage.contentMode = .scaleAspectFill
        
        //MARK: - adding shadow to info view
        customerInfoView.layer.cornerRadius = 10
        customerInfoView.layer.shadowColor = UIColor.gray.cgColor
        customerInfoView.layer.shadowOpacity = 0.5
        customerInfoView.layer.shadowRadius = 5
        
        //MARK: -making views round
        confirmButton.layer.cornerRadius = 25
        confirmButton.layer.borderWidth = 1
        confirmButton.layer.borderColor = UIColor.black.cgColor
        
        changeLocationButton.layer.cornerRadius = 25
        changeLocationButton.layer.borderWidth = 1
        changeLocationButton.layer.borderColor = UIColor.black.cgColor
        
        
        rejectButton.layer.cornerRadius = 25
        rejectButton.layer.borderWidth = 1
        rejectButton.layer.borderColor = UIColor.black.cgColor
        
        

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
