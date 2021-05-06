//
//  Misc.swift
//  GetAService
//
//  Created by Geek on 11/03/2021.
//

import Foundation
import UIKit
import DropDown



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
        //method are defined in a view controller
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
        artistServicesDropDownList.dataSource = ["Face treatments"
                                              ,"Hair removal"
                                              ,"Hair salon"
                                              ,"Makeup"
                                              ,"Med spa"
                                              ,"Nails"
                                              ,"Tanning"
                                              ,"Tattoo"
                                              ,"Barber"]
        
        
        artistServicesDropDownList.isMultipleTouchEnabled = false
        artistServicesDropDownList.bottomOffset = CGPoint(x: 0, y:(artistServicesDropDownList.anchorView!.plainView.bounds.height))
        DropDown.appearance().selectionBackgroundColor = UIColor.yellow

        
        
        
        ///MARK: - designing views
        artistImage.layer.masksToBounds = true
        artistImage.layer.borderColor = UIColor.black.cgColor
        artistImage.layer.cornerRadius = artistImage.frame.size.height/2
        artistImage.contentMode = .scaleAspectFill
        
        sellerDescriptionTextVIew.layer.masksToBounds = true
        sellerDescriptionTextVIew.layer.shadowColor = UIColor.black.cgColor
        sellerDescriptionTextVIew.layer.shadowOpacity = 1
        //sellerDescriptionTextVIew.layer.shadowOffset = CGSize.zero
        sellerDescriptionTextVIew.layer.cornerRadius = 10
        //sellerDescriptionTextVIew.delegate = self
        
        
        //shadow
        //artistNameTextField.delegate = self
        artistNameTextField.layer.shadowColor = UIColor.gray.cgColor
        artistNameTextField.layer.shadowOpacity = 0.5
        sellerDescriptionTextVIew.layer.cornerRadius = 10
        // artistNameTextField.delegate = self
        
   
        
        documentView.layer.shadowColor = UIColor.gray.cgColor
        documentView.layer.shadowOpacity = 0.5
        documentView.layer.shadowOffset = CGSize.zero
        documentView.layer.borderWidth = 0.3
        documentView.layer.cornerRadius = 10

        
        //To apply padding
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: artistNameTextField.frame.height))
        artistNameTextField.leftView = paddingView
        artistNameTextField.leftViewMode = UITextField.ViewMode.always
        
        //  2nd view
        //shadow
        sellerStateTextField.layer.shadowColor = UIColor.gray.cgColor
        sellerStateTextField.layer.shadowOpacity = 0.5
        sellerStateTextField.layer.shadowOffset = CGSize.zero
        sellerStateTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView2 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: sellerStateTextField.frame.height))
        sellerStateTextField.leftView = paddingView2
        sellerStateTextField.leftViewMode = UITextField.ViewMode.always
        
        
        // 3rd view
        //shadow
        sellerEmailTextField.layer.shadowColor = UIColor.gray.cgColor
        sellerEmailTextField.layer.shadowOpacity = 0.5
        sellerEmailTextField.layer.shadowOffset = CGSize.zero
        sellerEmailTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView3 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: sellerStateTextField.frame.height))
        sellerEmailTextField.leftView = paddingView3
        sellerEmailTextField.leftViewMode = UITextField.ViewMode.always
        
        //4rth view
        
        //shadow
//        sellerPriceTextField.layer.shadowColor = UIColor.gray.cgColor
//        sellerPriceTextField.layer.shadowOpacity = 0.5
//        sellerPriceTextField.layer.shadowOffset = CGSize.zero
//        sellerPriceTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView4 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: sellerStateTextField.frame.height))
        sellerPriceTextField.leftView = paddingView4
        sellerPriceTextField.leftViewMode = UITextField.ViewMode.always
        
        // 5th view
        
        //shadow
        sellerNumberTextField.layer.shadowColor = UIColor.gray.cgColor
        sellerNumberTextField.layer.shadowOpacity = 0.5
        sellerNumberTextField.layer.shadowOffset = CGSize.zero
        sellerNumberTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView5 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: sellerStateTextField.frame.height))
        sellerNumberTextField.leftView = paddingView5
        sellerNumberTextField.leftViewMode = UITextField.ViewMode.always
        
        //sth view
        submitButton.layer.cornerRadius = 20
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        
        //sth view
//        uploadFile.layer.cornerRadius = 20
//        uploadFile.layer.borderWidth = 1
//        uploadFile.layer.borderColor = UIColor.black.cgColor
//
        
        //To apply padding
//        let paddingView6 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: artistServicesDropDownList.frame.height))
        //selectServiceButton.layer.left(paddingView6)
     //selectServiceButton.layer.leftViewMode = UITextField.ViewMode.always
        
        //shadow
        selectServiceButton.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)

        selectServiceButton.layer.shadowColor = UIColor.white.cgColor
        selectServiceButton.layer.shadowOpacity = 0.5
        selectServiceButton.layer.shadowOffset = CGSize.zero
        selectServiceButton.layer.shadowRadius = 7
        
        sellerCityTextField.layer.shadowColor = UIColor.gray.cgColor
        sellerCityTextField.layer.shadowOpacity = 0.5
        sellerCityTextField.layer.shadowOffset = CGSize.zero
        sellerCityTextField.layer.shadowRadius = 7
        //To apply padding
        let paddingViewC : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: sellerCityTextField.frame.height))
        sellerCityTextField.leftView = paddingViewC
        sellerCityTextField.leftViewMode = UITextField.ViewMode.always
        
        
        //designing collection view
        collectionView.layer.shadowColor = UIColor.gray.cgColor
        collectionView.layer.shadowOpacity = 0.5
        collectionView.layer.shadowOffset = CGSize.zero
        collectionView.layer.borderWidth = 0.3
        collectionView.layer.cornerRadius = 10
        
        priceInnerStack.layer.borderColor = UIColor.white.cgColor
       // priceInnerStack.layer.shadowOpacity = 1
       //priceInnerStack.layer.shadowOffset = CGSize.zero
        priceInnerStack.layer.borderWidth = 2
        priceInnerStack.layer.cornerRadius = 20

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
        buyerStateTextField.layer.shadowColor = UIColor.gray.cgColor
        buyerStateTextField.layer.shadowOpacity = 0.5
        buyerStateTextField.layer.shadowOffset = CGSize.zero
        buyerStateTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView2 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: buyerStateTextField.frame.height))
        buyerStateTextField.leftView = paddingView2
        buyerStateTextField.leftViewMode = UITextField.ViewMode.always
        
        
        // 3rd view
        //shadow
        buyerEmailTextField.layer.shadowColor = UIColor.gray.cgColor
        buyerEmailTextField.layer.shadowOpacity = 0.5
        buyerEmailTextField.layer.shadowOffset = CGSize.zero
        buyerEmailTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView3 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: buyerStateTextField.frame.height))
        buyerEmailTextField.leftView = paddingView3
        buyerEmailTextField.leftViewMode = UITextField.ViewMode.always
        
        //4rth view
        
        //shadow
        buyerPriceTextField.layer.shadowColor = UIColor.gray.cgColor
        buyerPriceTextField.layer.shadowOpacity = 0.5
        buyerPriceTextField.layer.shadowOffset = CGSize.zero
        buyerPriceTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView4 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: buyerStateTextField.frame.height))
        buyerPriceTextField.leftView = paddingView4
        buyerPriceTextField.leftViewMode = UITextField.ViewMode.always
        
        // 5th view
        
        //shadow
        buyerNumberTextField.layer.shadowColor = UIColor.gray.cgColor
        buyerNumberTextField.layer.shadowOpacity = 0.5
        buyerNumberTextField.layer.shadowOffset = CGSize.zero
        buyerNumberTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingView5 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: buyerStateTextField.frame.height))
        buyerNumberTextField.leftView = paddingView5
        buyerNumberTextField.leftViewMode = UITextField.ViewMode.always
        
        //sth view
        submitButton.layer.cornerRadius = 20
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        
        // 3rd view
        //shadow
        buyerCityTextField.layer.shadowColor = UIColor.gray.cgColor
        buyerCityTextField.layer.shadowOpacity = 0.5
        buyerCityTextField.layer.shadowOffset = CGSize.zero
        buyerCityTextField.layer.shadowRadius = 7
        
        //To apply padding
        let paddingViewC : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: buyerCityTextField.frame.height))
        buyerCityTextField.leftView = paddingViewC
        buyerCityTextField.leftViewMode = UITextField.ViewMode.always
        
        
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
