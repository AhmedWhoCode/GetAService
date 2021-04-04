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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var isGrey = true
    var starCount = 0
    var isSourceAMeetupVc = false
    
    let sellerProfile =  SellerProfileBrain()
    let buyerProfile  =  BuyerProfileBrain()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reviewTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.reviewTextView.layer.borderWidth = 1
        
        initializeHideKeyboard()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = true
        ///MARK: - adjusting position of keyboard
        //method are defined in a view controller
        //these methods will invoke when the keyboard is appear and disappear so set the size of scroll view accordingly
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name:UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name:UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
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
    
    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }

    
    
    // to adjust keyboard size will typing
    @objc func keyboardWillShow(notification:NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}
