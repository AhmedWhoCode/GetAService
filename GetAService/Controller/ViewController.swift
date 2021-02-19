//
//  ViewController.swift
//  GetAService
//
//  Created by Geek on 19/01/2021.
//

import UIKit
import Firebase
import GoogleSignIn
class ViewController: UIViewController {

    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var googleVIew: GIDSignInButton!

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
        

    }
    override func viewWillAppear(_ animated: Bool) {
        //checking if the user exist or not
       if Auth.auth().currentUser != nil
        {
        self.performSegue(withIdentifier: Constants.seguesNames.loginToServices, sender:self)

        }
    }
    
    func modifyingViews()  {
        
        
        ///MARK: - disabling bottom toolbar
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.isNavigationBarHidden = false

        ///MARK: - making views round
//        phoneView.layer.cornerRadius = 25
//        phoneView.layer.borderWidth = 1
//        phoneView.layer.borderColor = UIColor.black.cgColor
        
//        googleView.layer.cornerRadius = 25
//        googleView.layer.borderWidth = 1
//        googleView.layer.borderColor = UIColor.black.cgColor
//
//        facebookView.layer.cornerRadius = 25
//        facebookView.layer.borderWidth = 1
//        facebookView.layer.borderColor = UIColor.black.cgColor
//
//        ///MARK: - adding shadow
//        phoneView.layer.shadowColor = UIColor.gray.cgColor
//        phoneView.layer.shadowOpacity = 1
//        phoneView.layer.shadowOffset = CGSize.zero
//        phoneView.layer.shadowRadius = 6
//
//        googleView.layer.shadowColor = UIColor.gray.cgColor
//        googleView.layer.shadowOpacity = 1
//        googleView.layer.shadowOffset = CGSize.zero
//        googleView.layer.shadowRadius = 6
//
//        facebookView.layer.shadowColor = UIColor.gray.cgColor
//        facebookView.layer.shadowOpacity = 1
//        facebookView.layer.shadowOffset = CGSize.zero
//        facebookView.layer.shadowRadius = 6
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
                        self.performSegue(withIdentifier: Constants.seguesNames.loginToUserType, sender:self)
                    }
                }
                
            }
            
        }
        
    }
}
