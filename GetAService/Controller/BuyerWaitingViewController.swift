//
//  BuyerWaitingViewController.swift
//  GetAService
//
//  Created by Geek on 23/03/2021.
//

import UIKit

class BuyerWaitingViewController: UIViewController , BookingBrainDelegant {
    
    
    var buyerId :String?
    var sellerId :String?
    //var boookingBrain 
    override func viewDidLoad() {
        super.viewDidLoad()
        BookingBrain.sharedInstance.bookingBrainDelegant = self
        BookingBrain.sharedInstance.sellerResponded()
    }
    
    func didSendTheBookingDetails(){}
    
    func didSellerRespond(result: String) {
        if result == "accepted"
        {
            showToast1(controller: self, message: "Offer Accepted", seconds: 1, color: .green)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                
                self.performSegue(withIdentifier: Constants.seguesNames.waitingToUberInfo, sender: self)
                
            }
            
        }
        else if result == "rejected"
        {
            
            showToast1(controller: self, message: "Offer Rejected", seconds: 2, color: .red)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                
                self.performSegue(withIdentifier: Constants.seguesNames.waitingToServices, sender: self)
                
            }
        }
    }
    
}
