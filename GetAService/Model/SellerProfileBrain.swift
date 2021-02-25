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

// defining a protocol
protocol DataUploaded {
    func didsendData()
}
class SellerProfileBrain {

    
    var sellerProfileData=[String:Any]()
    var dataUplodedDelegant:DataUploaded?
    
    let db = Firestore.firestore()
    var fireStorage = Storage.storage()
    
    func retrivingProfileData(completion : @escaping (SellerProfileModel) -> ()) {
        
        db.collection("UserProfileData").document(Auth.auth().currentUser!.uid).addSnapshotListener
        { (snapShot, error) in
            
            if let snap = snapShot?.data()
            {
                
                
                let imageRef1 = snap["imageRef"]! as! String
                
                print("debuk1\(imageRef1)")
                let name1 = snap["name"]! as! String
                let email1 = snap["email"]! as! String
                let address1 = snap["address"]! as! String
                let phone1 = snap["phone"]! as! String
                let price1 = snap["price"]! as! String
                let service1 = snap["service"]! as! String
                let gender1 = snap["gender"]! as! String
                let dob = snap["dob"]! as! Timestamp
                let dob1 = dob.dateValue()
                let uid1 = snap["uid"]! as! String
                
                let sellerProfileModel = SellerProfileModel(uid:uid1, imageRef: imageRef1 , name: name1, email:email1, address: address1, phone: phone1, price: price1, service: service1, dob:dob1, gender: gender1)
                
                completion(sellerProfileModel)
            }
            
        }
        
    }
    
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
                    
                    self.dataUplodedDelegant?.didsendData()
                    print("Document successfully written!")
                    
                }
            }
        }
    }
    
    func uploadingProfileImage(with profileImage:Data){
        
        //filePath or unique name of an image , also used a name
        let filePath = Auth.auth().currentUser!.uid
        // meta data such as format of image
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        self.fireStorage.reference().child("Images/profile_images").child(filePath).putData(profileImage, metadata: metaData) { (meta, error) in
            if  error != nil
            {
                print("error uploadind a file\(error?.localizedDescription ?? "Error")")
            }
            else
            {
                // print("MetaValue:"\(meta.value))
                
                print("image uploaded")
                
            }
        }
        
        
    }
    
    
    
    
}

//var sellerProfileModel = SellerProfileModel(uid: snap["uid"],imageRef: snap["imageRef"],name:snap["name"],email:snap["email"],address: snap["address"],phone: snap["phone"],price:snap["price"],service: snap["service"],dob: snap["dob"],gender: snap["gender"])
//

//self.sellerProfileModel?.imageRef = snap["imageRef"]! as! String
//self.sellerProfileModel?.name = snap["name"]! as! String
//self.sellerProfileModel?.email = snap["email"]! as! String
//self.sellerProfileModel?.address = snap["address"]! as! String
//self.sellerProfileModel?.phone = snap["phone"]! as! String
//self.sellerProfileModel?.price = snap["price"]! as! String
//self.sellerProfileModel?.service = snap["service"]! as! String
//self.sellerProfileModel?.gender = snap["gender"]! as! String
//self.sellerProfileModel?.dob = snap["dob"]! as! Date
//self.sellerProfileModel?.uid = snap["uid"]! as! String
