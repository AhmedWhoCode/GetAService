//
//  BookingBrain.swift
//  GetAService
//
//  Created by Geek on 21/03/2021.
//

import Foundation
import CoreLocation
import Firebase
import FirebaseAuth

protocol BookingBrainDelegant {
    func didSendTheBookingDetails()
    func didSellerRespond(result : String)
}


class BookingBrain {
    
    var bookingBrainDelegant : BookingBrainDelegant?
    static let sharedInstance = BookingBrain()
    var bookingInfoMap = [String:Any]()
    let db = Firestore.firestore()
    var dateForUniqueId : String = ""
    var buyerId : String?
    var sellerId : String?
    
    func insertBookingInfomationToFirebase(with bookingData : BookingModel) {
        
        guard let latitude = bookingData.eventLocation?.coordinates.latitude.description else {
            return
        }
        
        guard let longitude = bookingData.eventLocation?.coordinates.longitude.description  else {
            return
        }
        buyerId = bookingData.buyerId
        sellerId = bookingData.sellerId
        
       dateForUniqueId = String(format: "%.1f", bookingData.dateForUniqueId)
        
        bookingInfoMap["buyerId"] = bookingData.buyerId
        bookingInfoMap["sellerId"] = bookingData.sellerId
        bookingInfoMap["buyerId"] = bookingData.buyerId
        bookingInfoMap["recepientName"] = bookingData.recepientName
        bookingInfoMap["servicesNeeded"] = bookingData.servicesNeeded
        bookingInfoMap["phoneNumber"] = bookingData.phoneNumber
        bookingInfoMap["eventTimeAndDate"] = bookingData.eventTimeAndDate
        bookingInfoMap["eventDescription"] = bookingData.eventDescription
        bookingInfoMap["eventLocationAddress"] = bookingData.eventLocation?.address
        bookingInfoMap["eventLocationLatitude"] = latitude
        bookingInfoMap["eventLocationLongitude"] = longitude
        bookingInfoMap["totalSeonds"] = Int(bookingData.dateForUniqueId)
        bookingInfoMap["bookingStatus"] = bookingData.bookingStatus
        print(bookingData.dateForUniqueId)
        
        db.collection("Bookings")
            .document("Buyer")
            .collection("AllBuyersWhoOrdered")
            .document(bookingData.buyerId)
            .collection("Books")
            .document(bookingData.sellerId)
            .collection("WithBookingID")
            .document(dateForUniqueId)
            .setData(bookingInfoMap, merge:false) { (error) in
                
                if let e = error
                {
                    print("error while making booking \(e.localizedDescription)")
                }
                else
                {
                    self.addDataForSellers(with: self.bookingInfoMap , bookingData: bookingData)
                }
            }
        
    }
    
    func addDataForSellers(with bookingInfo:[String:Any] , bookingData : BookingModel) {
        
        db.collection("Bookings")
            .document("Seller")
            .collection("AllSellerWhoReceivedOrders")
            .document(bookingData.sellerId)
            .collection("BookedBy")
            .document(bookingData.buyerId)
            .setData(["dd" : "dd"]) { (error) in
                
                if let e = error
                {
                    print(e)
                }
                
                else
                {
                    self.db.collection("Bookings")
                        .document("Seller")
                        .collection("AllSellerWhoReceivedOrders")
                        .document(bookingData.sellerId)
                        .collection("BookedBy")
                        .document(bookingData.buyerId)
                        .collection("WithBookingID")
                        .document(self.dateForUniqueId)
                        .setData(bookingInfo, merge:true) { (error) in
                            
                            if let e = error
                            {
                                print(e.localizedDescription)
                            }
                            else
                            {
                                self.bookingBrainDelegant?.didSendTheBookingDetails()
                            }
                        }
                }
                
            }
        
        
        
    }
    //with buyerId :String , sellerId :String
    
    func sellerResponded() {
        
        //retriving notification detail and ordered by the last document added , most recent one
        db.collection("Bookings")
            .document("Seller")
            .collection("AllSellerWhoReceivedOrders")
            .document(sellerId!)
            .collection("BookedBy")
            .document(buyerId!)
            .collection("WithBookingID")
            .order(by: "totalSeonds", descending: true).limit(to: 1)
            .addSnapshotListener { (query, error) in
                
                if let q = query?.documentChanges
                {
                    
                    print(q[0].document.data())
                    if(q[0].document.data().isEmpty)
                    {
                        
                    }
                    else
                    {
                        
                        if (q[0].document.data()["bookingStatus"] as? String)! == "accepted"
                        {
                            self.bookingBrainDelegant?.didSellerRespond(result : "accepted")
                            print("yes, its happen")
                        }
                        else if (q[0].document.data()["bookingStatus"] as? String)! == "rejected"
                        {
                            self.bookingBrainDelegant?.didSellerRespond(result : "rejected")
                            print("noooooooooo")
                        }
                    }
                    
                }
            }
        
        
    }
    
    
}
