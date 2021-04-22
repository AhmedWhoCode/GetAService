//
//  ChatBrain.swift
//  GetAService
//
//  Created by Geek on 10/03/2021.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Firebase


class ChatBrain {
    
    var currentUser = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    var chatIds = [String]()
    
    var chats = [ChatModel]()
    
    
    func retrivingChatsFromDatabase(completion :@escaping ([String]) -> ()) {
        
        db.collection("Chats")
            .document(currentUser!)
            .collection("ChatWith")
            .order(by: "date" , descending: false)
            .addSnapshotListener{ (snapShot, error) in
            self.chatIds.removeAll()
            if let snap = snapShot?.documents
            {
                if snap.count > 0
                {
                    for i in 0...snap.count - 1
                    {
                        self.chatIds.append(snap[i].documentID)
                    }
                }
                print("pl22 \(self.chatIds)")
                completion(self.chatIds)
            }
            
        }
        
        
        
        
        
    }
    
    
    //checking if the user is buyer or seller , and getting profile accordingly , the function isUserSellerOrBuyer defined in helper file
    func gettingUserInfo(with ids : [String] , completion :@escaping ([ChatModel]) -> ())  {
        
        ids.forEach { (id) in
            
            isUserSellerOrBuyer(userID: id, completion: { (response) in
                
                if response.elementsEqual("seller")
                {
                    let sellerProfile = SellerProfileBrain()
                    
                    sellerProfile.retrivingProfileDataForChats(using: id) { (data) in
                        self.chats.append(data)
                        //checking if we are done with all ids , if not then the function will not end
                        if self.chats.count == ids.count
                        {
                            completion(self.chats)
                        }
                        
                    }
                }
                
                else if response.elementsEqual("buyer")
                {
                    let buyerProfile = BuyerProfileBrain()
                    buyerProfile.retrivingProfileDataForChats(using: id) { (data) in
                        self.chats.append(data)
                        if self.chats.count == ids.count
                        {
                            completion(self.chats)
                        }
                    }
                    
                }
                else
                {
                    print(response)
                }
                
            }
            
            )}
    }
    
    
    
}





////checking if the user is buyer or seller , and getting profile accordingly
//func gettingUserInfo1(with ids : [String] , completion :@escaping ([ChatModel]) -> ())  {
//
//    ids.forEach { (id) in
//
//        //checking if given id is buyer or seller
//        db.collection("isUserOrNil").document(id).getDocument { (snapShot, error) in
//
//            if let snap = snapShot?.data()
//            {
//                //getting profile info if an id is of seller
//                if snap["UserType"]! as! String == "Seller"
//                {
//
//                    let sellerProfile = SellerProfileBrain()
//
//                    sellerProfile.retrivingProfileDataForChats(using: id) { (data) in
//                        self.chats.append(data)
//                        //checking if we are done with all ids , if not then the function will not end
//                        if self.chats.count == ids.count
//                        {
//                            completion(self.chats)
//                        }
//
//                    }
//
//                }
//
//                else
//                {
//                    let buyerProfile = BuyerProfileBrain()
//                    buyerProfile.retrivingProfileDataForChats(using: id) { (data) in
//                        self.chats.append(data)
//                        if self.chats.count == ids.count
//                        {
//                            completion(self.chats)
//                        }
//                    }
//
//                }
//
//            }
//        }
//
//
//    }
//
//}
