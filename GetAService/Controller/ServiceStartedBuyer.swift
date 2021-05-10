//
//  WaitingScreen.swift
//  GetAService
//
//  Created by Geek on 02/02/2021.
//

import UIKit

class ServiceStartedBuyer: UIViewController , BookingBrainDelegate {
    
    //MARK: - Global variable
    let userDefault = UserDefaults.standard
    
    //MARK: - IBOutlet variables
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BookingBrain.sharedInstance.bookingBrainDelegate  = self
        
        navigationItem.hidesBackButton = true
        hidesBottomBarWhenPushed = true
        
        MyUserDefaults.sharedInstance.settingUpUserDefaultValues(with: "started")
        
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
    
    //MARK: - Calling database functions
    
    //MARK: - Local functions
    
    //MARK: - Onclick functions
    
    //MARK: - Ovveriden functions
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = true
        hidesBottomBarWhenPushed = true
    }
    
    func didSendTheBookingDetails() {}
    func didSellerRespond(result: String) {}
    
    func didAcknowledgementChange(result: String) {
        if result == "completed"
        {
            MyUserDefaults.sharedInstance.updatingNavigationStatus(with:"completed")
            performSegue(withIdentifier: Constants.seguesNames.buyerWaitingToReviews, sender: self)
        }
    }
    
}
