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

    
    var booking:BookingModel?
    //this id will come from the sellerInformation class
    var sellerId : String?
    
    var buyerId = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // dateAndTime.timeZone = .autoupdatingCurrent
        
        //function defined in UpdatingViews file
        designingView()
        
    }
    
    
    @IBAction func proceedPressed(_ sender: UIButton) {
        
       // let date = Date(timeIntervalSince1970: da)
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        let dateString = df.string(from: date)
       // let date = Date(timeIntervalSince1970: date)
       // let date = Date(timeIntervalSince1970: date.seconds)


        booking = BookingModel(
                                         buyerId :buyerId!,
                                         sellerId: sellerId!,
                                         recepientName: recepientNameTextField.text!,
                                         servicesNeeded: serviceNeeded.text!,
                                         phoneNumber: phone.text!,
                                         eventTimeAndDate: dateAndTime.date.convertDateToLocalTime(),
                                         eventDescription: eventDescription.text!,
                                         eventLocation: nil,
                                         dateForUniqueId: dateAndTime.date.timeIntervalSince1970,
                                         bookingStatus: "unSeen"
                
        )
        print("dddd  \(dateString)")

        performSegue(withIdentifier: Constants.seguesNames.informationToMaps, sender: self)
        
    }
    func currentTimeInMilliSeconds()-> Int
        {
            let currentDate = Date()
            let since1970 = currentDate.timeIntervalSince1970
            return Int(since1970 * 1000)
        }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.seguesNames.informationToMaps
        {
            if let destinationSegue = segue.destination as? GoogleMapViewController
            {
                destinationSegue.bookingModel = booking
            }
        }
    }
    
    
}
