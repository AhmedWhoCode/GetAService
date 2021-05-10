//
//  CustomerRequestScreen.swift
//  GetAService
//
//  Created by Geek on 30/01/2021.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Firebase



class BuyerRequestScreen: UIViewController {
    
    //MARK: - IBOutlet variables
    @IBOutlet weak var buyerImageImageView: UIImageView!
    @IBOutlet weak var buyerNameLabel: UILabel!
    @IBOutlet weak var buyerInfoView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var serviceNeeded: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventDetail: UITextView!
    @IBOutlet weak var locationView: UIView!
    
    //MARK: - Local variables
    var sellerProfileBrain = SellerProfileBrain()
    //these values were came from previous class
    var buyerID : String?
    var buyerImage : String?
    var buyerName : String?
    
    var sellerUpdatedPrice : String?
    var notificationBrain  = NotificationBrain()
    var notificationData : NotificationDetailModel?
    var notificationId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        desigingView()
        
        retrivingNotificationDetail()
        
        
    }
    
    //MARK: - Calling database functions
    func retrivingNotificationDetail() {
        notificationBrain.retrivingNotificationDetail(using: buyerID!) { data,id  in
            //print(data)
            self.notificationData = data
            self.notificationId = id
            
            BookingBrain.sharedInstance.buyerId = self.buyerID
            BookingBrain.sharedInstance.sellerId = Auth.auth().currentUser?.uid
            BookingBrain.sharedInstance.currentBookingDocumentId = id
            self.updatingViewsValue()
        }
    }
    
    //MARK: - Local functions
    
    func updatingViewsValue()
    {
        
        buyerImageImageView.loadCacheImage(with: buyerImage!)
        buyerNameLabel.text = buyerName
        serviceNeeded.text = notificationData?.serivceNeeded
        eventTime.text = notificationData?.eventTimeAndDate
        eventLocation.text = notificationData?.eventlocationAddress
        eventDetail.text = notificationData?.eventDescription
        
    }
    //MARK: - Onclick functions
    
    @IBAction func rejectPressed(_ sender: UIButton) {
        notificationBrain.updateBookingStatus(with: "rejected", buyerId: buyerID!, notificationId: notificationId!)
        BookingBrain.sharedInstance.updateAcknowledgeStatus(value: "rejected") {
            self.performSegue(withIdentifier: Constants.seguesNames.orderInfoToSellerDash, sender: self)
            
        }
    }
    
    
    @IBAction func confirmPressed(_ sender: UIButton) {
        sender.isEnabled = false
        //this function is defined in extention file
        showInputDialog(viewController: self,title: "Add your price", subtitle: "if you pressed retain then your profile price will be used", actionTitle: "Add", cancelTitle: "Retain the price", inputPlaceholder: "New price", inputKeyboardType: .numberPad) { (alert) in
            
            self.sellerProfileBrain.retrivingProfileDataForBooking(using:(Auth.auth().currentUser?.uid)! , completion: { (sellerPrice) in
                self.sellerUpdatedPrice = sellerPrice
                self.performSegue(withIdentifier: Constants.seguesNames.orderInfoToMaps, sender: nil)
                
            })
            
        } actionHandler: { (amount) in
            self.sellerUpdatedPrice = amount
            self.performSegue(withIdentifier: Constants.seguesNames.orderInfoToMaps, sender: nil)
            
        }
        
        
    }
    //MARK: - Ovveriden functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.seguesNames.orderInfoToMaps
        {
            if let destinationSegue = segue.destination as? GoogleMapViewController
            {
                guard let notificationID = notificationId else {return}
                guard let buyerID = buyerID else {return}
                guard let sellerUpdatedPrice = sellerUpdatedPrice else {return}
                
                destinationSegue.isSellerASourceVc = true
                destinationSegue.notificationId = notificationID
                destinationSegue.buyerId = buyerID
                destinationSegue.bookingStatus = Constants.orderAccepted
                destinationSegue.sellerPriceUpdated = sellerUpdatedPrice
                
            }
        }
    }
}
