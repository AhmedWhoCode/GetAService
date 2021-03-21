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
  
    
    //its value was came from previous class
    var buyerID : String?
    var buyerImage : String?
    var buyerName : String?
    
    var notificationBrain  = NotificationBrain()
    var notificationData : NotificationDetailModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        desigingView()
         print("ok \(buyerID)")
        notificationBrain.retrivingNotificationDetail(using: buyerID!) { (data) in
            print(data)
            self.notificationData = data
            self.updatingViewsValue()
        }
        // Do any additional setup after loading the view.
    }
    
    func updatingViewsValue() {
    
        customerImage.loadCacheImage(with: buyerImage!)
        customerName.text = buyerName
        serviceNeeded.text = notificationData?.serivceNeeded
        eventTime.text = notificationData?.eventTimeAndDate
        eventLocation.text = notificationData?.eventlocationAddress
        eventDetail.text = notificationData?.eventDescription
        
    }
    func desigingView(){
        //hides back button of top navigation
        navigationItem.hidesBackButton = false

        //MARK: - adding roundness to image
        customerImage.layer.masksToBounds = true
        customerImage.layer.borderWidth = 1
        customerImage.layer.borderColor = UIColor.black.cgColor
        customerImage.layer.cornerRadius = customerImage.frame.size.height/2
        customerImage.contentMode = .scaleAspectFill
        
        //MARK: - adding shadow to info view
        customerInfoView.layer.cornerRadius = 10
        customerInfoView.layer.shadowColor = UIColor.gray.cgColor
        customerInfoView.layer.shadowOpacity = 1
        customerInfoView.layer.shadowRadius = 10
        
        //MARK: -making views round
//      locationView.layer.cornerRadius = 25
//        locationView.layer.borderWidth = 0.5
//        locationView.layer.borderColor = UIColor.black.cgColor
        
        //MARK: - adding shadow to info view
        locationView.layer.cornerRadius = 10
        locationView.layer.shadowColor = UIColor.gray.cgColor
        locationView.layer.shadowOpacity = 1
        locationView.layer.shadowRadius = 10
        
        //MARK: -making views round
        confirmButton.layer.cornerRadius = 25
        confirmButton.layer.borderWidth = 1
        confirmButton.layer.borderColor = UIColor.black.cgColor
        
        
//        changeLocationButton.layer.cornerRadius = 25
//        changeLocationButton.layer.borderWidth = 1
//        changeLocationButton.layer.borderColor = UIColor.black.cgColor
        
        
        rejectButton.layer.cornerRadius = 25
        rejectButton.layer.borderWidth = 1
        rejectButton.layer.borderColor = UIColor.black.cgColor
        
        

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
