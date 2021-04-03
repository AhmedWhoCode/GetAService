//
//  ReviewsAndRatingsViewController.swift
//  GetAService
//
//  Created by Geek on 29/03/2021.
//

import UIKit

class ReviewsAndRatingsViewController: UIViewController {
    
    @IBOutlet weak var oneStar: UIImageView!
    @IBOutlet weak var twoStar: UIImageView!
    @IBOutlet weak var threeStar: UIImageView!
    @IBOutlet weak var fourStar: UIImageView!
    @IBOutlet weak var fiveStar: UIImageView!
    
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var publishButton: UIButton!
    
    
    var isGrey = true
    var starCount = 0
    var isSourceAMeetupVc = false
    
    let sellerProfile =  SellerProfileBrain()
    let buyerProfile  =  BuyerProfileBrain()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reviewTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.reviewTextView.layer.borderWidth = 1
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func publishPressed(_ sender: UIButton) {
        if let comment = reviewTextView.text
        {
            //checking if this is seller or buyer
            if isSourceAMeetupVc
            {
                //storing information to booking collection
                BookingBrain.sharedInstance.sellerToBuyerReview(with: starCount.description, comment: comment) {
                    //adding information to buyer profile
                    self.addingReviewsBuyer(with: comment)
                }
                
            }
            else
            {
                //storing information to booking collection
                BookingBrain.sharedInstance.buyerToSellerReview(with: starCount.description, comment: comment) {
                    //adding information to seller profile
                    self.addingReviewsSeller(with: comment)
                }
                
            }
            
        }
        else
        {
            showToast1(controller: self, message: "Dont leave comment section empty", seconds: 1, color: .red)
        }
    }
    
    
    func addingReviewsSeller(with comment : String) {
        self.sellerProfile.addReviewsToProfile(with: BookingBrain.sharedInstance.sellerId!,
                                               buyerId: BookingBrain.sharedInstance.buyerId!,
                                               star: self.starCount.description,
                                               comment: comment,
                                               uniqueId: BookingBrain.sharedInstance.currentBookingDocumentId!) {
            
            self.performSegue(withIdentifier: Constants.seguesNames.buyerReviewToServices, sender: self)
        }
        
    }
    
    func addingReviewsBuyer(with comment : String) {
        self.buyerProfile.addReviewsToProfile(with: BookingBrain.sharedInstance.sellerId!,
                                              buyerId: BookingBrain.sharedInstance.buyerId!,
                                              star: self.starCount.description,
                                              comment: comment,
                                              uniqueId: BookingBrain.sharedInstance.currentBookingDocumentId!) {
            self.performSegue(withIdentifier: Constants.seguesNames.reviewToSellerDash, sender: self)
        }
        
    }
    
    
    
    @IBAction func oneStar(_ sender: Any) {
        if isGrey
        {
            oneStar.tintColor = .yellow
            isGrey = false
            starCount = 1
        }
        else
        {
            makeItGrey()
            
        }
    }
    @IBAction func twoStar(_ sender: Any) {
        
        if isGrey
        {
            oneStar.tintColor = .yellow
            twoStar.tintColor = .yellow
            isGrey = false
            starCount = 2
            
        }
        else
        {
            makeItGrey()
        }
        
    }
    @IBAction func threeStar(_ sender: Any) {
        if isGrey
        {
            oneStar.tintColor = .yellow
            twoStar.tintColor = .yellow
            threeStar.tintColor = .yellow
            isGrey = false
            starCount = 3
            
        }
        else
        {
            makeItGrey()
        }
        
    }
    @IBAction func fourStar(_ sender: Any) {
        if isGrey
        {
            oneStar.tintColor = .yellow
            twoStar.tintColor = .yellow
            threeStar.tintColor = .yellow
            fourStar.tintColor = .yellow
            isGrey = false
            starCount = 4
            
        }
        else
        {
            makeItGrey()
            
        }
        
        
    }
    @IBAction func fiveStar(_ sender: Any) {
        if isGrey
        {
            oneStar.tintColor = .yellow
            twoStar.tintColor = .yellow
            threeStar.tintColor = .yellow
            fourStar.tintColor = .yellow
            fiveStar.tintColor = .yellow
            isGrey = false
            starCount = 5
            
        }
        else
        {
            makeItGrey()
            
        }
        
    }
    
    
    func makeItGrey() {
        oneStar.tintColor = .tertiaryLabel
        twoStar.tintColor = .tertiaryLabel
        threeStar.tintColor = .tertiaryLabel
        fourStar.tintColor = .tertiaryLabel
        fiveStar.tintColor = .tertiaryLabel
        isGrey = true
        starCount = 0
        
    }
}
