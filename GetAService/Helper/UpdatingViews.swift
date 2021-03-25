//
//  Misc.swift
//  GetAService
//
//  Created by Geek on 11/03/2021.
//

import Foundation
import UIKit

extension SellerProfile {
    func initializeHideKeyboard(){
        
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
    
    
    func designingView() {
        
        ///MARK: - adjusting position of keyboard
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name:UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name:UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        
        
        //        saveBarButton.isEnabled = false
        //        saveBarButton.title = ""
        navigationItem.hidesBackButton = false
        //providing dummy  data to dro down
        artistServicesDropDown.optionArray = ["Face treatments"
                                              ,"Hair removel"
                                              ,"Hair salon"
                                              ,"Makeup"
                                              ,"Med spa"
                                              ,"Nails"
                                              ,"Tanning"
                                              ,"Tattoo"]
        
        ///MARK: - designing views
        artistImage.layer.masksToBounds = true
        artistImage.layer.borderColor = UIColor.black.cgColor
        artistImage.layer.cornerRadius = artistImage.frame.size.height/2
        artistImage.contentMode = .scaleAspectFill
        
        sellerDescriptionTextVIew.layer.shadowColor = UIColor.gray.cgColor
        sellerDescriptionTextVIew.layer.shadowOpacity = 0.5
        sellerDescriptionTextVIew.layer.shadowOffset = CGSize.zero
        sellerDescriptionTextVIew.layer.shadowRadius = 7
        //sellerDescriptionTextVIew.delegate = self
        
        
        //shadow
        //artistNameTextField.delegate = self
        artistNameTextField.layer.shadowColor = UIColor.gray.cgColor
        artistNameTextField.layer.shadowOpacity = 0.5
        artistNameTextField.layer.shadowOffset = CGSize.zero
        artistNameTextField.layer.shadowRadius = 7
        // artistNameTextField.delegate = self
        
        
        
        //To apply padding
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: artistNameTextField.frame.height))
        artistNameTextField.leftView = paddingView
        artistNameTextField.leftViewMode = UITextField.ViewMode.always
        
        //  2nd view
        //shadow
        artistAddressTextField.layer.shadowColor = UIColor.gray.cgColor
        artistAddressTextField.layer.shadowOpacity = 0.5
        artistAddressTextField.layer.shadowOffset = CGSize.zero
        artistAddressTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView2 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: artistAddressTextField.frame.height))
        artistAddressTextField.leftView = paddingView2
        artistAddressTextField.leftViewMode = UITextField.ViewMode.always
        
        
        // 3rd view
        //shadow
        artistEmailTextField.layer.shadowColor = UIColor.gray.cgColor
        artistEmailTextField.layer.shadowOpacity = 0.5
        artistEmailTextField.layer.shadowOffset = CGSize.zero
        artistEmailTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView3 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: artistAddressTextField.frame.height))
        artistEmailTextField.leftView = paddingView3
        artistEmailTextField.leftViewMode = UITextField.ViewMode.always
        
        //4rth view
        
        //shadow
        artistPriceTextField.layer.shadowColor = UIColor.gray.cgColor
        artistPriceTextField.layer.shadowOpacity = 0.5
        artistPriceTextField.layer.shadowOffset = CGSize.zero
        artistPriceTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView4 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: artistAddressTextField.frame.height))
        artistPriceTextField.leftView = paddingView4
        artistPriceTextField.leftViewMode = UITextField.ViewMode.always
        
        // 5th view
        
        //shadow
        artistNumberTextField.layer.shadowColor = UIColor.gray.cgColor
        artistNumberTextField.layer.shadowOpacity = 0.5
        artistNumberTextField.layer.shadowOffset = CGSize.zero
        artistNumberTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView5 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: artistAddressTextField.frame.height))
        artistNumberTextField.leftView = paddingView5
        artistNumberTextField.leftViewMode = UITextField.ViewMode.always
        
        //sth view
        submitButton.layer.cornerRadius = 20
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        
        
        //To apply padding
        let paddingView6 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: artistServicesDropDown.frame.height))
        artistServicesDropDown.leftView = paddingView6
        artistServicesDropDown.leftViewMode = UITextField.ViewMode.always
        
        //shadow
        artistServicesDropDown.layer.shadowColor = UIColor.gray.cgColor
        artistServicesDropDown.layer.shadowOpacity = 0.5
        artistServicesDropDown.layer.shadowOffset = CGSize.zero
        artistServicesDropDown.layer.shadowRadius = 7
        
        sellerCountryTextField.layer.shadowColor = UIColor.gray.cgColor
        sellerCountryTextField.layer.shadowOpacity = 0.5
        sellerCountryTextField.layer.shadowOffset = CGSize.zero
        sellerCountryTextField.layer.shadowRadius = 7
        //To apply padding
        let paddingViewC : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: sellerCountryTextField.frame.height))
        sellerCountryTextField.leftView = paddingViewC
        sellerCountryTextField.leftViewMode = UITextField.ViewMode.always
    }
}




extension BuyerProfile {
    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
    func designingView() {
        
        ///MARK: - adjusting position of keyboard
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name:UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name:UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        
        navigationItem.hidesBackButton = false
        
        
        ///MARK: - designing views
        buyerImage.layer.masksToBounds = true
        buyerImage.layer.borderColor = UIColor.black.cgColor
        buyerImage.layer.cornerRadius = buyerImage.frame.size.height/2
        buyerImage.contentMode = .scaleAspectFill
        
        
        
        //        artistNameTextField.layer.cornerRadius = 10
        //        artistNameTextField.layer.borderWidth = 0.1
        //        artistNameTextField.layer.borderColor = UIColor.black.cgColor
        
        //shadow
        buyerNameTextField.layer.shadowColor = UIColor.gray.cgColor
        buyerNameTextField.layer.shadowOpacity = 0.5
        buyerNameTextField.layer.shadowOffset = CGSize.zero
        buyerNameTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: buyerNameTextField.frame.height))
        buyerNameTextField.leftView = paddingView
        buyerNameTextField.leftViewMode = UITextField.ViewMode.always
        
        //  2nd view
        //shadow
        buyerAddressTextField.layer.shadowColor = UIColor.gray.cgColor
        buyerAddressTextField.layer.shadowOpacity = 0.5
        buyerAddressTextField.layer.shadowOffset = CGSize.zero
        buyerAddressTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView2 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: buyerAddressTextField.frame.height))
        buyerAddressTextField.leftView = paddingView2
        buyerAddressTextField.leftViewMode = UITextField.ViewMode.always
        
        
        // 3rd view
        //shadow
        buyerEmailTextField.layer.shadowColor = UIColor.gray.cgColor
        buyerEmailTextField.layer.shadowOpacity = 0.5
        buyerEmailTextField.layer.shadowOffset = CGSize.zero
        buyerEmailTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView3 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: buyerAddressTextField.frame.height))
        buyerEmailTextField.leftView = paddingView3
        buyerEmailTextField.leftViewMode = UITextField.ViewMode.always
        
        //4rth view
        
        //shadow
        buyerPriceTextField.layer.shadowColor = UIColor.gray.cgColor
        buyerPriceTextField.layer.shadowOpacity = 0.5
        buyerPriceTextField.layer.shadowOffset = CGSize.zero
        buyerPriceTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView4 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: buyerAddressTextField.frame.height))
        buyerPriceTextField.leftView = paddingView4
        buyerPriceTextField.leftViewMode = UITextField.ViewMode.always
        
        // 5th view
        
        //shadow
        buyerNumberTextField.layer.shadowColor = UIColor.gray.cgColor
        buyerNumberTextField.layer.shadowOpacity = 0.5
        buyerNumberTextField.layer.shadowOffset = CGSize.zero
        buyerNumberTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView5 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: buyerAddressTextField.frame.height))
        buyerNumberTextField.leftView = paddingView5
        buyerNumberTextField.leftViewMode = UITextField.ViewMode.always
        
        //sth view
        submitButton.layer.cornerRadius = 20
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        
        // 3rd view
        //shadow
        buyerCountry.layer.shadowColor = UIColor.gray.cgColor
        buyerCountry.layer.shadowOpacity = 0.5
        buyerCountry.layer.shadowOffset = CGSize.zero
        buyerCountry.layer.shadowRadius = 7
        
        //To apply padding
        let paddingViewC : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: buyerCountry.frame.height))
        buyerCountry.leftView = paddingViewC
        buyerCountry.leftViewMode = UITextField.ViewMode.always
        
        
    }
    
}


extension SearchViewController
{
    func initializeHideKeyboard(){
        
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
}



extension CustomerProvideInformation
{
    
    
    
    func designingView() {
        ///MARK: - adjusting position of keyboard
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name:UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name:UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        navigationItem.hidesBackButton = false
        ///MARK: - designing views
        
        //shadow
        recepientNameTextField.layer.shadowColor = UIColor.gray.cgColor
        recepientNameTextField.layer.shadowOpacity = 0.5
        recepientNameTextField.layer.shadowOffset = CGSize.zero
        recepientNameTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: recepientNameTextField.frame.height))
        recepientNameTextField.leftView = paddingView
        recepientNameTextField.leftViewMode = UITextField.ViewMode.always
        
        //  2nd view
        //shadow
        phone.layer.shadowColor = UIColor.gray.cgColor
        phone.layer.shadowOpacity = 0.5
        phone.layer.shadowOffset = CGSize.zero
        phone.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView2 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: phone.frame.height))
        phone.leftView = paddingView2
        phone.leftViewMode = UITextField.ViewMode.always
        
        
        // 3rd view
        //shadow
        serviceNeeded.layer.shadowColor = UIColor.gray.cgColor
        serviceNeeded.layer.shadowOpacity = 0.5
        serviceNeeded.layer.shadowOffset = CGSize.zero
        serviceNeeded.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView3 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: serviceNeeded.frame.height))
        serviceNeeded.leftView = paddingView3
        serviceNeeded.leftViewMode = UITextField.ViewMode.always
        
        
        
        //sth view
        bookNowButton.layer.cornerRadius = 20
        bookNowButton.layer.borderWidth = 1
        bookNowButton.layer.borderColor = UIColor.black.cgColor
    }
    
    
    func initializeHideKeyboard(){
        
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
}
