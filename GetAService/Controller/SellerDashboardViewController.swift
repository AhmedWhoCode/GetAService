//
//  ArtistInformationViewController.swift
//  GetAService
//
//  Created by Geek on 23/01/2021.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
class SellerDashboardViewController: UIViewController {
    
    @IBOutlet weak var sellerNameTextField: UILabel!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var sellerImage: UIImageView!
    @IBOutlet weak var sellerDetailLabel: UILabel!
    
    @IBOutlet weak var sellerCountryLabel: UILabel!
    @IBOutlet weak var sellerPriceLabel: UILabel!
    @IBOutlet weak var sellerStatusLabel: UILabel!
    
    @IBOutlet weak var bookNowButton: UIButton!
    
    
    @IBOutlet weak var subService1: UILabel!
    @IBOutlet weak var subService2: UILabel!
    @IBOutlet weak var subService3: UILabel!
    @IBOutlet weak var subService4: UILabel!
    @IBOutlet weak var subService5: UILabel!
    @IBOutlet weak var subService6: UILabel!
    var fireStorage = Storage.storage()
    
    var sellerProfileBrain = SellerProfileBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidesBottomBarWhenPushed = false

        designingViews()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        hidesBottomBarWhenPushed = false
        retrivingData()
    }
    
    func retrivingData()  {
        sellerProfileBrain.retrivingProfileData { (data,subservices) in
            
            self.sellerNameTextField.text = data.name
            self.sellerCountryLabel.text = data.country
            self.sellerPriceLabel.text = data.price
            self.sellerStatusLabel.text = "available"
            self.sellerDetailLabel.text = data.description
            self.showSubServices(with: subservices)
            
            self.sellerImage.loadCacheImage(with: data.imageRef)

        }
        
    }
    
    
    
    
    func showSubServices(with subServices:[String]?) {
        //sellerProfileBrain.updateOnlineStatus(with: Constants.online)
        
        if let subServices = subServices
        {
            let numberOfSubServices = subServices.count
            
            switch numberOfSubServices {
            case 1:
                subService1.isHidden = false
                subService1.text = subServices[0]
            case 2:
                subService1.isHidden = false
                subService2.isHidden = false
                subService1.text = subServices[0]
                subService2.text = subServices[1]
            case 3:
                subService1.isHidden = false
                subService2.isHidden = false
                subService3.isHidden = false
                
                subService1.text = subServices[0]
                subService2.text = subServices[1]
                subService3.text = subServices[2]
            case 4:
                subService1.isHidden = false
                subService2.isHidden = false
                subService3.isHidden = false
                subService4.isHidden = false
                
                subService1.text = subServices[0]
                subService2.text = subServices[1]
                subService3.text = subServices[2]
                subService4.text = subServices[3]
            case 5:
                subService1.isHidden = false
                subService2.isHidden = false
                subService3.isHidden = false
                subService4.isHidden = false
                subService5.isHidden = false
                
                subService1.text = subServices[0]
                subService2.text = subServices[1]
                subService3.text = subServices[2]
                subService4.text = subServices[3]
                subService5.text = subServices[4]
                
            case 6:
                subService1.isHidden = false
                subService2.isHidden = false
                subService3.isHidden = false
                subService4.isHidden = false
                subService5.isHidden = false
                subService6.isHidden = false
                
                subService1.text = subServices[0]
                subService2.text = subServices[1]
                subService3.text = subServices[2]
                subService4.text = subServices[3]
                subService5.text = subServices[4]
                subService6.text = subServices[5]
                
            default:
                print("no services")
            }
        }
        
    }
    
    func designingViews(){
        navigationController?.isToolbarHidden = false
        navigationController?.isNavigationBarHidden = false
        subService1.isHidden = true
        subService2.isHidden = true
        subService3.isHidden = true
        subService4.isHidden = true
        subService5.isHidden = true
        subService6.isHidden = true
        
        
        navigationItem.hidesBackButton = true
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
        
        ////        subService1.layer.shadowColor = UIColor.blue.cgColor
        ////        subService1.layer.shadowOpacity = 0.5
        ////        subService1.layer.shadowOffset = CGSize.zero
        //     subService1.layer.shadowRadius = 10
        
        
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
        
        
        //        bookNowButton.layer.cornerRadius = 20
        //        bookNowButton.layer.borderWidth = 1
        //        bookNowButton.layer.borderColor = UIColor.black.cgColor
        
        
        sellerImage.layer.masksToBounds = true
        sellerImage.layer.borderColor = UIColor.black.cgColor
        sellerImage.layer.cornerRadius = sellerImage.frame.size.height/2
        sellerImage.contentMode = .scaleAspectFill
    }
    
    
    @IBAction func notificatiobBarButton(_ sender: Any) {
        performSegue(withIdentifier: Constants.seguesNames.sellerDashboardToNotification, sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.seguesNames.sellerDashboardToProfile
        {
            if let destinationSegue = segue.destination as? SellerProfile
            {
                destinationSegue.isSourceVcArtistProfile = true
            }
        }
        
        else if segue.identifier == Constants.seguesNames.sellerDashboardToNotification
        {
            if let destinationSegue = segue.destination as? NotificationsList
            {
                destinationSegue.areSellerNotifications = true
            }
        }
        
    }
    
    
    @IBAction func logOutPressed(_ sender: Any) {
        logoutUser()
    }
    
    func logoutUser() {
        // call from any screen
        
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    
    @IBAction func profileClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.seguesNames.sellerDashboardToProfile, sender:self)
    }
    
}
