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
    
    //MARK: - IBOutlet variables
    @IBOutlet weak var sellerNameTextField: UILabel!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var sellerImage: UIImageView!
    @IBOutlet weak var sellerDetailLabel: UILabel!
    @IBOutlet weak var sellerCountryLabel: UILabel!
    @IBOutlet weak var sellerPriceLabel: UILabel!
    @IBOutlet weak var sellerStatusLabel: UILabel!
    @IBOutlet weak var sellerRating: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Local variables
    var sellerProfileBrain = SellerProfileBrain()
    var serviceBrain = ServicesBrain()
    var sellerSubservices = [String]()
    var sellerSubservicesWithPrice = [String:String]()
    var selectedImageToEnlarge : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designingViews()
        retrivingReviewsInformation()
        // Do any additional setup after loading the view.
    }
    //MARK: - Calling database functions
    func retrivingData()  {
        
        guard let sellerId = Auth.auth().currentUser?.uid else {
            print("could not find seller id in seller dashboard")
            return
        }
        sellerProfileBrain.retrivingProfileData { (data,subservices) in
            
            self.sellerNameTextField.text = data.name
            self.sellerCountryLabel.text = data.state
            self.sellerPriceLabel.text = "$\(data.price)"
            self.sellerStatusLabel.text = "available"
            self.sellerDetailLabel.text = data.description
            //self.showSubServices(with: subservices)
            if let sub = subservices
            {
                self.serviceBrain.retrieveSubservicesWithPriceForPublicProfile(with:sellerId, subservices: sub){ (data) in
                    self.sellerSubservicesWithPrice = data
                    self.sellerSubservices = sub
                    self.tableView.reloadData()
                }
                
            }
            
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
    
    func logoutUser() {
        // call from any screen
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    //MARK: - Onclick functions
    @IBAction func notificatiobBarButton(_ sender: Any) {
        performSegue(withIdentifier: Constants.seguesNames.sellerDashboardToNotification, sender: self)
    }
    
    
    @IBAction func logOutPressed(_ sender: Any) {
        logoutUser()
    }
    
    @IBAction func profileClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.seguesNames.sellerDashboardToProfile, sender:self)
    }
    
    //MARK: - Ovveriden functions
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = false
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        
        
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
    
    
}

//MARK: - table view extention
extension SellerDashboardViewController : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sellerSubservices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "subservicesCellSellerDashboard", for: indexPath) as? SubServicesTableViewCell
        
        cell?.name.text = sellerSubservices[indexPath.row]
        cell?.price.text = sellerSubservicesWithPrice[(cell?.name.text)!]
        
        return cell!
        
    }
    
    
    
}
