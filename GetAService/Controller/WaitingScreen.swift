//
//  WaitingScreen.swift
//  GetAService
//
//  Created by Geek on 02/02/2021.
//

import UIKit

class WaitingScreen: UIViewController , BookingBrainDelegate {
    
    let userDefault = UserDefaults.standard


    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      

        BookingBrain.sharedInstance.bookingBrainDelegate  = self
        BookingBrain.sharedInstance.acknowledgmentUpdated()
        do
        {
        let gif = try UIImage(gifName: Constants.gifNames.inProgressGif)
        imageView.setGifImage(gif, loopCount: -1)
        }
        catch
        {
            
        }
           
        // Do any additional setup after loading the view.
    }
    
  
    func didSendTheBookingDetails() {}
    
    func didSellerRespond(result: String) {}
    
    func didAcknowledgementChange(result: String) {
        print("not sure")
        if result == "completed"
        {
            userDefault.set("completed", forKey: "navigationInfo")
            performSegue(withIdentifier: Constants.seguesNames.buyerWaitingToReviews, sender: self)
        }
        
    }
    func settingUpUserDefaultValues() {
        //setting up user defaults
        userDefault.set("started", forKey: Constants.navigationInfo)
        userDefault.set(BookingBrain.sharedInstance.sellerId, forKey: Constants.sellerIdForNavigation)
        userDefault.set(BookingBrain.sharedInstance.buyerId, forKey: Constants.buyerIdForNavigation)
        userDefault.set(BookingBrain.sharedInstance.currentBookingDocumentId, forKey: Constants.notificationIdForNavigation)
        userDefault.set("started", forKey: Constants.navigationInfo)
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
