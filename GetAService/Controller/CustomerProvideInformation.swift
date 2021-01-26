//
//  CustomerProvideInformation.swift
//  GetAService
//
//  Created by Geek on 26/01/2021.
//

import UIKit

class CustomerProvideInformation: UIViewController {
    @IBOutlet weak var bookNowButton: UIButton!
    @IBOutlet weak var recepientNameTextField: UITextField!
    @IBOutlet weak var dropOffAddressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        designingView()

        // Do any additional setup after loading the view.
    }
    func designingView() {
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
        dropOffAddressTextField.layer.shadowColor = UIColor.gray.cgColor
        dropOffAddressTextField.layer.shadowOpacity = 0.5
        dropOffAddressTextField.layer.shadowOffset = CGSize.zero
        dropOffAddressTextField.layer.shadowRadius = 7

        //To apply padding
       let paddingView2 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: dropOffAddressTextField.frame.height))
        dropOffAddressTextField.leftView = paddingView2
        dropOffAddressTextField.leftViewMode = UITextField.ViewMode.always


        // 3rd view
        //shadow
        emailTextField.layer.shadowColor = UIColor.gray.cgColor
        emailTextField.layer.shadowOpacity = 0.5
        emailTextField.layer.shadowOffset = CGSize.zero
        emailTextField.layer.shadowRadius = 7

        //To apply padding
        let paddingView3 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTextField.frame.height))
        emailTextField.leftView = paddingView3
        emailTextField.leftViewMode = UITextField.ViewMode.always

        //4rth view

        //shadow
        phoneNumberTextField.layer.shadowColor = UIColor.gray.cgColor
        phoneNumberTextField.layer.shadowOpacity = 0.5
        phoneNumberTextField.layer.shadowOffset = CGSize.zero
        phoneNumberTextField.layer.shadowRadius = 7

        //To apply padding
        let paddingView4 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: phoneNumberTextField.frame.height))
        phoneNumberTextField.leftView = paddingView4
        phoneNumberTextField.leftViewMode = UITextField.ViewMode.always

        
        //sth view
        bookNowButton.layer.cornerRadius = 20
        bookNowButton.layer.borderWidth = 1
        bookNowButton.layer.borderColor = UIColor.black.cgColor
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
