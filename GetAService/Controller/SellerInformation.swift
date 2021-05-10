//
//  ArtistInformationViewController.swift
//  GetAService
//
//  Created by Geek on 23/01/2021.
//

import UIKit
import Firebase
import SkeletonView

class SellerInformation: UIViewController {
    //MARK: - IBoutlet variables
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var sellerImage: UIImageView!
    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var sellerStateLabel: UILabel!
    @IBOutlet weak var sellerPriceLabel: UILabel!
    @IBOutlet weak var sellerStatusLabel: UILabel!
    @IBOutlet weak var sellerDetailLabel: UILabel!
    @IBOutlet weak var bookNowButton: UIButton!
    @IBOutlet weak var starAverageLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Local variables
    var selectedSellerId : String!  //value of this variable will come from the previous screen
    var fireStorage = Storage.storage()
    var sellerProfileBrain = SellerProfileBrain()
    var serviceBrain = ServicesBrain()
    var sellerNameToSend : String!  //to be send to chats
    var sellerImageToSend : String!
    var reviewList  = [SellerRetrievalReviewsModel]() //review list
    var totalStar = 0.0 // adding the star
    var selectedPortfolioImagesInString = [String]() // portfolio images list
    var sellerSubservices = [String]()
    var sellerSubservicesWithPrice = [String:String]()
    var selectedImageToEnlarge : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designingViews() //defined in helper folder
        retrivingData()
        retrivingReviewsInformation()

    }
    
    //MARK: - Calling database functions
    func retrivingData()  {
        sellerProfileBrain.retrivingProfileData (using : selectedSellerId){ (data,subservices) in
            //storing subServices
            if let sub = subservices
            {
                self.serviceBrain.retrieveSubservicesWithPriceForPublicProfile(with: self.selectedSellerId, subservices: sub){ (data) in
                    self.sellerSubservicesWithPrice = data
                    self.sellerSubservices = sub
                    self.tableView.reloadData()
                }
                
            }
            self.sellerName.text = data.name
            self.sellerNameToSend = data.name
            self.sellerStateLabel.text = data.state
            self.sellerPriceLabel.text = "$\(data.price)"
            self.sellerStatusLabel.text = "available"
            self.sellerDetailLabel.text = data.description
            self.sellerImageToSend = data.imageRef
            self.sellerImage.loadCacheImage(with: self.sellerImageToSend)
            
        }
        sellerProfileBrain.retrivingPortfolioImages(using: selectedSellerId) { (portfolioImages) in
            
            self.selectedPortfolioImagesInString = portfolioImages
            self.collectionView.stopSkeletonAnimation()
            self.collectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.0001))
            //self.isPortfolioImageSourceFirestore = true
            self.collectionView.reloadData()
        }
        
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
    
    //MARK: - Onclick functions
    
    @IBAction func messageButton(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.seguesNames.sellerInfoToMessages, sender: self)
    }
    
    @IBAction func bookNow(_ sender: Any) {
        performSegue(withIdentifier: Constants.seguesNames.sellerInfoToInformation, sender: self)
        BookingBrain.sharedInstance.sellerName = sellerNameToSend
        BookingBrain.sharedInstance.sellerImage = sellerImageToSend
    }
    
    
    @IBAction func reviewsPressed(_ sender: Any) {
        performSegue(withIdentifier: Constants.seguesNames.sellerInfoToReviews, sender: self)
    }
    
    //MARK: - Ovveriden functions
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
        navigationItem.hidesBackButton = false
    }
    
    
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
        
        else if segue.identifier == Constants.seguesNames.toEnlargedImage
        {
            if let destinationSegue = segue.destination as? EnlargedImageViewController
            {
                if let image = selectedImageToEnlarge
                {
                    destinationSegue.image = image
                }
                else
                {
                    return
                }
            }
        }
        
    }
    
}

//MARK: - extension with collectionview to show portfolio images
extension SellerInformation : UICollectionViewDelegate , SkeletonCollectionViewDataSource
{
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "portfolioCollectionCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return selectedPortfolioImagesInString.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "portfolioCollectionCell", for: indexPath) as? PortfolioCollectionViewCell
        
        
        cell?.portfolioImage.loadCacheImage(with: selectedPortfolioImagesInString[indexPath.row])
        return cell!
    }
    
    private func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImageToEnlarge = selectedPortfolioImagesInString[indexPath.row]
        performSegue(withIdentifier: Constants.seguesNames.toEnlargedImage, sender: self)
    }
    
    
}

//MARK: - extention with table view to show subservices with price
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
