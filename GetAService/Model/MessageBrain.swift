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
    
    
    
    
    
    
    func storeMessageToFireBase(with data : MessageStructer ,completion : @escaping ()-> ()) {
        message["body"] = data.body
        message["senderId"] = data.senderId
        message["date"] = data.date
        message["messageId"] = data.date
        message["receiverId"] = data.receiverId
        // using timeStamp for unique message id
        db.collection("Chats").document((Auth.auth().currentUser?.uid)!).collection("ChatsId").document(data.date).setData(message) { (error) in
            
            if let e = error
            {
                print(e)
            }
            else
            {
                self.db.collection("Chats").document(data.receiverId).collection("ChatsId").document(data.date).setData(self.message) { (error) in
                    
                    if let e = error
                    {
                        print(e)
                    }
                    else
                    {
                        completion()
                        
                    }
                    
                    
                }
                print("message saved")
            }
        }
        
    }
    
    
    func retrivingMessagesFormFirebase(completion : @escaping ([MessageStructer]) -> ()) {
        
        
        db.collection("Chats").document((Auth.auth().currentUser?.uid)!).collection("ChatsId").addSnapshotListener { (snapShot, error) in
            
            self.messagesFromFirbase.removeAll()
            if let snap = snapShot?.documentChanges
            {
                if snap.count > 0
                {
                    for i in 0...snap.count - 1
                    {
                        
                        
                        let body = snap[i].document["body"] as! String
                        let date = snap[i].document["date"] as! String
                        //let messageId = snap[i].data()["messageId"] as! String
                        let senderId = snap[i].document["senderId"] as! String
                        let receiverId = snap[i].document["receiverId"] as! String
                        
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
        
        
        
        
        //
        //        db.collection("Chats").document((Auth.auth().currentUser?.uid)!).collection("ChatsId").getDocuments { (snapShot, error) in
        //
        //            if let snap = snapShot?.documents
        //            {
        //                if snap.count > 0
        //                {
        //                    for i in 0...snap.count - 1
        //                    {
        //                        let body = snap[i].data()["body"] as! String
        //                        let date = snap[i].data()["date"] as! String
        //                        //let messageId = snap[i].data()["messageId"] as! String
        //                        let senderId = snap[i].data()["senderId"] as! String
        //
        //                        let messages = MessageStructer(body: body , senderId: senderId, date: date)
        //
        //                        self.messagesFromFirbase.append(messages)
        //                    }
        //                    completion(self.messagesFromFirbase)
        //                }
        //            }
        //            else
        //            {
        //                print(error!.localizedDescription)
        //            }
        //
        //        }
    }
}
