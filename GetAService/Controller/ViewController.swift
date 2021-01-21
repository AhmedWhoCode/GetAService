//
//  ViewController.swift
//  GetAService
//
//  Created by Geek on 19/01/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var signInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        modifyingViews()
        

    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func modifyingViews()  {
        
        
        ///MARK: - disabling bottom toolbar
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true

        ///MARK: - making views round
        emailView.layer.cornerRadius = 25
        emailView.layer.borderWidth = 1
        emailView.layer.borderColor = UIColor.black.cgColor
        
        passwordView.layer.cornerRadius = 25
        passwordView.layer.borderWidth = 1
        passwordView.layer.borderColor = UIColor.black.cgColor
        
        signInButton.layer.cornerRadius = 25
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = UIColor.black.cgColor
        
        ///MARK: - adding shadow
        emailView.layer.shadowColor = UIColor.gray.cgColor
        emailView.layer.shadowOpacity = 1
        emailView.layer.shadowOffset = CGSize.zero
        emailView.layer.shadowRadius = 6
        
        passwordView.layer.shadowColor = UIColor.gray.cgColor
        passwordView.layer.shadowOpacity = 1
        passwordView.layer.shadowOffset = CGSize.zero
        passwordView.layer.shadowRadius = 6
        
        signInButton.layer.shadowColor = UIColor.gray.cgColor
        signInButton.layer.shadowOpacity = 1
        signInButton.layer.shadowOffset = CGSize.zero
        signInButton.layer.shadowRadius = 6
    }
    
    
}

