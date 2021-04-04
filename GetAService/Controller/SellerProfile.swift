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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sellerCountryTextField: UITextField!
    @IBOutlet weak var sellerDescriptionTextVIew: UITextView!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
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
    
    var selectedImage : UIImage?
    
    //storing profile image selected by the user as data
    var profileImageData = Data()
    
    var fireStorage = Storage.storage()
    
    let sellerProfileBrain = SellerProfileBrain()
    //stores selected main service selected  by the user
    var selectedService:String!
    
    // to check if the source vs is artist profile so that we can retrieve the data, its value comes from segue
    var isSourceVcArtistProfile : Bool = false
    
    
    var isDestinationSubService : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidesBottomBarWhenPushed = true
        submitButton.isEnabled = true
        
        //attaching touch sensor with a view, whenever you press a view keyboard will disappear
        initializeHideKeyboard()
        
        sellerProfileBrain.dataUplodedDelegant = self
        
        if isSourceVcArtistProfile
        {
            retriveData()
        }
        
        designingView()
        //will be pressed when the drop down option selects
        artistServicesDropDown.didSelect { (text, index, id) in
            self.selectedService = text
        }
        // Do any additional setup after loading the view.
    }
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.hidesBottomBarWhenPushed = true
//        
//    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
        navigationItem.hidesBackButton = false
        submitButton.isEnabled = true

    }
    
    
    @IBAction func imagePressed(_ sender: Any) {
        let picker = YPImagePicker()
        present(picker, animated: true, completion: nil)
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                
                self.artistImage.image=photo.image // Final image selected by the user
                self.selectedImage = photo.image
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
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
        submitButton.isEnabled = false
        isDestinationSubService = true
        
        storeDataToFirebase()
        
    }
    
    
    @IBAction func saveBarButton(_ sender: UIBarButtonItem) {
        hidesBottomBarWhenPushed=false
        isDestinationSubService = false
        sender.isEnabled = false
        storeDataToFirebase()
        
        
    }
    
    
    func storeDataToFirebase() {
        //converting image to data , compatible for uploading in storage
        profileImageData = (artistImage.image?.jpegData(compressionQuality: 0.4)!)!
        // uncomment this code to upload image to database
        sellerProfileBrain.uploadingProfileImage(with: profileImageData) { (url) in
            //let filePath = Auth.auth().currentUser?.uid
            let sellerData = SellerProfileModel(uid: Auth.auth().currentUser!.uid,
                                                imageRef: url.absoluteString,
                                                name: self.artistNameTextField.text!,
                                                email: self.artistEmailTextField.text!,
                                                address: self.artistAddressTextField.text!,
                                                phone: self.artistNumberTextField.text!,
                                                price: self.artistPriceTextField.text!,
                                                service: self.selectedService,
                                                country: self.sellerCountryTextField.text!,
                                                description: self.sellerDescriptionTextVIew.text! ,
                                                dob: self.datePicker.date,
                                                gender: self.genderChooser.titleForSegment(at: self.genderChooser.selectedSegmentIndex)!)
            
            self.sellerProfileBrain.storingProfileDataToFireBase(with: sellerData)
        }    }
    
    
    func retriveData(){
        sellerProfileBrain.retrivingProfileData { (data,subservices) in
            self.artistImage.loadCacheImage(with: data.imageRef)
            
            self.artistNameTextField.text = data.name
            self.artistEmailTextField.text = data.email
            self.artistAddressTextField.text = data.address
            self.artistNumberTextField.text = data.phone
            self.artistPriceTextField.text = data.price
            self.selectedService = data.service
            self.sellerCountryTextField.text = data.country
            self.artistServicesDropDown.selectedIndex = self.artistServicesDropDown.optionArray.firstIndex(of: self.selectedService)!
            self.artistServicesDropDown.text = self.selectedService
            self.sellerDescriptionTextVIew.text = data.description
            
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
    
}

extension SellerProfile : DataUploadedSeller
{
    func didsendData() {
        if isDestinationSubService!
        {
            performSegue(withIdentifier: Constants.seguesNames.profileToSubservices, sender:self)
        }
        else
        {
            performSegue(withIdentifier: Constants.seguesNames.sellerProfileToDashboard, sender: self)
        }
    }
    
}



//            self.fireStorage.reference().child("Images/profile_images").child(Auth.auth().currentUser!.uid).getData(maxSize: 1 * 1024 * 1024) { (data1, error) in
//                if let data1 = data1
//                {
//                    print(data1)
//                    self.artistImage.image = UIImage(data: data1)
//
//                }
//
//            }
