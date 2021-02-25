//
//  ViewController.swift
//  GetAService
//
//  Created by Geek on 19/01/2021.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseFirestore
//import FirebaseCore
class ViewController: UIViewController {
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var googleVIew: GIDSignInButton!
    
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var facebookLogin: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        
        //setting app delegant as the class which will be notified when the auth is completed
        GIDSignIn.sharedInstance().clientID = "905977003700-9g7q7lqs4q2163o6pjrhmtg4tmutoflo.apps.googleusercontent.com"
        
        // Do any additional setup after loading the view.
        modifyingViews()
//        enableOffline()
    }
//    private func enableOffline() {
//            // [START enable_offline]
//            let settings = FirestoreSettings()
//            settings.isPersistenceEnabled = true
//
//            // Any additional options
//            // ...
//            // Enable offline data persistence
//            let db = Firestore.firestore()
//            db.settings = settings
//            // [END enable_offline]
//        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //checking if the user exist or not
        if Auth.auth().currentUser != nil
        {
            checkingUserType()
//            self.performSegue(withIdentifier: Constants.seguesNames.loginToServices, sender:self)
        }
        
        
    }
    
    func modifyingViews()  {
        ///MARK: - disabling bottom toolbar
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
}

extension ViewController : GIDSignInDelegate
{
    //called when user signed in
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            // ...
            print("error while sign in \(error)")
        }
        else
        {
            print("Signed in with google")
            if let authentication = user.authentication
            {
                let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
                Auth.auth().signIn(with: credential) { (authResult, error) in
                    if let error = error
                    {
                        print(error)
                    }
                    else
                    {
                        print("Signed in firebase")
                        self.checkingUserType()
                    }
                }
                
            }
            
        }
        
    }
    
    func addingInfoInFirestore(userType: String? = "nil") {
        
        let isUserOrNil = ["Email":Auth.auth().currentUser?.email,"UserType": userType]
        
        if let userid = Auth.auth().currentUser?.uid {
            
            db.collection("isUserOrNil").document(userid).setData(isUserOrNil) { err in
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
                        self.performSegue(withIdentifier: Constants.seguesNames.loginToServices, sender: self)
                    }
                    else if snap["UserType"] as! String == "Seller"
                    {
                        //sender seller to its destination

                       print("seller")
                        self.performSegue(withIdentifier: Constants.seguesNames.loginToSellerProfile, sender: self)
                    }
                    else{
                        //send to buyerOrSeller screen
                        print("Nill")
                        self.performSegue(withIdentifier: Constants.seguesNames.loginToUserType, sender: self)

                    }
                }
                else{
                    print("user doesnot exist ")
                    self.addingInfoInFirestore()
                }
                
                
            }
        }
      
    }
    
    
}

