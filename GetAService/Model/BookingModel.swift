//
//  NotificationBrain.swift
//  GetAService
//
//  Created by Geek on 18/03/2021.
//

import Foundation
import CoreLocation

struct LocationModel {
    var address : String
    var coordinates :  CLLocationCoordinate2D
}

struct BookingModel {
    var buyerId : String
    var sellerId : String
    var recepientName : String
    var servicesNeeded : String
    var phoneNumber  : String
    var eventTimeAndDate  : String
    var eventDescription : String
    var eventLocation  : LocationModel?
    var dateForUniqueId : Double
}
