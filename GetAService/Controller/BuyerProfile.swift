//
//  CustomerProfile.swift
//  GetAService
//
//  Created by Geek on 18/02/2021.
//

import UIKit
import iOSDropDown
import YPImagePicker
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Firebase
class BuyerProfile: UIViewController {
    @IBOutlet weak var buyerImage: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var buyerNameTextField: UITextField!
    @IBOutlet weak var buyerAddressTextField: UITextField!
    @IBOutlet weak var buyerEmailTextField: UITextField!
    @IBOutlet weak var buyerPriceTextField: UITextField!
    @IBOutlet weak var buyerNumberTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var genderChooser: UISegmentedControl!
    
    
    //storing profile image selected by the user as data
    var profileImageData = Data()
    
    var fireStorage = Storage.storage()
    
    let buyerProfileBrain = BuyerProfileBrain()
    //stores selected main service selected  by the user
    var selectedService:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        retriveData()

        designingView()
        // Do any additional setup after loading the view.
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
                                               address: self.buyerAddressTextField.text!,
                                               phone: self.buyerNumberTextField.text!,
                                               dob: self.datePicker.date,
                                               gender: self.genderChooser.titleForSegment(at: self.genderChooser.selectedSegmentIndex)!)
            
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
            self.buyerAddressTextField.text = data.address
            self.buyerNumberTextField.text = data.phone
            //self.buyerCountryTextField.text = data.country
//            self.artistServicesDropDown.selectedIndex = self.artistServicesDropDown.optionArray.firstIndex(of: self.selectedService)!
//            self.artistServicesDropDown.text = self.selectedService
//            self.sellerDescriptionTextVIew.text = data.description

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
    
    
    
    
    
    
    
    
    
    func designingView() {
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
