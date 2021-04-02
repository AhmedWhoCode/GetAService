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
    
    @IBOutlet weak var sellerImage: UIImageView!

    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var sellerCountryLabel: UILabel!
    @IBOutlet weak var sellerPriceLabel: UILabel!
    @IBOutlet weak var sellerStatusLabel: UILabel!
    @IBOutlet weak var sellerDetailLabel: UILabel!

    
    @IBOutlet weak var bookNowButton: UIButton!
    
    @IBOutlet weak var starAverageLabel: UILabel!
    
    @IBOutlet weak var subService1: UILabel!
    @IBOutlet weak var subService2: UILabel!
    @IBOutlet weak var subService3: UILabel!
    @IBOutlet weak var subService4: UILabel!
    @IBOutlet weak var subService5: UILabel!
    @IBOutlet weak var subService6: UILabel!

    
    //value of this variable will come from the previous screen
    var selectedSellerId : String!
    
    var fireStorage = Storage.storage()

    var sellerProfileBrain = SellerProfileBrain()
    
    //to be send to chats
    var sellerNameToSend : String!
    var sellerImageToSend : String!
    
    //review list
    var reviewList  = [SellerRetrievalReviewsModel]()
    // adding the star
    var totalStar = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        designingViews()
        
        retrivingData()
        retrivingReviewsInformation()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        hidesBottomBarWhenPushed = false
    }
    
    
    func retrivingData()  {
        sellerProfileBrain.retrivingProfileData (using : selectedSellerId){ (data,subservices) in
            
            self.sellerName.text = data.name
            self.sellerNameToSend = data.name
            self.sellerCountryLabel.text = data.country
            self.sellerPriceLabel.text = data.price
            self.sellerStatusLabel.text = "available"
            self.sellerDetailLabel.text = data.description
            self.showSubServices(with: subservices)
        
            self.sellerImageToSend = data.imageRef
            
            self.sellerImage.loadCacheImage(with: self.sellerImageToSend)
           
        }
        
    }
    
    
    func showSubServices(with subServices:[String]?) {
        
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
    
    @IBAction func messageButton(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.seguesNames.sellerInfoToMessages, sender: self)
    }
    
    
    
    
    
    func designingViews(){
        navigationItem.hidesBackButton = false
        
        subService1.isHidden = true
        subService2.isHidden = true
        subService3.isHidden = true
        subService4.isHidden = true
        subService5.isHidden = true
        subService6.isHidden = true
        
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
        
        
        sellerImage.layer.masksToBounds = true
        sellerImage.layer.borderColor = UIColor.black.cgColor
         sellerImage.layer.cornerRadius = sellerImage.frame.size.height/2
        sellerImage.contentMode = .scaleAspectFill
    }
    
    func retrivingReviewsInformation() {
        sellerProfileBrain.retrivingSellerReviews(with: selectedSellerId) { (reviews) in
            self.reviewList  = reviews
            
            self.reviewList.forEach { (data) in
                self.totalStar = self.totalStar + Double(Float(data.star)!)
            }
            
            if self.reviewList.count > 0
            {
                let starAverage = self.totalStar / Double(Float(self.reviewList.count))
                self.starAverageLabel.text = String(format: "%.1f",starAverage)
            }
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == Constants.seguesNames.sellerInfoToMessages
        {
            if let destinationSegue = segue.destination as? OneToOneChatViewController
          {
                destinationSegue.otherUserID = selectedSellerId
                destinationSegue.otherUserName = sellerNameToSend
                destinationSegue.otherUserImage = sellerImageToSend
          }
        }
        
        else if segue.identifier == Constants.seguesNames.sellerInfoToInformation
        {
            if let destinationSegue = segue.destination as? CustomerProvideInformation
          {
                destinationSegue.sellerId = selectedSellerId
                
          }
        }
        else if segue.identifier == Constants.seguesNames.sellerInfoToReviews
        {
            if let destinationSegue = segue.destination as? ReviewsTableViewController
          {
                destinationSegue.sellerId  = selectedSellerId
                destinationSegue.reviewList = reviewList
                
          }
        }
        
    }
    

    
    @IBAction func bookNow(_ sender: Any) {
        performSegue(withIdentifier: Constants.seguesNames.sellerInfoToInformation, sender: self)
    }
    
    
    @IBAction func reviewsPressed(_ sender: Any) {
        performSegue(withIdentifier: Constants.seguesNames.sellerInfoToReviews, sender: self)
    }
    
    
    
//    @IBAction func BookNow(_ sender: UIBarButtonItem) {
//        performSegue(withIdentifier: Constants.seguesNames.artistInfoToProfile, sender:self)
//    }
    
}
