//
//  ArtistProfile.swift
//  GetAService
//
//  Created by Geek on 26/01/2021.
//

import UIKit

class ArtistProfile: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var artistAddressTextField: UITextField!
    @IBOutlet weak var artistEmailTextField: UITextField!
    @IBOutlet weak var artistPriceTextField: UITextField!
    @IBOutlet weak var artistNumberTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var genderChooser: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        designingView()
        // Do any additional setup after loading the view.
    }
    
    func designingView() {
        ///MARK: - designing views
        artistNameTextField.layer.cornerRadius = 7
        artistNameTextField.layer.borderWidth = 1
        artistNameTextField.layer.borderColor = UIColor.black.cgColor
        
        //shadow
        artistNameTextField.layer.shadowColor = UIColor.gray.cgColor
        artistNameTextField.layer.shadowOpacity = 1
        artistNameTextField.layer.shadowOffset = CGSize.zero
        artistNameTextField.layer.shadowRadius = 7
  
        //To apply padding
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: artistNameTextField.frame.height))
        artistNameTextField.leftView = paddingView
        artistNameTextField.leftViewMode = UITextField.ViewMode.always
        
        
        artistAddressTextField.layer.cornerRadius = 15
        artistAddressTextField.layer.borderWidth = 1
        artistAddressTextField.layer.borderColor = UIColor.black.cgColor
        
        artistEmailTextField.layer.cornerRadius = 15
        artistEmailTextField.layer.borderWidth = 1
        artistEmailTextField.layer.borderColor = UIColor.black.cgColor
        
        artistPriceTextField.layer.cornerRadius = 15
        artistPriceTextField.layer.borderWidth = 1
        artistPriceTextField.layer.borderColor = UIColor.black.cgColor
        
        artistNumberTextField.layer.cornerRadius = 15
        artistNumberTextField.layer.borderWidth = 1
        artistNumberTextField.layer.borderColor = UIColor.black.cgColor
        
        submitButton.layer.cornerRadius = 20
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
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
