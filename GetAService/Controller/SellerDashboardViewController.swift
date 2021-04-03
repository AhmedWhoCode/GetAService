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
    
    @IBOutlet weak var sellerRating: UILabel!
    
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
        
        //hidesBottomBarWhenPushed = false
        
        designingViews()
        retrivingReviewsInformation()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let userDefault = UserDefaults.standard
        
        //checking if the service was started or not
        if userDefault.string(forKey: Constants.navigationInfo) == "started"
        {
            //setting global values
            if let sellerId = userDefault.string(forKey: Constants.sellerIdForNavigation)
            {
                BookingBrain.sharedInstance.sellerId = sellerId
            }
            
            if let notificationId = userDefault.string(forKey: Constants.notificationIdForNavigation)
            {
                BookingBrain.sharedInstance.currentBookingDocumentId = notificationId
            }
            
            if let buyerId = userDefault.string(forKey: Constants.buyerIdForNavigation)
            {
                BookingBrain.sharedInstance.buyerId = buyerId
            }
            navigationItem.hidesBackButton = true
            hidesBottomBarWhenPushed = true
            performSegue(withIdentifier: Constants.seguesNames.sellerDashToMeetup, sender: self)
            
            
        }
        hidesBottomBarWhenPushed = false
        navigationController?.hidesBottomBarWhenPushed = false
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
    func retrivingReviewsInformation() {
        sellerProfileBrain.retrivingSellerReviews(with: Auth.auth().currentUser!.uid) { (reviews) in
            let reviewList  = reviews
            var totalStar = 0.0
            
            reviewList.forEach { (data) in
                totalStar = totalStar + Double(Float(data.star)!)
            }
            
            if reviewList.count > 0
            {
                let starAverage = totalStar / Double(Float(reviewList.count))
                self.sellerRating.text = String(format: "%.1f",starAverage)
            }
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
