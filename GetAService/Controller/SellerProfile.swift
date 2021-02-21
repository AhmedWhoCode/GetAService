//
//  ArtistProfile.swift
//  GetAService
//
//  Created by Geek on 26/01/2021.
//

import UIKit
import iOSDropDown
import YPImagePicker
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Firebase
class SellerProfile: UIViewController {

    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var artistAddressTextField: UITextField!
    @IBOutlet weak var artistEmailTextField: UITextField!
    @IBOutlet weak var artistPriceTextField: UITextField!
    @IBOutlet weak var artistNumberTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var genderChooser: UISegmentedControl!
    @IBOutlet weak var artistServicesDropDown: DropDown!
    
    //storing profile image selected by the user
    var profileImage = Data()
    
    var fireStorage = Storage.storage()
    
    
    let sellerProfileBrain = SellerProfileBrain()
    var selectedService:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        sellerProfileBrain.dataUplodedDelegant = self
        designingView()
        
        //will be pressed when the drop down option selects
        artistServicesDropDown.didSelect { (text, index, id) in
            self.selectedService = text
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func imagePressed(_ sender: Any) {
        let picker = YPImagePicker()
        present(picker, animated: true, completion: nil)
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
               // print("Image\(photo.fromCamera)")// Image source (camera or library)
               // print("immg\(self.profileImage)")
                self.artistImage.image=photo.image // Final image selected by the user
               // print(photo.originalImage) // original image selected by the user, unfiltered
                //print(photo.modifiedImage!) // Transformed image, can be nil
               // print(photo.exifMeta!) // Print exif meta data of original image.
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    func designingView() {
        navigationItem.hidesBackButton = true
        //providing dummy  data to dro down
        artistServicesDropDown.optionArray = ["Face treatments"
                                              ,"Hair removel"
                                              ,"Hair salon"
                                              ,"Makeup"
                                              ,"Med spa"
                                              ,"Nails"
                                              ,"Tanning"
                                              ,"Tattoo"]

        ///MARK: - designing views
        artistImage.layer.masksToBounds = true
        artistImage.layer.borderColor = UIColor.black.cgColor
       artistImage.layer.cornerRadius = artistImage.frame.size.height/2
        artistImage.contentMode = .scaleAspectFill
        
        
        
        //shadow
        artistNameTextField.layer.shadowColor = UIColor.gray.cgColor
        artistNameTextField.layer.shadowOpacity = 0.5
        artistNameTextField.layer.shadowOffset = CGSize.zero
        artistNameTextField.layer.shadowRadius = 7
  
        //To apply padding
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: artistNameTextField.frame.height))
        artistNameTextField.leftView = paddingView
        artistNameTextField.leftViewMode = UITextField.ViewMode.always
        
        //  2nd view
        //shadow
        artistAddressTextField.layer.shadowColor = UIColor.gray.cgColor
        artistAddressTextField.layer.shadowOpacity = 0.5
        artistAddressTextField.layer.shadowOffset = CGSize.zero
        artistAddressTextField.layer.shadowRadius = 7

        //To apply padding
       let paddingView2 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: artistAddressTextField.frame.height))
        artistAddressTextField.leftView = paddingView2
        artistAddressTextField.leftViewMode = UITextField.ViewMode.always


        // 3rd view
        //shadow
        artistEmailTextField.layer.shadowColor = UIColor.gray.cgColor
        artistEmailTextField.layer.shadowOpacity = 0.5
        artistEmailTextField.layer.shadowOffset = CGSize.zero
        artistEmailTextField.layer.shadowRadius = 7

        //To apply padding
        let paddingView3 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: artistAddressTextField.frame.height))
        artistEmailTextField.leftView = paddingView3
        artistEmailTextField.leftViewMode = UITextField.ViewMode.always

        //4rth view

        //shadow
        artistPriceTextField.layer.shadowColor = UIColor.gray.cgColor
        artistPriceTextField.layer.shadowOpacity = 0.5
        artistPriceTextField.layer.shadowOffset = CGSize.zero
        artistPriceTextField.layer.shadowRadius = 7

        //To apply padding
        let paddingView4 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: artistAddressTextField.frame.height))
        artistPriceTextField.leftView = paddingView4
        artistPriceTextField.leftViewMode = UITextField.ViewMode.always

       // 5th view

        //shadow
        artistNumberTextField.layer.shadowColor = UIColor.gray.cgColor
        artistNumberTextField.layer.shadowOpacity = 0.5
        artistNumberTextField.layer.shadowOffset = CGSize.zero
        artistNumberTextField.layer.shadowRadius = 7

        //To apply padding
        let paddingView5 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: artistAddressTextField.frame.height))
        artistNumberTextField.leftView = paddingView5
        artistNumberTextField.leftViewMode = UITextField.ViewMode.always
        
        //sth view
        submitButton.layer.cornerRadius = 20
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        
        
        //To apply padding
        let paddingView6 : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: artistServicesDropDown.frame.height))
        artistServicesDropDown.leftView = paddingView6
        artistServicesDropDown.leftViewMode = UITextField.ViewMode.always
        
        //shadow
        artistServicesDropDown.layer.shadowColor = UIColor.gray.cgColor
        artistServicesDropDown.layer.shadowOpacity = 0.5
        artistServicesDropDown.layer.shadowOffset = CGSize.zero
        artistServicesDropDown.layer.shadowRadius = 7
  
    }
    
     //MARK:Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.seguesNames.profileToSubservices
        {
            if let nextViewController = segue.destination as? SubServicesTableViewController
            
            {
                nextViewController.mainService = selectedService
            }
        }
    }

    @IBAction func submitPressed(_ sender: UIButton) {
        //converting image to data , compatible for uploading in storage
        profileImage = (artistImage.image?.jpegData(compressionQuality: 0.8)!)!
        
        //uncomment this code to upload image to database
       // let filePath = sellerProfileBrain.uploadingProfileImage(with: profileImage)!
        let filePath = "uncomment the code"
        let sellerData = SellerProfileModel(uid: Auth.auth().currentUser!.uid,
                                            imageRef: filePath,
                                            name: artistNameTextField.text!,
                                            email: artistEmailTextField.text!,
                                            address: artistAddressTextField.text!,
                                            phone: artistNumberTextField.text!,
                                            price: artistPriceTextField.text!,
                                            service: selectedService,
                                            dob: datePicker.date,
                                            gender: genderChooser.titleForSegment(at: genderChooser.selectedSegmentIndex)!)
    
         sellerProfileBrain.storingProfileDataToFireBase(with: sellerData)
        
    }
    
}

extension SellerProfile : DataUploaded
{
    func didsendData() {
        performSegue(withIdentifier: Constants.seguesNames.profileToSubservices, sender:self)
    }
    
}
