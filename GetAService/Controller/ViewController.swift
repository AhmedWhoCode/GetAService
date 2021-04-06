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
import AuthenticationServices
import CryptoKit
class ViewController: UIViewController {
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var googleVIew: GIDSignInButton!
    @IBOutlet weak var facebookView: UIView!
     var currentNonce: String?

    let db = Firestore.firestore()
    
    @IBOutlet weak var facebookLogin: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        createAppleButtonView()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        //setting app delegant as the class which will be notified when the auth is completed
        GIDSignIn.sharedInstance().clientID = "905977003700-9g7q7lqs4q2163o6pjrhmtg4tmutoflo.apps.googleusercontent.com"
        // Do any additional setup after loading the view.
        modifyingViews()
    }
    
    func createAppleButtonView()
    {
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(appleButton)
        NSLayoutConstraint.activate([
            appleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 25),
            appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25),
            //appleButton.widthAnchor.constraint(equalToConstant: 90),
            appleButton.heightAnchor.constraint(equalToConstant: 45)
            
            
        ])
        appleButton.addTarget(self, action: #selector(handleLogInWithAppleID), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
        navigationItem.hidesBackButton = false
        //checking if the user exist or not
        if Auth.auth().currentUser != nil
        {
            checkingUserType()
        }
        
        
    }
    
    @objc func handleLogInWithAppleID() {
        let nonce = randomNonceString()
        currentNonce = nonce

        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        request.nonce = sha256(nonce)

        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
    }
    
    
}

extension ViewController : GIDSignInDelegate
{
    //called when user signed in
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            // ...
            print("error while sign in to google \(error)")
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
    
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
}

extension ViewController: ASAuthorizationControllerDelegate
{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
           if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
               guard let nonce = currentNonce else {
                   fatalError("Invalid state: A login callback was received, but no login request was sent.")
               }
               guard let appleIDToken = appleIDCredential.identityToken else {
                   print("Unable to fetch identity token")
                   return
               }
               guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                   print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                   return
               }
               let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                         idToken: idTokenString,
                                                         rawNonce: nonce)
            
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
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("error while signing in to apple :" , error.localizedDescription)
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding
{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
}
