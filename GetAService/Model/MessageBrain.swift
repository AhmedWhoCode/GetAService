//
//  MessageBrain.swift
//  GetAService
//
//  Created by Geek on 09/03/2021.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Firebase

class MessageBrain {
    let db = Firestore.firestore()
    var fireStorage = Storage.storage()
    var message = [String:Any]()
    var messagesFromFirbase = [MessageStructer]()
    var currentUser = (Auth.auth().currentUser?.uid)!
    
    
    
    
    //getting current user image by calling a function which is placed in a swift file named helper function
    
    func gettingCurrentUserImage(with uid : String ,completion: @escaping (String)->() ) {
        
        isUserSellerOrBuyer(userID: uid, completion: { (response) in
            
            if response.elementsEqual("seller")
            {
                let sellerProfile = SellerProfileBrain()
                
                sellerProfile.retrivingProfileDataForChats(using: uid) { (data) in
                    
                    completion(data.image)
                    
                }
            }
            
            else if response.elementsEqual("buyer")
            {
                let buyerProfile = BuyerProfileBrain()
                
                buyerProfile.retrivingProfileDataForChats(using: uid) { (data) in
                    
                    completion(data.image)
                    
                }
                
            }
            else
            {
                print(response)
            }
        })
        
    }
    
    
    
    
    func storeMessageToFireBase(with data : MessageStructer ,completion : @escaping ()-> ()) {
        
        message["body"] = data.body
        message["senderId"] = data.senderId
        message["date"] = data.date
        message["messageId"] = data.date
        message["receiverId"] = data.receiverId
        // using timeStamp for unique message id
        
        //storing the redundant data to prevent the bug
        db.collection("Chats").document(currentUser).collection("ChatWith").document(data.receiverId).setData(["mm" : "mm"]) { (error) in
            
            if let e = error
            {
                print("error while creating message to firebase \(e.localizedDescription)")
                
            }
            else
            {
                // stroing data on current user side
                self.db.collection("Chats").document(self.currentUser).collection("ChatWith").document(data.receiverId).collection("AllSingleChat").document(data.date).setData(self.message) { (error) in
                    if let e = error
                    {
                        print("error while storing message: \(e.localizedDescription)")
                    }
                    else
                    {
                        //storing the redundant data to prevent the bug
                        
                        self.db.collection("Chats").document(data.receiverId).collection("ChatWith").document(self.currentUser).setData(["mm" : "mm"]) { (error) in
                            if let e = error
                            {
                                print("seller ki chat \(e.localizedDescription)")
                            }
                            else
                            {
                                // stroing data on other user side
                                self.db.collection("Chats").document(data.receiverId).collection("ChatWith").document(self.currentUser).collection("AllSingleChat").document(data.date).setData(self.message){ (error) in
                                    
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
                        }
                        
                        
                        
                        print("message saved")
                    }
                }
            }
            
        }
        
        
    }
    
    
    
    
    
    func retrivingMessagesFormFirebase(with receiverID:String, completion : @escaping ([MessageStructer]) -> ()) {
        
        db.collection("Chats").document((Auth.auth().currentUser?.uid)!).collection("ChatWith").document(receiverID).collection("AllSingleChat").addSnapshotListener { (snapShot, error) in
            
            self.messagesFromFirbase.removeAll()
            if let snap = snapShot?.documentChanges
            {
                if snap.count > 0
                {
                    for i in 0...snap.count - 1
                    {
                        
                        guard let body = snap[i].document["body"] as? String else {return}
                        guard let date = snap[i].document["date"] as? String else {return}
                        //let messageId = snap[i].data()["messageId"] as! String
                        guard let senderId = snap[i].document["senderId"] as? String else {return}
                        guard let receiverId = snap[i].document["receiverId"] as? String else {return}
                        
                        let messages = MessageStructer(body: body , senderId: senderId, date: date , receiverId: receiverId)
                        
                        self.messagesFromFirbase.append(messages)
                    }
                    completion(self.messagesFromFirbase)
                }
            }
            else
            {
                print(error!.localizedDescription)
            }
        }
        
    }
}
