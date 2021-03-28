//
//  SellerWaitingViewController.swift
//  GetAService
//
//  Created by Geek on 01/03/2021.
//

import UIKit

class SellerWaitingViewController: UIViewController,BookingBrainDelegate  {
  
    
   
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = false
        BookingBrain.sharedInstance.bookingBrainDelegate = self
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
        
        if result == "started"
        {
            print("why 4")
            performSegue(withIdentifier: Constants.seguesNames.sellerWaitingToMeetup, sender: self)
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
