//
//  BuyerOrSeller.swift
//  GetAService
//
//  Created by Geek on 18/02/2021.
//

import UIKit

class BuyerOrSeller: UIViewController {

    @IBOutlet weak var buyerButtonPressed: UIButton!
    @IBOutlet weak var sellerButtonPressed: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        buyerButtonPressed.layer.cornerRadius = 20
        buyerButtonPressed.layer.borderWidth = 1
        buyerButtonPressed.layer.borderColor = UIColor.gray.cgColor
        
        sellerButtonPressed.layer.cornerRadius = 20
        sellerButtonPressed.layer.borderWidth = 1
        sellerButtonPressed.layer.borderColor = UIColor.black.cgColor
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "Buyer" {
            performSegue(withIdentifier: Constants.seguesNames.userTypeToBuyer, sender:self)
        }
        else
        {
            performSegue(withIdentifier: Constants.seguesNames.userTypeToSeller, sender:self)

        }
    }
    
}
