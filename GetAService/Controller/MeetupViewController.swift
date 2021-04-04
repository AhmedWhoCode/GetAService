//
//  MeetupViewController.swift
//  GetAService
//
//  Created by Geek on 28/03/2021.
//

import UIKit

class MeetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        MyUserDefaults.sharedInstance.settingUpUserDefaultValues(with: "started")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
    }

    @IBAction func completePressed(_ sender: UIButton) {
        MyUserDefaults.sharedInstance.updatingNavigationStatus(with: "completed")

        BookingBrain.sharedInstance.updateAcknowledgeStatus(value: "completed") {
            self.hidesBottomBarWhenPushed = false
            self.performSegue(withIdentifier: Constants.seguesNames.meetupToReview, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.seguesNames.meetupToReview
        {
            if let destinationSegue = segue.destination as? ReviewsAndRatingsViewController
            {
            
                destinationSegue.isSourceAMeetupVc = true

            }
        }
    }
}
