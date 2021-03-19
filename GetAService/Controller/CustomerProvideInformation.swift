//
//  CustomerProvideInformation.swift
//  GetAService
//
//  Created by Geek on 26/01/2021.
//

import UIKit
import Firebase

class CustomerProvideInformation: UIViewController {
    @IBOutlet weak var bookNowButton: UIButton!
    @IBOutlet weak var recepientNameTextField: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var serviceNeeded: UITextField!
    @IBOutlet weak var dateAndTime: UIDatePicker!
    @IBOutlet weak var eventDescription: UITextView!

    
    var notification:NotificationModel?
    //this id will come from the sellerInformation class
    var sellerId : String?
    
    var buyerId = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateAndTime.timeZone = .autoupdatingCurrent
        
        //function defined in UpdatingViews file
        designingView()
        
    }
    
    
    @IBAction func proceedPressed(_ sender: UIButton) {

        notification = NotificationModel(
                                         buyerId :buyerId!,
                                         sellerId: sellerId!,
                                         recepientName: recepientNameTextField.text!,
                                         servicesNeeded: serviceNeeded.text!,
                                         phoneNumber: phone.text!,
                                         eventTimeAndDate: dateAndTime.date.convertDateToLocalTime(),
                                         eventDescription: eventDescription.text!,
                                         eventLocation: nil,
                                         dateForUniqueId: dateAndTime.date.timeIntervalSince1970
        )
        
        performSegue(withIdentifier: Constants.seguesNames.informationToMaps, sender: self)
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.seguesNames.informationToMaps
        {
            if let destinationSegue = segue.destination as? GoogleMapViewController
            {
                destinationSegue.notificationModel = notification
            }
        }
    }
    
    
}
