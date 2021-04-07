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
        
        
        db.collection("Bookings")
            .document("Seller")
            .collection("AllSellerWhoReceivedOrders")
            .document(currentUser!)
            .collection("BookedBy")
            .addSnapshotListener { (snap, error) in
                //print(snap?.count)
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
    
    func retrivingNotificationDetail(using buyerId : String , completion : @escaping (NotificationDetailModel,String) -> ()) {
        
        //retriving notification detail and ordered by the last document added , most recent one
        db.collection("Bookings")
            .document("Seller")
            .collection("AllSellerWhoReceivedOrders")
            .document(currentUser!)
            .collection("BookedBy")
            .document(buyerId)
            .collection("WithBookingID")
            .order(by: "totalSeonds", descending: true).limit(to: 1)
            .getDocuments { (query, error) in
                
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
                    completion(notificationDetail,q[0].documentID)
                    
                    
                }
            }
        
        
    }
    
//    func updateNavigationStatus(with status : String ,
//                                buyerId : String ,
//                                notificationId : String) {
//        
//        
//        self.db.collection("Bookings")
//            .document("Seller")
//            .collection("AllSellerWhoReceivedOrders")
//            .document(self.currentUser!)
//            .collection("BookedBy")
//            .document(buyerId)
//            .collection("WithBookingID")
//            .document(notificationId)
//            .collection("tracking")
//            .document("TrackBooking")
//            .
//    }
    
    
    func updateBookingStatus(
        with status : String ,
        buyerId : String ,
        notificationId : String,
        sellerLatitude : String = "Not defined",
        sellerLongitude : String = "Not defined",
        sellerAddress : String = "Not defined",
        sellerUpdatedPrice : String = "Not defined"
        
    )
    
    {
        
        
        self.db.collection("Bookings")
            .document("Seller")
            .collection("AllSellerWhoReceivedOrders")
            .document(self.currentUser!)
            .collection("BookedBy")
            .document(buyerId)
            .collection("WithBookingID")
            .document(notificationId)
            .updateData(
                ["bookingStatus" : status ,
                 "sellerLatitude" : sellerLatitude ,
                 "sellerLongitude" : sellerLongitude ,
                 "sellerAddress" : sellerAddress,
                 "sellerPrice" : sellerUpdatedPrice
                ]
            )
            { (error) in
                
                if let e = error
                {
                    print("this is the error while updating status \(e.localizedDescription)")
                }
                else
                {
                    print("updated the document")
                    self.updatingBuyerSide(with: notificationId, buyerID: buyerId, status: status,sellerLatitude: sellerLatitude, sellerLongitude: sellerLongitude , sellerAddress:sellerAddress,sellerUpdatedPrice: sellerUpdatedPrice)
                }
            }
        
        
    }
    
    func updatingBuyerSide(with bookingId :String ,
                           buyerID : String ,
                           status :String,
                           sellerLatitude : String = "Not defined",
                           sellerLongitude : String = "Not defined",
                           sellerAddress : String = "Not defined",
                           sellerUpdatedPrice : String
    )
    {
        db.collection("Bookings")
            .document("Buyer")
            .collection("AllBuyersWhoOrdered")
            .document(buyerID)
            .collection("Books")
            .document(currentUser!)
            .collection("WithBookingID")
            .document(bookingId)
            .updateData(
                ["bookingStatus" : status ,
                 "sellerLatitude" : sellerLatitude ,
                 "sellerLongitude" : sellerLongitude ,
                 "sellerAddress" : sellerAddress,
                 "sellerPrice" : sellerUpdatedPrice
                ])
            { (error) in
                
                if let e = error
                {
                    print("this is the error while updating status \(e.localizedDescription)")
                }
                else
                {
                    print("status updated")
                }
            }
    }
    
    
    
    
    func retrivingNotifications1() {
        
        
        db.collection("Bookings")
            .document("Seller")
            .collection("AllSellerWhoReceivedOrders")
            .document(currentUser!)
            .collection("BookedBy")
            
            .addSnapshotListener { (snap, error) in
                //print(snap?.count)
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
        
        
    }
    
    //function to take user to correct screen in notification
    func navigateToCorrectScreen(with buyerId : String , completion : @escaping (String) -> ())  {
        
        //checking if the user is buyer or buyer
        isUserSellerOrBuyer(userID: currentUser!) { (response) in
            if response == "seller"
            {
                //getting notification id
                self.getLatestNotificationId(with: self.currentUser!, buyerId: buyerId) { (notificationId) in
                    
                    self.db.collection("Bookings")
                        .document("Seller")
                        .collection("AllSellerWhoReceivedOrders")
                        .document(self.currentUser!)
                        .collection("BookedBy")
                        .document(buyerId)
                        .collection("WithBookingID")
                        .document(notificationId)
                        .collection("tracking")
                        .document("TrackBooking")
                        .getDocument { (snapshot, error) in
                            
                            if let e = error
                            {
                                print("error while navigateToCorrectScreen : \(e.localizedDescription) ")
                            }
                            else
                            {
                                if let snap = snapshot?.data()
                                {
                                    if snap.count > 0
                                    {
                                        let response = snapshot?.data()!["acknowlegdeStatus"] as? String
                                        BookingBrain.sharedInstance.sellerId = self.currentUser
                                        BookingBrain.sharedInstance.buyerId = buyerId
                                        BookingBrain.sharedInstance.currentBookingDocumentId = notificationId
                                        completion(response!)
                                    }
                                    else
                                    {
                                        completion("continue")
                                    }
                                }
                                else
                                {
                                    completion("continue")
                                }
                            }
                        }
                }
            }
            
            
        }
        
        
    }
    
    func getLatestNotificationId(with sellerId:String , buyerId :String , completion :@escaping (String) -> ()) {
        db.collection("Bookings")
            .document("Seller")
            .collection("AllSellerWhoReceivedOrders")
            .document(sellerId)
            .collection("BookedBy")
            .document(buyerId)
            .collection("WithBookingID")
            .order(by: "totalSeonds", descending: true).limit(to: 1)
            .getDocuments { (snapshot, error) in
                
                if let e = error
                {
                    print("error while getting notification id \(e.localizedDescription) ")
                }
                else if snapshot!.count > 0
                {
                    if let id = snapshot?.documents[0].documentID
                    {
                        completion(id)
                    }
                    //print("this \(snapshot?.documents[0].documentID)")
                }
            }
        
    }
}
