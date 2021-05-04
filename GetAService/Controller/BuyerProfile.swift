//
//  CustomerProfile.swift
//  GetAService
//
//  Created by Geek on 18/02/2021.
//

import UIKit
//import iOSDropDown
import YPImagePicker
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Firebase
class BuyerProfile: UIViewController {
    @IBOutlet weak var buyerImage: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var buyerNameTextField: UITextField!
    @IBOutlet weak var buyerStateTextField: UITextField!
    @IBOutlet weak var buyerEmailTextField: UITextField!
    @IBOutlet weak var buyerPriceTextField: UITextField!
    @IBOutlet weak var buyerNumberTextField: UITextField!
    
    @IBOutlet weak var buyerCityTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var genderChooser: UISegmentedControl!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //storing profile image selected by the user as data
    var profileImageData = Data()
    
    var fireStorage = Storage.storage()
    
    let buyerProfileBrain = BuyerProfileBrain()
    //stores selected main service selected  by the user
    var selectedService:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        //attaching touch sensor with a view, whenever you press a view keyboard will disappear
        initializeHideKeyboard()
        
        retriveData()
        
        designingView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
        navigationItem.hidesBackButton = false
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        //converting image to data , compatible for uploading in storage
        profileImageData = (buyerImage.image?.jpegData(compressionQuality: 0.4)!)!
        // uncomment this code to upload image to database
        buyerProfileBrain.uploadingProfileImage(with: profileImageData) { (url) in
            //let filePath = Auth.auth().currentUser?.uid
            let buyersData = BuyerProfileModel(uid: Auth.auth().currentUser!.uid,
                                               imageRef: url.absoluteString,
                                               name: self.buyerNameTextField.text!,
                                               email: self.buyerEmailTextField.text!,
                                               state: self.buyerStateTextField.text!,
                                               phone: self.buyerNumberTextField.text!,
                                               dob: self.datePicker.date,
                                               gender: self.genderChooser.titleForSegment(at: self.genderChooser.selectedSegmentIndex)!,
                                               city: self.buyerCityTextField.text!
            )
            
            self.buyerProfileBrain.storingProfileDataToFireBase(with: buyersData)
        }
        
        
        
    }
    
    @IBAction func imagePressed(_ sender: Any) {
        let picker = YPImagePicker()
        present(picker, animated: true, completion: nil)
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                self.buyerImage.image=photo.image // Final image selected by the user
                //print(photo.originalImage) // original image selected by the user, unfiltered
                //print(photo.modifiedImage!) // Transformed image, can be nil
                //print(photo.exifMeta!) // Print exif meta data of original image.
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
    
    
    func retriveData(){
        buyerProfileBrain.retrivingProfileData { (data) in
            self.buyerImage.loadCacheImage(with: data.imageRef)
            
            self.buyerNameTextField.text = data.name
            self.buyerEmailTextField.text = data.email
            self.buyerStateTextField.text = data.state
            self.buyerNumberTextField.text = data.phone
            self.buyerCityTextField.text = data.city
            self.datePicker.setDate(data.dob, animated: true)
            
            if data.gender == "Male"
            {
                self.genderChooser.selectedSegmentIndex = 0
            }
            else
            {
                self.genderChooser.selectedSegmentIndex = 2
                
            }
            
            
            
        }
        
    }
    
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
