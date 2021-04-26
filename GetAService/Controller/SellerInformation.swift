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
    
//    @IBOutlet weak var subService1: UILabel!
//    @IBOutlet weak var subService2: UILabel!
//    @IBOutlet weak var subService3: UILabel!
//    @IBOutlet weak var subService4: UILabel!
//    @IBOutlet weak var subService5: UILabel!
//    @IBOutlet weak var subService6: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    //value of this variable will come from the previous screen
    var selectedSellerId : String!
    
    var fireStorage = Storage.storage()
    
    var sellerProfileBrain = SellerProfileBrain()
    var serviceBrain = ServicesBrain()

    
    //to be send to chats
    var sellerNameToSend : String!
    var sellerImageToSend : String!
    
    //review list
    var reviewList  = [SellerRetrievalReviewsModel]()
    
    // adding the star
    var totalStar = 0.0
    
    // portfolio images list
    var selectedPortfolioImagesInString = [String]()

    var sellerSubservices = [String]()
    var sellerSubservicesWithPrice = [String:String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        designingViews()
        
        retrivingData()
        retrivingReviewsInformation()
        

        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
        navigationItem.hidesBackButton = false
    }
    
    
    func retrivingData()  {
        sellerProfileBrain.retrivingProfileData (using : selectedSellerId){ (data,subservices) in
        
            //storing subServices
            if let sub = subservices
            {
                self.serviceBrain.retrieveSubservicesWithPriceForPublicProfile(with: self.selectedSellerId, subservices: sub) { (data) in
                    self.sellerSubservicesWithPrice = data
                    self.sellerSubservices = sub
                    self.tableView.reloadData()
                }
               
            }
        
            self.sellerName.text = data.name
            self.sellerNameToSend = data.name
            self.sellerCountryLabel.text = data.country
            self.sellerPriceLabel.text = data.price
            self.sellerStatusLabel.text = "available"
            self.sellerDetailLabel.text = data.description
           // self.showSubServices(with: subservices)
            
            self.sellerImageToSend = data.imageRef
            
            self.sellerImage.loadCacheImage(with: self.sellerImageToSend)
            
        }
        sellerProfileBrain.retrivingPortfolioImages(using: selectedSellerId) { (portfolioImages) in
          
            self.selectedPortfolioImagesInString = portfolioImages
            //self.isPortfolioImageSourceFirestore = true
            self.collectionView.reloadData()
        }
        
    }
    
//
//    func showSubServices(with subServices:[String]?) {
//
//        if let subServices = subServices
//        {
//            let numberOfSubServices = subServices.count
//
//            switch numberOfSubServices {
//            case 1:
//                subService1.isHidden = false
//                subService1.text = subServices[0]
//            case 2:
//                subService1.isHidden = false
//                subService2.isHidden = false
//                subService1.text = subServices[0]
//                subService2.text = subServices[1]
//            case 3:
//                subService1.isHidden = false
//                subService2.isHidden = false
//                subService3.isHidden = false
//
//                subService1.text = subServices[0]
//                subService2.text = subServices[1]
//                subService3.text = subServices[2]
//            case 4:
//                subService1.isHidden = false
//                subService2.isHidden = false
//                subService3.isHidden = false
//                subService4.isHidden = false
//
//                subService1.text = subServices[0]
//                subService2.text = subServices[1]
//                subService3.text = subServices[2]
//                subService4.text = subServices[3]
//            case 5:
//                subService1.isHidden = false
//                subService2.isHidden = false
//                subService3.isHidden = false
//                subService4.isHidden = false
//                subService5.isHidden = false
//
//                subService1.text = subServices[0]
//                subService2.text = subServices[1]
//                subService3.text = subServices[2]
//                subService4.text = subServices[3]
//                subService5.text = subServices[4]
//
//            case 6:
//                subService1.isHidden = false
//                subService2.isHidden = false
//                subService3.isHidden = false
//                subService4.isHidden = false
//                subService5.isHidden = false
//                subService6.isHidden = false
//
//                subService1.text = subServices[0]
//                subService2.text = subServices[1]
//                subService3.text = subServices[2]
//                subService4.text = subServices[3]
//                subService5.text = subServices[4]
//                subService6.text = subServices[5]
//
//            default:
//                print("no services")
//            }
//        }
//
//    }
    
    @IBAction func messageButton(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.seguesNames.sellerInfoToMessages, sender: self)
    }
    
    
    func retrivingReviewsInformation() {
        sellerProfileBrain.retrivingSellerReviews(with: selectedSellerId!) { (reviews) in
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
        BookingBrain.sharedInstance.sellerName = sellerNameToSend
        BookingBrain.sharedInstance.sellerImage = sellerImageToSend
    }
    
    
    @IBAction func reviewsPressed(_ sender: Any) {
        performSegue(withIdentifier: Constants.seguesNames.sellerInfoToReviews, sender: self)
    }
    
    
    
    //    @IBAction func BookNow(_ sender: UIBarButtonItem) {
    //        performSegue(withIdentifier: Constants.seguesNames.artistInfoToProfile, sender:self)
    //    }
    
}


extension SellerInformation : UICollectionViewDelegate , UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return selectedPortfolioImagesInString.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "portfolioCollectionCell", for: indexPath) as? PortfolioCollectionViewCell
     
            
            cell?.portfolioImage.loadCacheImage(with: selectedPortfolioImagesInString[indexPath.row])
        return cell!
    }
    
    
}

extension SellerInformation : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sellerSubservices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
        let cell = tableView.dequeueReusableCell(withIdentifier: "sellerSubservices", for: indexPath) as? SubServicesTableViewCell
        
        cell?.name.text = sellerSubservices[indexPath.row]
        cell?.price.text = sellerSubservicesWithPrice[(cell?.name.text)!]
        
        return cell!
        
    }
    
   
    
}
