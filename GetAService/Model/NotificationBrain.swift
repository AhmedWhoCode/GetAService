//
//  NotificationBrain.swift
//  GetAService
//
//  Created by Geek on 21/03/2021.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Firebase


protocol NotificationBrainDelegant {
    func didReceiveTheData(values : [NotificationModel])
}


class NotificationBrain {
    
    var notificationBrainDelegant : NotificationBrainDelegant?
    var currentUser = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    var buyerIds = [String]()
    var buyerProfileBrain = BuyerProfileBrain()
    
    
    var notifications = [NotificationModel]()
    
    
    
    func retrivingNotifications() {
       
        
//        db.collection("Bookings")
//            .document("Seller")
//            .collection("AllSellerWhoReceivedOrders")
//            .document(currentUser!)
//            .addSnapshotListener { (snap, error) in
//                self.buyerIds.removeAll()
//                if let s = snap?
//                          {
//                              if s.count > 0
//                              {
//                                  for i in 0...s.count - 1
//                                  {
//                                      self.buyerIds.append(s[i].document.documentID)
//
//                                  }
//                                  //print(self.buyerIds)
//                                  self.getProfileInformations(with: self.buyerIds)
//                              }
//                          }
//                          else
//                          {
//                              print(error?.localizedDescription)
//                          }
//
//            }
        
        db.collection("Bookings")
            .document("Seller")
            .collection("AllSellerWhoReceivedOrders")
            .document(currentUser!)
            .collection("BookedBy")
            .addSnapshotListener { (snap, error) in
                print(snap?.count)
                self.buyerIds.removeAll()
                if let s = snap?.documentChanges
                {
                    if s.count > 0
                    {
                        for i in 0...s.count - 1
                        {
                            self.buyerIds.append(s[i].document.documentID)

                        }
                        //print(self.buyerIds)
                        self.getProfileInformations(with: self.buyerIds)
                    }
                }
                else
                {
                    print(error?.localizedDescription)
                }
            }
        
        
        
//
//        db.collection("Bookings")
//            .document("Seller")
//            .collection("AllSellerWhoReceivedOrders")
//            .document(currentUser!)
//            .collection("BookedBy").addSnapshotListener(includeMetadataChanges: true, listener: { (snap, error) in
//                self.buyerIds.removeAll()
//                if let s = snap?.documentChanges
//                {
//                    if s.count > 0
//                    {
//                        for i in 0...s.count - 1
//                        {
//                            self.buyerIds.append(s[i].document.documentID)
//
//                        }
//                        //print(self.buyerIds)
//                        self.getProfileInformations(with: self.buyerIds)
//                    }
//                }
//                else
//                {
//                    print(error?.localizedDescription)
//                }
//            })

    }
    
    func getProfileInformations(with ids : [String]) {
        
        ids.forEach { id in
            
            buyerProfileBrain.retrivingProfileDataForNotifications(using: id) { (profileData) in
                self.notifications.append(profileData)
                //checking if we are done with all ids , if not then the function will not end
                if self.notifications.count == ids.count
                {
                    
                    self.notificationBrainDelegant?.didReceiveTheData(values: self.notifications)
                    print(self.notifications)
                }
                
            }
            
        }
        
    }
    
    func retrivingNotificationDetail(using buyerId : String , completion : @escaping (NotificationDetailModel) -> ()) {
        
        //retriving notification detail and ordered by the last document added , most recent one
        db.collection("Bookings")
            .document("Seller")
            .collection("AllSellerWhoReceivedOrders")
            .document(currentUser!)
            .collection("BookedBy")
            .document(buyerId)
            .collection("WithBookingID")
            .order(by: "eventTimeAndDate", descending: true).limit(to: 1)
            .addSnapshotListener { (query, error) in
                
                if let q = query?.documents
                {
                    
                    print(q[0].data())
                    
                    
                    let servicesNeeded = (q[0].data()["servicesNeeded"] as? String)!
                    let eventTimeAndDate = (q[0].data()["eventTimeAndDate"] as? String)!
                    let eventlocationAddress = (q[0].data()["eventLocationAddress"] as? String)!
                    let eventDescription  = (q[0].data()["eventDescription"] as? String)!
                    
                    
                    let notificationDetail = NotificationDetailModel(serivceNeeded: servicesNeeded,
                                                                     eventTimeAndDate: eventTimeAndDate,
                                                                     eventlocationAddress: eventlocationAddress,
                                                                     eventDescription: eventDescription)
                    completion(notificationDetail)
                    
                    
                }
            }
        
        
    }
}
