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

        // Do any additional setup after loading the view.
    }
    


    @IBAction func completePressed(_ sender: UIButton) {
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
