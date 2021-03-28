//
//  BuyerWaitingViewController.swift
//  GetAService
//
//  Created by Geek on 23/03/2021.
//

import UIKit

class BuyerWaitingViewController: UIViewController , BookingBrainDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BookingBrain.sharedInstance.bookingBrainDelegate = self
        do
        {
        let gif = try UIImage(gifName: Constants.gifNames.inProgressGif)
        imageView.setGifImage(gif, loopCount: -1)
        }
        catch
        {
            
        }
        BookingBrain.sharedInstance.sellerResponded()
    }
    
    func didSendTheBookingDetails(){}
    func didAcknowledgementChange(result: String){}
    
    func didSellerRespond(result: String) {
        if result == "accepted"
        {
            showToast1(controller: self, message: "Offer Accepted", seconds: 1, color: .green)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                print("after")
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("this")
//
//        if segue.identifier == Constants.seguesNames.waitingToUberInfo
//        {
//            print("this2")
//
//            if let destinationSegue = segue.destination as? FairDetails
//            {
//                print("this3")
//                 print(buyerId)
//                print(sellerId)
//                
//                guard let buyerID = buyerId else {return}
//                guard let sellerID = sellerId else {return}
//                
//                print("11 \(buyerID)")
//                print("11 \(sellerID)")
//
//                destinationSegue.buyerId = buyerID
//                destinationSegue.sellerId = sellerID
//            }
//        }
//    
//    }

    
}
