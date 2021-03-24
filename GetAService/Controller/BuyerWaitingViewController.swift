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
        // Do any additional setup after loading the view.
    }
    
    func didSendTheBookingDetails(){}
    
    func didSellerRespond(result: String) {
        if result == "accepted"
        {
            print("why22")
            // BookingBrain.sharedInstance.check = true
            showToast1(controller: self, message: "Offer Accepted", seconds: 2, color: .red)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                
                self.performSegue(withIdentifier: Constants.seguesNames.waitingToUberInfo, sender: self)
                
            }
            
        }
        else if result == "rejected"
        {
            // BookingBrain.sharedInstance.check = true
            
            showToast1(controller: self, message: "Offer Rejected", seconds: 2, color: .red)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                
                self.performSegue(withIdentifier: Constants.seguesNames.waitingToServices, sender: self)
                
            }
        }
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
