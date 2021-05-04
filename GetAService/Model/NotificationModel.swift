//
//  Notifications.swift
//  GetAService
//
//  Created by Geek on 15/02/2021.
//

import UIKit

struct NotificationModel {
    var buyerImage : String
    var buyerName : String
    var buyerState : String
    var buyerUID : String
    var bookingStatus : String? = "not defined"

}

struct NotificationDetailModel {
    var serivceNeeded : String
    var eventTimeAndDate : String
    var eventlocationAddress : String
    var eventDescription : String
}

struct InfoToBeSend {
    var name : String
    var image : String
}
