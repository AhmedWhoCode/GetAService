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
protocol DataUploadedSeller
{
    func didsendData()
}

class SellerProfileBrain {
    
    var sellerShortInfoArray  = [SellerShortInfo]()
    
    var sellerProfileData = [String:Any]()
    
    var dataUplodedDelegant:DataUploadedSeller?
    //
    //    if let userId1 = Auth.auth().currentUser?.uid
    //    {
    //        print("ss")
    //    }
    
    // let userId = Auth.auth().currentUser!.uid
    
    let db = Firestore.firestore()
    var fireStorage = Storage.storage()
    
    var reviewsList = [SellerRetrievalReviewsModel]()
    
    
    func retrivingProfileData(using userUid :String = Auth.auth().currentUser!.uid,completion : @escaping (SellerProfileModel,[String]?) -> ()) {
        
        // let userId = Auth.auth().currentUser!.uid
        
        db.collection("UserProfileData").document("Seller").collection("AllSellers").document(userUid).addSnapshotListener
        { (snapShot, error) in
            
            if let snap = snapShot?.data()
            {
                
                
                let imageRef1 = snap["imageRef"]! as! String
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
                let desc = snap["description"]! as! String
                let country = snap["country"]! as! String
                let subServices = snap["SubServices"]
                
                let sellerProfileModel = SellerProfileModel(uid:uid1, imageRef: imageRef1 , name: name1, email:email1, address: address1, phone: phone1, price: price1, service: service1, country: country, description: desc, dob:dob1, gender: gender1)
                
                completion(sellerProfileModel , subServices as? [String])
            }
            
        }
        
    }
    
    
    func storingProfileDataToFireBase(with sellerProfileModel:SellerProfileModel)
    {
        
        // let userId = Auth.auth().currentUser!.uid
        
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
        sellerProfileData["description"] = sellerProfileModel.description
        sellerProfileData["country"] = sellerProfileModel.country
        sellerProfileData["status"] = Constants.online
        
        
        if let userid = Auth.auth().currentUser?.uid {
            
            
            // it also merges the previous data
            db.collection("UserProfileData").document("Seller").collection("AllSellers").document(userid).setData(sellerProfileData , merge: true ) { (error) in
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
        let userId = Auth.auth().currentUser!.uid
        
        //filePath or unique name of an image , also used a name
        let storageRef = self.fireStorage.reference().child("Images/profile_images").child(userId)
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
    
    
    
    func storeSubServivesToFirebase(with subServices:[String] ,  completion :@escaping () -> ()) {
        
        let userId = Auth.auth().currentUser!.uid
        
        db.collection("UserProfileData").document("Seller").collection("AllSellers").document(userId).setData(["SubServices" : subServices], merge: true) { (error) in
            if let e = error
            {
                print(e)
            }
            else
            {
                completion()
            }
        }
        
        
    }
    
    
    func retrivingFilteredSellers(with service : String , completion :@escaping ([SellerShortInfo])->()) {
        db.collection("UserProfileData").document("Seller").collection("AllSellers").whereField("service", isEqualTo: service).addSnapshotListener { (snapshot, error) in
            
            //  let userId = Auth.auth().currentUser!.uid
            
            if let snap = snapshot?.documents
            {
                self.sellerShortInfoArray.removeAll()
                
                if snap.count > 0
                {
                    for i in 0...snap.count - 1
                    {
                        let uid = snap[i].data()["uid"] as! String
                        let image = snap[i].data()["imageRef"] as! String
                        let price = snap[i].data()["price"] as! String
                        let name = snap[i].data()["name"] as! String
                        let country = snap[i].data()["country"] as! String
                        let status = snap[i].data()["status"] as! String
                        
                        let s = SellerShortInfo(uid : uid,image: image, price: price, name: name, country: country, availability: "available",status: status)
                        self.sellerShortInfoArray.append(s)
                        
                    }
                }
            }
            
            completion(self.sellerShortInfoArray)
        }
        
    }
    
    
    
    func retrivingProfileDataForChats(using userUid :String = Auth.auth().currentUser!.uid,completion : @escaping (ChatModel) -> ()) {
        
        // let userId = Auth.auth().currentUser!.uid
        
        db.collection("UserProfileData").document("Seller").collection("AllSellers").document(userUid).addSnapshotListener
        { (snapShot, error) in
            
            if let snap = snapShot?.data()
            {
                
                
                let imageRef1 = snap["imageRef"]! as! String
                let name1 = snap["name"]! as! String
                let country = snap["country"]! as! String
                let userId = userUid
                
                let chatModel = ChatModel(image: imageRef1, name: name1, country: country, userId: userId)
                
                completion(chatModel)
            }
            
        }
        
    }
    
    
    func retrivingProfileDataForBooking(using userUid :String,completion : @escaping (String) -> ()) {
        
        //let userId = Auth.auth().currentUser!.uid
        
        db.collection("UserProfileData").document("Seller").collection("AllSellers").document(userUid).getDocument
        { (snapShot, error) in
            
            if let snap = snapShot?.data()
            {
                
                
                let price = snap["price"]! as! String
                
                completion(price)
            }
            
        }
        
    }
    
    
    func addReviewsToProfile(with sellerId : String , buyerId : String , star : String , comment : String , uniqueId:String,completion :@escaping () -> ()) {
        // let userId = Auth.auth().currentUser!.uid
        
        db.collection("UserProfileData")
            .document("Seller")
            .collection("AllSellers")
            .document(sellerId)
            .collection("Reviews")
            .document(uniqueId)
            .setData(["buyerId":buyerId,"star":star,"comment":comment,"sellerId":sellerId]) { (error) in
                
                if let e = error
                {
                    print("error while addind reviews to seller side : \(e)")
                }
                else
                {
                    completion()
                }
                
            }
    }
    
    
    func retrivingSellerReviews(with sellerId : String , completion : @escaping ([SellerRetrievalReviewsModel]) -> ()) {
        // let userId = Auth.auth().currentUser!.uid
        
        db.collection("UserProfileData")
            .document("Seller")
            .collection("AllSellers")
            .document(sellerId)
            .collection("Reviews")
            .getDocuments { (snapshot, error) in
                
                if let e = error
                {
                    print("error while retriving seller reviews \(e)")
                }
                
                else
                {
                    
                    if snapshot!.count > 0
                    {
                        snapshot?.documents.forEach({ (data) in
                            let star =  data.data()["star"] as? String
                            let comment =  data.data()["comment"] as? String
                            let review = SellerRetrievalReviewsModel(star: star!, comment:comment!)
                            
                            self.reviewsList.append(review)
                        })
                        completion(self.reviewsList)
                    }
                    
                }
                
            }
        
    }
    
    func updateOnlineStatus(with status : String){
        
        if let id = Auth.auth().currentUser
        {
            isUserSellerOrBuyer(userID:id.uid) { (reponse) in
                
                if reponse == "seller"
                {
                    self.db.collection("UserProfileData")
                        .document("Seller")
                        .collection("AllSellers")
                        .document(id.uid)
                        .updateData(["status" : status]) { (error) in
                            if let e = error
                            {
                                print("error while updating seller status : \(e)")
                            }
                            else
                            {
                                print("updated seller status")
                                
                            }
                        }
                }
                
                
                
            }
        }
        
        
        
        
        
    }
}


