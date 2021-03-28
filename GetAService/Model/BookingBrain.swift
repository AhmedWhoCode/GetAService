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
import FirebaseFirestore
protocol BookingBrainDelegate {
    func didSendTheBookingDetails()
    func didSellerRespond(result : String)
    func didAcknowledgementChange(result : String)
}


class BookingBrain {
    
    //var sellerCoordinates : CLLocationCoordinate2D?
    var buyerCoordinates : CLLocationCoordinate2D?
    var buyerLatitude : String?
    var buyerLongitude : String?
    
    
    //its the current booking id, the most recent one , its value updated when we call insertBookingInformation and before that it will be null, , it may be null so be carefully while using it
    var currentBookingDocumentId : String?
    
    // to get seller defualt price
    var sellerProfileBrain = SellerProfileBrain()
    
    
    var bookingBrainDelegate : BookingBrainDelegate?
    
    static let sharedInstance = BookingBrain()
    
    var bookingInfoMap = [String:Any]()
    
    let db = Firestore.firestore()
    
    var buyerId : String?
    var sellerId : String?
    
    //its value will come from database
    var sellerPrice : String?
    
    //to prevent duplicate callling of a protocol function
    var check = true
    
    
    
    func insertBookingInfomationToFirebase(with bookingData : BookingModel) {
        
        guard let latitude = bookingData.eventLocation?.coordinates.latitude.description else {
            return
        }
        
        guard let longitude = bookingData.eventLocation?.coordinates.longitude.description  else {
            return
        }
        buyerId = bookingData.buyerId
        sellerId = bookingData.sellerId
        
        // dateForUniqueId = String(format: "%.1f", bookingData.dateForUniqueId)
        
        sellerProfileBrain.retrivingProfileDataForBooking(using: bookingData.sellerId) { (price) in
            self.sellerPrice = price
            self.addDataForBuyers(with: bookingData,latitude: latitude , longitude: longitude)
        }
        
        
        
        
    }
    
    
    func addDataForBuyers(with bookingData : BookingModel , latitude : String , longitude: String) {
        
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
        bookingInfoMap["totalSeonds"] = bookingData.timeOfOrder
        bookingInfoMap["bookingStatus"] = bookingData.bookingStatus
        bookingInfoMap["sellerLatitude"] = bookingData.sellerLatitude
        bookingInfoMap["sellerLongitude"] = bookingData.sellerLongitude
        bookingInfoMap["sellerAddress"] = bookingData.sellerLocationAddress
        bookingInfoMap["sellerPrice"] = sellerPrice
        
        //storing current document id
        currentBookingDocumentId = bookingData.dateForUniqueId
        buyerLatitude = latitude
        buyerLongitude = longitude
        
        db.collection("Bookings")
            .document("Buyer")
            .collection("AllBuyersWhoOrdered")
            .document(bookingData.buyerId)
            .collection("Books")
            .document(bookingData.sellerId)
            .collection("WithBookingID")
            .document(bookingData.dateForUniqueId)
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
                        .document(bookingData.dateForUniqueId)
                        .setData(bookingInfo, merge:true) { (error) in
                            
                            if let e = error
                            {
                                print(e.localizedDescription)
                            }
                            else
                            {
                                self.bookingBrainDelegate?.didSendTheBookingDetails()
                            }
                        }
                }
                
            }
        
        
        
    }
    
    
    func gettingSellerLocation(with buyerId : String , sellerId :String, completion :@escaping (String,String,String,String) -> ()) {
        db.collection("Bookings")
            .document("Buyer")
            .collection("AllBuyersWhoOrdered")
            .document(buyerId)
            .collection("Books")
            .document(sellerId)
            .collection("WithBookingID")
            .document(currentBookingDocumentId!)
            .getDocument { (snapShot, error) in
                
                if let snap = snapShot?.data()
                {
                    let sellerLatitude = snap["sellerLatitude"] as? String
                    let sellerLongitude = snap["sellerLongitude"] as? String
                    let sellerAddress = snap["sellerAddress"] as? String
                    let sellerPrice = snap["sellerPrice"] as? String
                    
                    completion(sellerLatitude!,sellerLongitude!,sellerAddress!,sellerPrice!)
                    
                    
                }
                else
                {
                    print("error while retriving sellerlocation : \(String(describing: error?.localizedDescription))")
                }
                
            }
        
    }
    
    
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
                print("how many times")
                if let q = query?.documents
                {
                    
                    if (q[0].data()["bookingStatus"] as? String)! == "accepted"
                    {
                        //the snapshot was provoking this line again and again so i put the condition to execute this
                        //command for once
                        if self.check == true
                        {
                            
                            self.bookingBrainDelegate?.didSellerRespond(result : "accepted")
                            self.check = false
                            print("yes, its happen")
                        }
                    }
                    else if (q[0].data()["bookingStatus"] as? String)! == "rejected"
                    {
                        if self.check == true
                        {
                            
                            self.bookingBrainDelegate?.didSellerRespond(result : "rejected")
                            self.check = false
                            print("noooooooooo")
                            
                        }
                    }
                    
                    
                }
            }
        
        
    }
    
    func updateAcknowledgeStatus(value status : String , completion :@escaping () -> ()) {
        self.db.collection("Bookings")
            .document("Seller")
            .collection("AllSellerWhoReceivedOrders")
            .document(sellerId!)
            .collection("BookedBy")
            .document(buyerId!)
            .collection("WithBookingID")
            .document(currentBookingDocumentId!)
            .collection("tracking")
            .document("TrackBooking")
            .setData(["acknowlegdeStatus" : status], completion: { (error) in
                if let e = error
                {
                    print("error occured while updating acknowledment  : \(e.localizedDescription)")
                }
                else
                {
                    self.db.collection("Bookings")
                        .document("Buyer")
                        .collection("AllBuyersWhoOrdered")
                        .document(self.buyerId!)
                        .collection("Books")
                        .document(self.sellerId!)
                        .collection("WithBookingID")
                        .document(self.currentBookingDocumentId!)
                        .collection("tracking")
                        .document("TrackBooking")
                        .setData(["acknowlegdeStatus" : status]) { (error) in
                            if let e = error
                            {
                                print("error occured while updating acknowledment  : \(e.localizedDescription)")
                            }
                            else
                            {
                                completion()
                            }
                        }
                }
            })

        
    }
    
    func acknowledgmentUpdated()  {
        print("why22")
        db.collection("Bookings")
            .document("Seller")
            .collection("AllSellerWhoReceivedOrders")
            .document(sellerId!)
            .collection("BookedBy")
            .document(buyerId!)
            .collection("WithBookingID")
            .document(currentBookingDocumentId!)
            .collection("tracking")
            .document("TrackBooking")
            .addSnapshotListener { (snapshot, error) in
                
                if let snap = snapshot?.data()
                {
                    print("why 1.5")
                    if (snap["acknowlegdeStatus"] as? String)! == "started"
                    {
                        print("why 2")
                        self.bookingBrainDelegate?.didAcknowledgementChange(result: "started")
                    }
                    else if (snap["acknowlegdeStatus"] as? String)! == "completed"
                    {
                        self.bookingBrainDelegate?.didAcknowledgementChange(result: "completed")

                    }

                    
                }
                else
                {
                    print("error while retriving acknowledment changes : \(String(describing: error))")
                }
            }
    }
    
    
}
