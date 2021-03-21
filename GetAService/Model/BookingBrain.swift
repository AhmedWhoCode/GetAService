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
}


class BookingBrain {
    
    var bookingBrainDelegant : BookingBrainDelegant?
    static let sharedInstance = BookingBrain()
    var bookingInfoMap = [String:Any]()
    let db = Firestore.firestore()
    var dateForUniqueId : String = ""
    
    
    
    func insertBookingInfomationToFirebase(with bookingData : BookingModel) {
        
        guard let latitude = bookingData.eventLocation?.coordinates.latitude.description else {
            return
        }
        
        guard let longitude = bookingData.eventLocation?.coordinates.longitude.description  else {
            return
        }
        
        dateForUniqueId = String(format: "%f", bookingData.dateForUniqueId)
        
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
        
        db.collection("Bookings")
            .document("Buyer")
            .collection("AllBuyersWhoOrdered")
            .document(bookingData.buyerId)
            .collection("Books")
            .document(bookingData.sellerId)
            .collection("WithBookingID")
            .document(dateForUniqueId)
            .setData(bookingInfoMap, merge:true) { (error) in
                
                if let e = error
                {
                    print(e.localizedDescription)
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

    
}
