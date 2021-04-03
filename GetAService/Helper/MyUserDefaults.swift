//
//  MyUserDefaults.swift
//  GetAService
//
//  Created by Geek on 02/04/2021.
//

import Foundation



class MyUserDefaults {
    let userDefault = UserDefaults.standard

   static let sharedInstance =  MyUserDefaults()
    
    func settingUpUserDefaultValues(with status : String) {
        //setting up user defaults
        userDefault.set("started", forKey: Constants.navigationInfo)
        userDefault.set(BookingBrain.sharedInstance.sellerId, forKey: Constants.sellerIdForNavigation)
        userDefault.set(BookingBrain.sharedInstance.buyerId, forKey: Constants.buyerIdForNavigation)
        userDefault.set(BookingBrain.sharedInstance.currentBookingDocumentId, forKey: Constants.notificationIdForNavigation)
        userDefault.set(status, forKey: Constants.navigationInfo)
    }
    
   func updatingNavigationStatus(with status:String)
    {
        userDefault.set(status, forKey: Constants.navigationInfo)
        
    }
}

