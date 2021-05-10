//
//  CustomerProvideInformation.swift
//  GetAService
//
//  Created by Geek on 26/01/2021.
//

import UIKit
import Firebase

class CustomerProvideInformation: UIViewController {
    //MARK: - IBOutlet variables
    @IBOutlet weak var bookNowButton: UIButton!
    @IBOutlet weak var recepientNameTextField: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var serviceNeeded: UITextField!
    @IBOutlet weak var dateAndTime: UIDatePicker!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - Local variables
    var booking:BookingModel?
    var sellerId : String? //this id will come from the sellerInformation class
    var buyerId = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //attaching touch sensor with a view, whenever you press a view keyboard will disappear
        initializeHideKeyboard()
        designingView()  //function defined in UpdatingViews file

        
    }

    
    //MARK: - Local functions
    
    func savingTheGatheredDataInModelVariable() {
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        let dateString = df.string(from: date)
       

        booking = BookingModel( buyerId :buyerId!,
                                         sellerId: sellerId!,
                                         recepientName: recepientNameTextField.text!,
                                         servicesNeeded: serviceNeeded.text!,
                                         phoneNumber: phone.text!,
                                         eventTimeAndDate: dateAndTime.date.convertDateToLocalTime(),
                                         eventDescription: eventDescription.text!,
                                         eventLocation: nil,
                                         timeOfOrder: date,
                                         bookingStatus: "unSeen",
                                         dateForUniqueId : dateString,
                                         sellerLatitude: "not Defined yet",
                                         sellerLongitude: "not defined yet",
                                         sellerLocationAddress: "not defined yet",
                                         sellerPrice: "Nil for now"
                
        )
        
        performSegue(withIdentifier: Constants.seguesNames.informationToMaps, sender: self)
    }
    
    //MARK: - Onclick functions
    
    @IBAction func proceedPressed(_ sender: UIButton) {
     savingTheGatheredDataInModelVariable()
    }
    
    //MARK: - Ovveriden functions
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
        navigationItem.hidesBackButton = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.seguesNames.informationToMaps
        {
            if let destinationSegue = segue.destination as? GoogleMapViewController
            {
                destinationSegue.bookingModel = booking
            }
        }
    }

    //MARK: - Misc functions
    // To adjust the size of keyboard with scroll view , this function is called from extention
    // to adjust keyboard size will typing
    @objc func keyboardWillShow(notification:NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
}
