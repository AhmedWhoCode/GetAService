//
//  SellerProfile_ModelClass.swift
//  GetAService
//
//  Created by Geek on 20/02/2021.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Firebase

//uid:String,imageRef:String,name:String, email:String, address:String, phone:String, price:String, service:String,dob:String,gender:String
class SellerProfileBrain {
    
    let db = Firestore.firestore()
    var fireStorage = Storage.storage()
    
    var sellerProfileData=[String:Any]()
    
    func storingProfileDataToFireBase(with sellerProfileModel:SellerProfileModel)
    {
        
        
        sellerProfileData["uid"] = sellerProfileModel.uid
        sellerProfileData["imageRef"] = sellerProfileModel.imageRef
        sellerProfileData["name"] = sellerProfileModel.name
        sellerProfileData["email"] = sellerProfileModel.email
        sellerProfileData["address"] = sellerProfileModel.address
        sellerProfileData["phone"] = sellerProfileModel.phone
        sellerProfileData["price"] = sellerProfileModel.price
        sellerProfileData["service"] = sellerProfileModel.service
        sellerProfileData["dob"] = sellerProfileModel.dob
        sellerProfileData["gender"] = sellerProfileModel.gender
        
        
        if let userid = Auth.auth().currentUser?.uid {
            
            db.collection("UserProfileData").document(userid).setData(sellerProfileData) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Document successfully written!")
                    
                }
            }
        }
    }
    
    func uploadingProfileImage(with profileImage:Data) -> String?{
        
        //filePath or unique name of an image , also used a name
        let filePath = "\(Auth.auth().currentUser!.uid)\(profileImage)"
        // meta data such as format of image
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        self.fireStorage.reference().child("Images/profile_images").child(filePath).putData(profileImage, metadata: metaData) { (meta, error) in
            if  error != nil
            {
                print("error uploadind a file\(error)")
            }
            else
            {
                print("image uploaded")
                
            }
        }
        
        return filePath
        
    }
    
    
}
