//
//  FairDetailsViewController.swift
//  GetAService
//
//  Created by Geek on 24/01/2021.
//

import UIKit

class FairDetails: UIViewController {

    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var ModelPriceView: UIView!
    @IBOutlet weak var estimatedPriceView: UIView!
    @IBOutlet weak var uberFairView: UIView!
    @IBOutlet weak var confirmBooking: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        designingView()
        // Do any additional setup after loading the view.
    }
    
    func designingView() {
        ///MARK: - designing views
        ModelPriceView.layer.cornerRadius = 15
        ModelPriceView.layer.borderWidth = 1
        ModelPriceView.layer.borderColor = UIColor.black.cgColor
        
        ///MARK: - designing views
        estimatedPriceView.layer.cornerRadius = 15
        estimatedPriceView.layer.borderWidth = 1
        estimatedPriceView.layer.borderColor = UIColor.black.cgColor
        
        ///MARK: - designing views
        uberFairView.layer.cornerRadius = 15
        uberFairView.layer.borderWidth = 1
        uberFairView.layer.borderColor = UIColor.black.cgColor
        
        ///MARK: - designing views
        confirmBooking.layer.cornerRadius = 20
        confirmBooking.layer.borderWidth = 1
        confirmBooking.layer.borderColor = UIColor.black.cgColor
        
        artistImage.layer.masksToBounds = true
        artistImage.layer.borderColor = UIColor.black.cgColor
       artistImage.layer.cornerRadius=artistImage.frame.size.height/2
        artistImage.contentMode = .scaleAspectFill
        
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
