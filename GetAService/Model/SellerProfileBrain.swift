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
    
    let db = Firestore.firestore()
    
    var fireStorage = Storage.storage()
    
    var reviewsList = [SellerRetrievalReviewsModel]()
    var portfolioImages = [String]()
    
    
    func retrivingProfileData(using userUid :String = Auth.auth().currentUser!.uid,completion : @escaping (SellerProfileModel,[String]?) -> ()) {
        
        // let userId = Auth.auth().currentUser!.uid
        
        db.collection("UserProfileData").document("Seller").collection("AllSellers").document(userUid).addSnapshotListener
        { (snapShot, error) in
            
            if let snap = snapShot?.data()
            {
                
                
                guard let imageRef1 = snap["imageRef"] as? String else {return}
                guard let name1 = snap["name"] as? String else {return}
                guard let email1 = snap["email"] as? String else {return}
                guard let state = snap["state"] as? String else {return}
                guard let phone1 = snap["phone"] as? String else {return}
                guard let price1 = snap["price"] as? String else {return}
                guard let service1 = snap["service"] as? String else {return}
                guard let gender1 = snap["gender"] as? String else {return}
                guard let dob = snap["dob"] as? Timestamp else {return}
                 let dob1 = dob.dateValue()
                guard let uid1 = snap["uid"] as? String else {return}
                guard let desc = snap["description"] as? String else {return}
                guard let city = snap["city"] as? String else {return}
                
                 let subServices = snap["SubServices"]
                
                guard let document = snap["documentUrl"] as? String else {return}
                guard let documentName = snap["documentName"] as? String else {return}
                guard let tokenId = snap["tokenId"] as? String else {return}
                
                //storing tokenID of a current user in booking brain class
                BookingBrain.sharedInstance.sellerTokenId = tokenId
                
                let sellerProfileModel = SellerProfileModel(uid:uid1, imageRef: imageRef1 , name: name1, email:email1, state: state, phone: phone1, price: price1, service: service1, city: city, description: desc, dob:dob1, gender: gender1,document: document , documentName: documentName)
                
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
        sellerProfileData["state"] = sellerProfileModel.state
        sellerProfileData["phone"] = sellerProfileModel.phone
        sellerProfileData["price"] = sellerProfileModel.price
        sellerProfileData["service"] = sellerProfileModel.service
        sellerProfileData["dob"] = sellerProfileModel.dob
        sellerProfileData["gender"] = sellerProfileModel.gender
        sellerProfileData["description"] = sellerProfileModel.description
        sellerProfileData["city"] = sellerProfileModel.city
        sellerProfileData["status"] = Constants.online
        sellerProfileData["documentUrl"] = sellerProfileModel.document
        sellerProfileData["documentName"] = sellerProfileModel.documentName
        sellerProfileData["tokenId"] = "not defined yet"
        
        
        
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
    
    
    
    func storeSubServivesToFirebase(with subServices:[String],
                                    withPrice:[String:String],
                                    completion :@escaping () -> ())
    {
        
        print("here2", withPrice)
        let userId = Auth.auth().currentUser!.uid
        
        db.collection("UserProfileData")
            .document("Seller")
            .collection("AllSellers")
            .document(userId)
            .setData(["SubServices" : subServices], merge: true) { (error) in
                if let e = error
                {
                    print("error while storing the subservices:",e)
                }
                else
                {
                    //now  adding each item of withprice dictionary in the firebase
                    for key in withPrice.keys
                    {
                        print("here5" , key)

                        guard let price = withPrice[key] else {return}
                        
                        self.db.collection("UserProfileData")
                            .document("Seller")
                            .collection("AllSellers")
                            .document(userId)
                            .collection("subservices")
                            .document(key)
                            .setData(["price" : price] , merge: false)
                            { (error) in
                                
                                if let e = error
                                {
                                    print("error while storing the subservices:",e)
                                }
                                else
                                {
                                    completion()
                                    
                                }
                                
                            }
                        
                    }
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
                        guard let uid = snap[i].data()["uid"] as? String else {return}
                        guard  let image = snap[i].data()["imageRef"] as? String else {return}
                        guard let price = snap[i].data()["price"] as? String else {return}
                        guard let name = snap[i].data()["name"] as? String else {return}
                        guard let state = snap[i].data()["state"] as? String else {return}
                        guard let city = snap[i].data()["city"] as? String else {return}
                        guard let status = snap[i].data()["status"] as? String else {return}
                        
                        let s = SellerShortInfo(uid : uid,image: image, price: price, name: name, state: state, availability: "available",status: status,city: city)
                        self.sellerShortInfoArray.append(s)
                        
                    }
                    completion(self.sellerShortInfoArray)

                }

            }
            
        }
        
    }
    
    
    
    func retrivingProfileDataForChats(using userUid :String = Auth.auth().currentUser!.uid,completion : @escaping (ChatModel) -> ()) {
        
        // let userId = Auth.auth().currentUser!.uid
        
        db.collection("UserProfileData").document("Seller").collection("AllSellers").document(userUid).addSnapshotListener
        { (snapShot, error) in
            
            if let snap = snapShot?.data()
            {
                
                
                guard let imageRef1 = snap["imageRef"] as? String else {return}
                guard let name1 = snap["name"] as?  String else {return}
                guard let state = snap["state"] as?  String else {return}
                guard let tokenId = snap["tokenId"] as?  String else {return}
                
                let userId = userUid
                
                let chatModel = ChatModel(image: imageRef1, name: name1, state: state, userId: userId, tokenId: tokenId)
                
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
    
    func uploadingDocument(with data:URL,  completion :@escaping (URL)->() ){
        let userId = Auth.auth().currentUser!.uid
        
        //filePath or unique name of an image , also used a name
        let storageRef = self.fireStorage.reference().child("documents").child(userId)
        
        
        storageRef.putFile(from : data, metadata: nil) { (meta, error) in
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
                print("document uploaded")
                
            }
        }
        
        
    }
    
    ///MARK: - Adding portfolio images to storage
    
    func uploadPortFolioToStorage(with data : Data , completion :@escaping  () -> ()) {
        let userId = Auth.auth().currentUser!.uid
        
        //for unique id
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        let dateString = df.string(from: date)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        //filePath or unique name of an image , also used a name
        let storageRef = self.fireStorage.reference().child("sellerportFolioImages").child(userId).child(dateString)
        
        
        
        storageRef.putData(data, metadata: metaData) { (meta, error) in
            if  error != nil
            {
                print("error uploadind a file\(error?.localizedDescription ?? "Error")")
                
            }
            else
            {
                //getting url
                storageRef.downloadURL { (url,error) in
                    print(url?.absoluteURL ?? "nil")
                    //Adding portfolio images data to firestore
                    self.addingPortfolioImagesUrlToFirestore(with: dateString, imageUrl: url!.absoluteString, sellerId: userId) {
                        
                        completion()
                    }
                }
            }
        }
        
    }
    
    ///MARK: - Adding portfolio images data to firestore
    func addingPortfolioImagesUrlToFirestore(with imageId : String ,
                                             imageUrl : String ,
                                             sellerId : String,
                                             completion :@escaping  () -> ()
    )
    {
        db.collection("UserProfileData")
            .document("Seller")
            .collection("AllSellers")
            .document(sellerId)
            .collection("PortfolioImages")
            .document(imageId)
            .setData(["imageUrl" : imageUrl], merge: true) { (error) in
                
                if let e = error
                {
                    print("error while addingPortfolioImagesUrlToFirestore" , e.localizedDescription)
                }
                else
                {
                    print("successfully addingPortfolioImagesUrlToFirestore")
                    completion()
                }
                
            }
    }
    
    
    func retrivingPortfolioImages(using sellerId : String , completion : @escaping ([String]) -> ()) {
        db.collection("UserProfileData")
            .document("Seller")
            .collection("AllSellers")
            .document(sellerId)
            .collection("PortfolioImages")
            .getDocuments { (snapshot, error) in
                
                if let snap = snapshot?.documents
                {
                    
                    snap.forEach { (data) in
                        //print( data.data()["imageUrl"] )
                        let image = data.data()["imageUrl"] as? String
                        self.portfolioImages.append(image!)
                    }
                    
                    completion(self.portfolioImages)
                }
                
                else
                {
                    print("error while retriving portfolio images" , error?.localizedDescription as Any)
                }
                
            }
    }
    
    
    func addingTokenToProfile(with token : String){
        guard let id = Auth.auth().currentUser else {return}
        
        self.db.collection("UserProfileData")
            .document("Seller")
            .collection("AllSellers")
            .document(id.uid)
            .updateData(["tokenId" : token]) { (error) in
                if let e = error
                {
                    print("error while updating token id : \(e)")
                }
                else
                {
                    print("updated seller token id")
                    
                }
            }
        
    }
    
    
  
}


