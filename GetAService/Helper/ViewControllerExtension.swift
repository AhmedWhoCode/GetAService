//
//  ViewControllerExtension.swift
//  GetAService
//
//  Created by Geek on 05/04/2021.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseFirestore
extension ViewController
{
    
    func modifyingViews()  {
        ///MARK: - disabling bottom toolbar
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.isNavigationBarHidden = false
        
        
//        facebookView.layer.shadowColor = UIColor.gray.cgColor
//        facebookView.layer.shadowOpacity = 0.5
//        facebookView.layer.shadowOffset = CGSize.zero
//        facebookView.layer.shadowRadius = 7
        
//        phoneView.layer.shadowColor = UIColor.gray.cgColor
//        phoneView.layer.shadowOpacity = 0.5
//        phoneView.layer.shadowOffset = CGSize.zero
//        phoneView.layer.shadowRadius = 7
        
        googleVIew.layer.shadowColor = UIColor.gray.cgColor
        googleVIew.layer.shadowOpacity = 0.5
        googleVIew.layer.shadowOffset = CGSize.zero
        googleVIew.layer.shadowRadius = 7
        
    }
    
    
    func addingInfoInFirestore(userType: String? = "nil") {
        
        let isUserOrNil = ["Email":Auth.auth().currentUser?.email,"UserType": userType]
        
        if let userid = Auth.auth().currentUser?.uid {
            
            db.collection("isUserOrNil").document(userid).setData(isUserOrNil as [String : Any]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    self.checkingUserType()
                }
            }
        }
        
    }
    
    
    func checkingUserType()
    {
        if let userid = Auth.auth().currentUser?.uid {
            
            db.collection("isUserOrNil").document(userid).getDocument { (snapshot, error) in
                
                if let snap = snapshot?.data(){
                    if snap["UserType"] as! String == "Buyer"
                    {
                        //sender buyer to its destination
                        print("buyer")
                        self.performSegue(withIdentifier: Constants.seguesNames.loginToServices, sender: nil)
                    }
                    else if snap["UserType"] as! String == "Seller"
                    {
                        //sender seller to its destination
                        
                        print("seller")
                        self.performSegue(withIdentifier: Constants.seguesNames.loginToSellerProfile, sender: nil)
                    }
                    else{
                        //send to buyerOrSeller screen
                        print("Nill")
                        self.performSegue(withIdentifier: Constants.seguesNames.loginToUserType, sender: nil)
                        
                    }
                }
                else
                {
                    print("user doesnot exist ")
                    self.addingInfoInFirestore()
                }
                
                
            }
        }
        
    }
    
}
