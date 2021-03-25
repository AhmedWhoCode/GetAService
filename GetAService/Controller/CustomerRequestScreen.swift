//
//  CustomerRequestScreen.swift
//  GetAService
//
//  Created by Geek on 30/01/2021.
//

import UIKit




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
  
    
    //these values were came from previous class
    var buyerID : String?
    var buyerImage : String?
    var buyerName : String?
    
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
            self.updatingViewsValue()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmPressed(_ sender: UIButton) {
        //notificationBrain.updateBookingStatus(with: "accepted", buyerId: buyerID!, notificationId: notificationId!)
        performSegue(withIdentifier: Constants.seguesNames.orderInfoToMaps, sender: nil)
        
    }
    
    
    @IBAction func rejectPressed(_ sender: UIButton) {
        notificationBrain.updateBookingStatus(with: "rejected", buyerId: buyerID!, notificationId: notificationId!)

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
                
                
                destinationSegue.isSellerASourceVc = true
                destinationSegue.notificationId = notificationID
                destinationSegue.buyerId = buyerID
                destinationSegue.bookingStatus = Constants.orderAccepted


            }
        }
    }

}
