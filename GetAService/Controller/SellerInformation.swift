//
//  ArtistInformationViewController.swift
//  GetAService
//
//  Created by Geek on 23/01/2021.
//

import UIKit
import Firebase

class SellerInformation: UIViewController {

    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var artistImage: UIImageView!

    @IBOutlet weak var sellerCountryLabel: UILabel!
    @IBOutlet weak var sellerPriceLabel: UILabel!
    @IBOutlet weak var sellerStatusLabel: UILabel!
    @IBOutlet weak var sellerDetailLabel: UILabel!

    
    @IBOutlet weak var bookNowButton: UIButton!
    
   
    @IBOutlet weak var subService1: UILabel!
    @IBOutlet weak var subService2: UILabel!
    @IBOutlet weak var subService3: UILabel!
    @IBOutlet weak var subService4: UILabel!
    @IBOutlet weak var subService5: UILabel!
    @IBOutlet weak var subService6: UILabel!

    
    //value of this variable will come from the previous scree
    var selectedSellerId : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designingViews()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        hidesBottomBarWhenPushed = false
    }
    
    func designingViews(){
        navigationItem.hidesBackButton = false
        ///MARK: - designing views
        countryView.layer.cornerRadius = 15
        countryView.layer.borderWidth = 1
        countryView.layer.borderColor = UIColor.black.cgColor
        
        priceView.layer.cornerRadius = 15
        priceView.layer.borderWidth = 1
        priceView.layer.borderColor = UIColor.black.cgColor
        
        statusView.layer.cornerRadius = 15
        statusView.layer.borderWidth = 1
        statusView.layer.borderColor = UIColor.black.cgColor
        
        
        
        subService1.layer.cornerRadius = 10
        subService1.layer.borderWidth = 1
        subService1.layer.borderColor = UIColor.black.cgColor
        
        
        
        subService2.layer.cornerRadius = 10
        subService2.layer.borderWidth = 1
        subService2.layer.borderColor = UIColor.black.cgColor
        
        
        subService3.layer.cornerRadius = 10
        subService3.layer.borderWidth = 1
        subService3.layer.borderColor = UIColor.black.cgColor
        
        subService4.layer.cornerRadius = 10
        subService4.layer.borderWidth = 1
        subService4.layer.borderColor = UIColor.black.cgColor
        
        subService5.layer.cornerRadius = 10
        subService5.layer.borderWidth = 1
        subService5.layer.borderColor = UIColor.black.cgColor
        
        subService6.layer.cornerRadius = 10
        subService6.layer.borderWidth = 1
        subService6.layer.borderColor = UIColor.black.cgColor
        
        bookNowButton.layer.cornerRadius = 20
        bookNowButton.layer.borderWidth = 1
        bookNowButton.layer.borderColor = UIColor.black.cgColor
        
        
        artistImage.layer.masksToBounds = true
        artistImage.layer.borderColor = UIColor.black.cgColor
         artistImage.layer.cornerRadius = artistImage.frame.size.height/2
        artistImage.contentMode = .scaleAspectFill
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//       
//        if segue.identifier == Constants.seguesNames.artistInfoToProfile
//        {
//            if let destinationSegue = segue.destination as? SellerProfile
//          {
//                destinationSegue.isSourceVcArtistProfile = true
//          }
//        }
//        
//    }
//    

    
    @IBAction func bookNow(_ sender: Any) {
        performSegue(withIdentifier: Constants.seguesNames.artistInfoToConfirmBooking, sender: self)
    }
    
    
    
    
    
//    @IBAction func BookNow(_ sender: UIBarButtonItem) {
//        performSegue(withIdentifier: Constants.seguesNames.artistInfoToProfile, sender:self)
//    }
    
}
