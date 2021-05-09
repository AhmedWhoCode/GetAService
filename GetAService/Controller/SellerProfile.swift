//
//  ArtistProfile.swift
//  GetAService
//
//  Created by Geek on 26/01/2021.
//

import UIKit
import DropDown
import YPImagePicker
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Firebase
import UniformTypeIdentifiers

class SellerProfile: UIViewController {
    
    @IBOutlet weak var selectServiceButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sellerCityTextField: UITextField!
    @IBOutlet weak var sellerDescriptionTextVIew: UITextView!
    @IBOutlet weak var uploadFile: UIButton!
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var sellerStateTextField: UITextField!
    @IBOutlet weak var sellerEmailTextField: UITextField!
    @IBOutlet weak var sellerPriceTextField: UITextField!
    @IBOutlet weak var sellerNumberTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var genderChooser: UISegmentedControl!
    
    @IBOutlet weak var documentNameTextField: UITextField!
    
    @IBOutlet weak var documentView: UIView!
    
    @IBOutlet weak var priceInnerStack: UIStackView!
    
    var selectedImage : UIImage?
    
    //storing profile image selected by the user as data
    var profileImageData = Data()
    
    var fireStorage = Storage.storage()
    
    let sellerProfileBrain = SellerProfileBrain()
    //stores selected main service selected  by the user
    var selectedService:String!
    var sellerSelectedDocument : String!
    var selectedDocumentName : String!
    // to check if the source vs is artist profile so that we can retrieve the data, its value comes from segue
    var isSourceVcArtistProfile : Bool = false
    
    var isDestinationSubService : Bool?
    
    let artistServicesDropDownList = DropDown()
    
    
    var selectedPortfolioImages = [UIImage]()
    var selectedPortfolioImagesData : Data?
    var selectedPortfolioImagesInString = [String]()
    var isPortfolioImageSourceFirestore = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedImageToEnlarge :  String?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        datePicker.backgroundColor = UIColor.init(named: "paragraphTextColor")
        datePicker.tintColor = .black
        artistServicesDropDownList.anchorView = selectServiceButton
        //attaching touch sensor with a view, whenever you press a view keyboard will disappear
        initializeHideKeyboard()
        
        sellerProfileBrain.dataUplodedDelegant = self
        
        //checking the source VC
        if isSourceVcArtistProfile
        {
            retriveDataForFields()
        }
        
        
        designingView()
        
        
        //artistServicesDropDown.selectionAction
        artistServicesDropDownList.selectionAction = { [unowned self] (index: Int, item: String) in
            artistServicesDropDownList.hide()
            self.selectServiceButton.setTitle(item, for: .normal)
            //print("Selected item: \(item) at index: \(index)")
            self.selectedService = item
            
        }
        
    }
    
    @IBAction func addWorkPressed(_ sender: UIButton) {
        isPortfolioImageSourceFirestore = false
        selectImageWithYPImagePicker { (image) in
            guard let image = image else
            {
                return
            }
            self.selectedPortfolioImages.append(image)
            self.selectedPortfolioImagesData = image.jpegData(compressionQuality:0.1)!
            self.collectionView.reloadData()
            self.storingSelectedPortfolioImages()
            ERProgressHud.sharedInstance.show(withTitle: "Image uploading,wait")
            //selectedPortfolioImages.removeAll()
        }

        
        
    }
    
    
    ///MARK: - storing portfolio images
    
    func storingSelectedPortfolioImages() {
        
        if let data = selectedPortfolioImagesData
        {
            sellerProfileBrain.uploadPortFolioToStorage(with: data) {
                ERProgressHud.sharedInstance.hide()
                return
            }
            
        }
        
        
    }
    
    @IBAction func uploadFilePressed(_ sender: UIButton) {
        let supportedTypes: [UTType] = [UTType.image , UTType.pdf , UTType.zip , UTType.text ,UTType.plainText]
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        //Call Delegate
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
    }
    
    
    @IBAction func selectServicePressed(_ sender: UIButton) {
        artistServicesDropDownList.show()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
        navigationItem.hidesBackButton = false
        submitButton.isEnabled = true
        
    }
    
    
    @IBAction func imagePressed(_ sender: Any) {
        
        selectImageWithYPImagePicker { (image) in
            
            guard let image = image else
            {
                return
            }
            
            self.artistImage.image = image
            self.selectedImage = image
        }

        
    }
    
    ///MARK: - Call whenever you want to select an image
    func selectImageWithYPImagePicker(completion:@escaping (UIImage?) -> ()) {
        var config = YPImagePickerConfiguration()
        var image = UIImage(named: "servicesimageplaceholder")!
        config.library.defaultMultipleSelection  = false
        
        let picker = YPImagePicker(configuration: config)
        
        present(picker, animated: true, completion: nil)
        
        picker.didFinishPicking { [unowned picker] items, cancel in
            
            if let photo = items.singlePhoto {
                
                image = photo.image
                completion(image)
                picker.dismiss(animated: true, completion: nil)
                
            }
            
            if cancel
            {
                picker.dismiss(animated: true, completion: nil)
                
            }
            
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
        else if segue.identifier == Constants.seguesNames.toEnlargedImage
        {
            if let destinationSegue = segue.destination as? EnlargedImageViewController
            {
                if let image = selectedImageToEnlarge
                {
                destinationSegue.image = image
                }
                else
                {
                    return
                }
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
        ERProgressHud.sharedInstance.show(withTitle: "Uploading data....")
        
    }
    
    
    ///MARK: - storing data to database
    func storeDataToFirebase() {
        
        guard let documentToUpload = sellerSelectedDocument else
        {
            showToast1(controller: self, message: "kindly upload driving license or ID card", seconds: 2, color: .red)
            submitButton.isEnabled = true
            return
        }
        ERProgressHud.sharedInstance.show(withTitle: "Uploading data....")
        
        //converting image to data , compatible for uploading in storage
        profileImageData = (artistImage.image?.jpegData(compressionQuality: 0.4)!)!
        // uncomment this code to upload image to database
        sellerProfileBrain.uploadingProfileImage(with: profileImageData) { (url) in
            //let filePath = Auth.auth().currentUser?.uid
            let sellerData = SellerProfileModel(uid: Auth.auth().currentUser!.uid,
                                                imageRef: url.absoluteString,
                                                name: self.artistNameTextField.text!,
                                                email: self.sellerEmailTextField.text!,
                                                state: self.sellerStateTextField.text!,
                                                phone: self.sellerNumberTextField.text!,
                                                price: self.sellerPriceTextField.text!,
                                                service: self.selectedService,
                                                city: self.sellerCityTextField.text!,
                                                description: self.sellerDescriptionTextVIew.text! ,
                                                dob: self.datePicker.date,
                                                gender: self.genderChooser.titleForSegment(at: self.genderChooser.selectedSegmentIndex)!,
                                                document: documentToUpload,
                                                documentName: self.selectedDocumentName
            )
            
            
            self.sellerProfileBrain.storingProfileDataToFireBase(with: sellerData)
        }
        
    }
    
    
    ///MARK: - Retriving data to be shown in fields
    func retriveDataForFields(){
        sellerProfileBrain.retrivingProfileData { (data,subservices) in
            self.artistImage.loadCacheImage(with: data.imageRef)
            
            self.artistNameTextField.text = data.name
            self.sellerEmailTextField.text = data.email
            self.sellerStateTextField.text = data.state
            self.sellerNumberTextField.text = data.phone
            self.sellerPriceTextField.text = data.price
            self.selectedService = data.service
            self.sellerCityTextField.text = data.city
            self.documentNameTextField.text = data.documentName
            let index : Int =  self.artistServicesDropDownList.dataSource.firstIndex(of: data.service)!
            self.artistServicesDropDownList.selectRow(index)
            self.selectServiceButton.setTitle(data.service, for: .normal)
            self.sellerDescriptionTextVIew.text = data.description
            self.sellerSelectedDocument = data.document
            self.selectedDocumentName = data.documentName
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
        sellerProfileBrain.retrivingPortfolioImages(using: Auth.auth().currentUser!.uid) { (portfolioImages) in
          
            self.selectedPortfolioImagesInString = portfolioImages
            self.isPortfolioImageSourceFirestore = true
            self.collectionView.reloadData()
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


///MARK: - Getting response from the Picker
extension SellerProfile : UIDocumentPickerDelegate
{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        selectedDocumentName =   urls[0].lastPathComponent
        documentNameTextField.text = selectedDocumentName
        
        ERProgressHud.sharedInstance.show(withTitle: "uploading data,it may take time")
        sellerProfileBrain.uploadingDocument(with: urls[0]) { (url) in
            ERProgressHud.sharedInstance.hide()
            self.sellerSelectedDocument = url.absoluteString
        }
        
        
        
    }
    
}


///MARK: -   Getting response if the profile data is uploaded
extension SellerProfile : DataUploadedSeller
{
    func didsendData() {
        ERProgressHud.sharedInstance.hide()
        
        if isDestinationSubService!
        {
            if selectServiceButton.currentTitle != ""
            {
                performSegue(withIdentifier: Constants.seguesNames.profileToSubservices, sender:self)
            }
            else
            {
                showToast1(controller: self, message: "Kindly select service", seconds: 1, color: .red)
            }
        }
        else
        {
            performSegue(withIdentifier: Constants.seguesNames.sellerProfileToDashboard, sender: self)
        }
    }
    
}

///MARK: - collectionView for portfolio
extension SellerProfile : UICollectionViewDelegate , UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("im pressed")
        selectedImageToEnlarge = selectedPortfolioImagesInString[indexPath.row]

        performSegue(withIdentifier: Constants.seguesNames.toEnlargedImage, sender: self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isPortfolioImageSourceFirestore
        {
            return selectedPortfolioImagesInString.count
        }
        else
        {
        return selectedPortfolioImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "portfolioCollectionCell", for: indexPath) as? PortfolioCollectionViewCell
        
        //checking if the data is coming from database or from image selector
        if isPortfolioImageSourceFirestore
        {
            
            cell?.portfolioImage.loadCacheImage(with: selectedPortfolioImagesInString[indexPath.row],completion: {
                self.selectedPortfolioImages.append(cell!.portfolioImage.image!)
            })
            
        }
        else
        {
        cell?.portfolioImage.image = selectedPortfolioImages[indexPath.row]
        }
        return cell!
    }
    
    
}

