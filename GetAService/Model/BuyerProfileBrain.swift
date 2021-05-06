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
                
               // print("debuk1\(imageRef1)")
                guard  let name1 = snap["name"]  as? String else {return}
                guard let email1 = snap["email"] as? String else {return}
                guard let state = snap["state"] as? String else {return}
                guard let phone1 = snap["phone"] as? String else {return}
                guard let gender1 = snap["gender"] as? String else {return}
                guard let dob = snap["dob"] as? Timestamp else {return}
                 let dob1 = dob.dateValue()
                guard let uid1 = snap["uid"] as? String else {return}
                guard let city = snap["city"] as? String else {return}

                
                let buyerProfileModel = BuyerProfileModel(uid:uid1, imageRef: imageRef1 , name: name1, email:email1, state: state, phone: phone1, dob:dob1, gender: gender1,city: city)
                completion(buyerProfileModel)
            }
            else
            {
                print("error while retriving buyer profile data")
            }
            
        }
        
    }
    
    func storingProfileDataToFireBase(with buyerProfileModel:BuyerProfileModel)
    {
        
        
        buyerProfileData["uid"] = buyerProfileModel.uid
        buyerProfileData["imageRef"] = buyerProfileModel.imageRef
        buyerProfileData["name"] = buyerProfileModel.name
        buyerProfileData["email"] = buyerProfileModel.email
        buyerProfileData["state"] = buyerProfileModel.state
        buyerProfileData["phone"] = buyerProfileModel.phone
        buyerProfileData["dob"] = buyerProfileModel.dob
        buyerProfileData["gender"] = buyerProfileModel.gender
        buyerProfileData["city"] = buyerProfileModel.city
        buyerProfileData["tokenId"] = "not defined yet"

        
        if let userid = Auth.auth().currentUser?.uid {
            
            db.collection("UserProfileData").document("Buyer").collection("AllBuyers").document(userid).setData(buyerProfileData) { (error) in
                if let error = error {
                    print("Error while storingProfileDataToFireBase: \(error.localizedDescription)")
                } else {
                    
                    self.dataUplodedDelegant?.didsendData()
                    
                }
            }
            
        }
    }
    
    func uploadingProfileImage(with profileImage:Data,  completion :@escaping (URL)->() ){
        
        //filePath or unique name of an image , also used a name
        guard let filePath = Auth.auth().currentUser else {return}
        
        let storageRef = self.fireStorage.reference().child("Images/profile_images").child(filePath.uid)
        // meta data such as format of image
        let metaData = StorageMetadata()
        
        metaData.contentType = "image/jpeg"
        
        
        
        storageRef.putData(profileImage, metadata: metaData) { (meta, error) in
            if let e = error
            {
                print("error uploadind a file\(e.localizedDescription)")
                
            }
            else
            {
                //getting url
                storageRef.downloadURL { (url,error) in
                    guard let notNullUrl = url else {return}
                    
                    completion(notNullUrl)
                }
                
            }
        }
        
        
    }
    
    func retrivingProfileDataForChats(using userUid :String = Auth.auth().currentUser!.uid,completion : @escaping (ChatModel) -> ()) {
        
        
        db.collection("UserProfileData").document("Buyer").collection("AllBuyers").document(userUid).addSnapshotListener
        { (snapShot, error) in
            
            if let snap = snapShot?.data()
            {
                
                
                guard let imageRef1 = snap["imageRef"] as? String else {return}
                guard let name1 = snap["name"] as? String else {return}
                guard let state = snap["state"] as? String else {return}
                guard let tokenId = (snap["tokenId"] as? String) else {return}

                let userId = userUid
                
                let chatModel = ChatModel(image: imageRef1, name: name1, state: state, userId: userId,tokenId: tokenId )
                
                completion(chatModel)
            }
            
        }
        
    }
    
    func retrivingProfileDataForNotifications(using userUid :String,completion : @escaping (NotificationModel) -> ()) {
        
        
        db.collection("UserProfileData").document("Buyer").collection("AllBuyers").document(userUid).addSnapshotListener
        { (snapShot, error) in
            
            if let snap = snapShot?.data()
            {
                
                
                guard  let imageRef1 = snap["imageRef"] as? String else {return}
                guard  let name1 = snap["name"] as? String else {return}
                guard  let state = snap["state"] as? String else {return}
                guard  let uid = snap["uid"] as? String else {return}

                let notificationModel = NotificationModel(buyerImage: imageRef1, buyerName: name1, buyerState: state,buyerUID: uid)
                
                completion(notificationModel)
            }
            
        }
        
    }

    func addReviewsToProfile(with sellerId : String , buyerId : String , star : String , comment : String , uniqueId:String,completion :@escaping () -> ()) {
        db.collection("UserProfileData")
            .document("Buyer")
            .collection("AllBuyers")
            .document(buyerId)
            .collection("Reviews")
            .document(uniqueId)
            .setData(["buyerId":buyerId,"star":star,"comment":comment,"sellerId":sellerId]) { (error) in
                
                if let e = error
                {
                    print("error while addind reviews to buyer side : \(e.localizedDescription)")
                }
                else
                {
                    completion()
                }
                
            }
    }

    func addingTokenToProfile(with token : String){
        guard let id = Auth.auth().currentUser else {return}
        
        self.db.collection("UserProfileData")
            .document("Buyer")
            .collection("AllBuyers")
            .document(id.uid)
            .updateData(["tokenId" : token]) { (error) in
                if let e = error
                {
                    print("error while updating token id : \(e.localizedDescription)")
                }
                else
                {
                    print("updated seller token id")
                    
                }
            }

    }
}

