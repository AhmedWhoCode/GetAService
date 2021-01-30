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
        
        customerImage.layer.shadowColor = UIColor.blue.cgColor
        customerImage.layer.shadowOpacity = 1
        customerImage.layer.shadowOffset = CGSize.zero
        customerImage.layer.shadowRadius = 50
        
        customerImage.layer.masksToBounds = true
        customerImage.layer.borderColor = UIColor.black.cgColor
        customerImage.layer.cornerRadius = customerImage.frame.size.height/2
        customerImage.contentMode = .scaleAspectFill
        
        
        

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
