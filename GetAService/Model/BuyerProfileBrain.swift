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
protocol DataUploadedBuyer {
    func didsendData()
}


class BuyerProfileBrain {
    
    
    var buyerProfileData=[String:Any]()
    var dataUplodedDelegant:DataUploadedBuyer?
    
    let db = Firestore.firestore()
    var fireStorage = Storage.storage()
    
    func retrivingProfileData(completion : @escaping (BuyerProfileModel) -> ()) {
        
        db.collection("UserProfileData").document("Buyer").collection("AllBuyers").document(Auth.auth().currentUser!.uid).addSnapshotListener
        { (snapShot, error) in
            
            if let snap = snapShot?.data()
            {
                
                
                let imageRef1 = snap["imageRef"]! as! String
                
                print("debuk1\(imageRef1)")
                let name1 = snap["name"]! as! String
                let email1 = snap["email"]! as! String
                let address1 = snap["address"]! as! String
                let phone1 = snap["phone"]! as! String
                let gender1 = snap["gender"]! as! String
                let dob = snap["dob"]! as! Timestamp
                let dob1 = dob.dateValue()
                let uid1 = snap["uid"]! as! String
                
                let buyerProfileModel = BuyerProfileModel(uid:uid1, imageRef: imageRef1 , name: name1, email:email1, address: address1, phone: phone1, dob:dob1, gender: gender1)
                print("hey yyy")
                completion(buyerProfileModel)
            }
            else
            {
                print("nononono")
            }
            
        }
        
    }
    
    func storingProfileDataToFireBase(with buyerProfileModel:BuyerProfileModel)
    {
        
        
        buyerProfileData["uid"] = buyerProfileModel.uid
        buyerProfileData["imageRef"] = buyerProfileModel.imageRef
        buyerProfileData["name"] = buyerProfileModel.name
        buyerProfileData["email"] = buyerProfileModel.email
        buyerProfileData["address"] = buyerProfileModel.address
        buyerProfileData["phone"] = buyerProfileModel.phone
        buyerProfileData["dob"] = buyerProfileModel.dob
        buyerProfileData["gender"] = buyerProfileModel.gender
        
        
        if let userid = Auth.auth().currentUser?.uid {
            
            db.collection("UserProfileData").document("Buyer").collection("AllBuyers").document(userid).setData(buyerProfileData) { (error) in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    
                    self.dataUplodedDelegant?.didsendData()
                    print("Document successfully written!")
                    
                }
            }
            
        }
    }
    
    func uploadingProfileImage(with profileImage:Data,  completion :@escaping (URL)->() ){
        
        //filePath or unique name of an image , also used a name
        let filePath = Auth.auth().currentUser!.uid
        let storageRef = self.fireStorage.reference().child("Images/profile_images").child(filePath)
        // meta data such as format of image
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        
        
        storageRef.putData(profileImage, metadata: metaData) { (meta, error) in
            if  error != nil
            {
                print("error uploadind a file\(error?.localizedDescription ?? "Error")")
                
            }
            else
            {
                //getting url
                storageRef.downloadURL { (url,error) in
                    print(url?.absoluteURL ?? "nil")
                    completion(url!.absoluteURL)
                }
                print("image uploaded")
                
            }
        }
        
        
    }
    
    func retrivingProfileDataForChats(using userUid :String = Auth.auth().currentUser!.uid,completion : @escaping (ChatModel) -> ()) {
        
        
        db.collection("UserProfileData").document("Buyer").collection("AllBuyers").document(userUid).addSnapshotListener
        { (snapShot, error) in
            
            if let snap = snapShot?.data()
            {
                
                
                let imageRef1 = snap["imageRef"]! as! String
                let name1 = snap["name"]! as! String
                let country = "Not filled"
                
                let chatModel = ChatModel(image: imageRef1, name: name1, country: country)
                
                completion(chatModel)
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
//self.sellerProfileModel?.uid = snap["uid"]! as! Strin
