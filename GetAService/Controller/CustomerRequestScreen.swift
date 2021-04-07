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



class CustomerRequestScreen: UIViewController {

    @IBOutlet weak var customerImage: UIImageView!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var customerInfoView: UIView!
    //@IBOutlet weak var changeLocationButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    
    @IBOutlet weak var serviceNeeded: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventDetail: UITextView!
    
    @IBOutlet weak var locationView: UIView!
  
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
        
      

        notificationBrain.retrivingNotificationDetail(using: buyerID!) { data,id  in
            //print(data)
            self.notificationData = data
            print("this is the id \(id)")
            self.notificationId = id
            
            BookingBrain.sharedInstance.buyerId = self.buyerID
            BookingBrain.sharedInstance.sellerId = Auth.auth().currentUser?.uid
            BookingBrain.sharedInstance.currentBookingDocumentId = id
            self.updatingViewsValue()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmPressed(_ sender: UIButton) {
        sender.isEnabled = false
        showInputDialog(title: "Add your price", subtitle: "if you pressed retain then your profile price will be used", actionTitle: "Add", cancelTitle: "Retain the price", inputPlaceholder: "New price", inputKeyboardType: .numberPad) { (alert) in
            
            self.sellerProfileBrain.retrivingProfileDataForBooking(using:(Auth.auth().currentUser?.uid)! , completion: { (sellerPrice) in
                self.sellerUpdatedPrice = sellerPrice
                self.performSegue(withIdentifier: Constants.seguesNames.orderInfoToMaps, sender: nil)

            })

        } actionHandler: { (amount) in
            self.sellerUpdatedPrice = amount
            self.performSegue(withIdentifier: Constants.seguesNames.orderInfoToMaps, sender: nil)

        }

        
        //notificationBrain.updateBookingStatus(with: "accepted", buyerId: buyerID!, notificationId: notificationId!)
        
    }
    
    
    @IBAction func rejectPressed(_ sender: UIButton) {
        notificationBrain.updateBookingStatus(with: "rejected", buyerId: buyerID!, notificationId: notificationId!)
        BookingBrain.sharedInstance.updateAcknowledgeStatus(value: "rejected") {
        self.performSegue(withIdentifier: Constants.seguesNames.orderInfoToSellerDash, sender: self)

        }
    }

    
    
    func updatingViewsValue() {
    
        customerImage.loadCacheImage(with: buyerImage!)
        customerName.text = buyerName
        serviceNeeded.text = notificationData?.serivceNeeded
        eventTime.text = notificationData?.eventTimeAndDate
        eventLocation.text = notificationData?.eventlocationAddress
        eventDetail.text = notificationData?.eventDescription
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.seguesNames.orderInfoToMaps
        {
            if let destinationSegue = segue.destination as? GoogleMapViewController
            {
            
                guard let notificationID = notificationId else {
                    return
                }
                
                guard let buyerID = buyerID else {
                    return
                }
                
                guard let sellerUpdatedPrice = sellerUpdatedPrice else {
                    return
                }
                
                
                destinationSegue.isSellerASourceVc = true
                destinationSegue.notificationId = notificationID
                destinationSegue.buyerId = buyerID
                destinationSegue.bookingStatus = Constants.orderAccepted
                destinationSegue.sellerPriceUpdated = sellerUpdatedPrice

            }
        }
    }

}
extension CustomerRequestScreen {
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
}
