//
//  Constants.swift
//  GetAService
//
//  Created by Geek on 02/02/2021.
//

import Foundation


struct Constants {
    
    static let orderAccepted = "accepted"
    static let orderRejected = "rejected"
    static let online = "online"
    static let offline = "offline"
    
    //notificationlist constants
    static let cellIdentifierNotification = "notificationCell"
    static let cellNibNameNotification = "NotificationsTableViewCell"
    
    //artistList constants
    static let cellIdentifierSellerList = "sellerInfoCell"
    static let cellNibNameSellerList = "SellerListXibTableViewTableViewCell"
    
    //servicesList constants
    static let cellIdentifierServicesList = "serviceXib"
    static let cellNibNameServicesList = "ListOfServicesXibTableViewCell"
    
    //servicesList constants
    static let cellIdentifierChatList = "chatsCell"
    static let cellNibNameChatList = "ChatsTableViewCell"
    
    //SubServicesList
    
    static let subServicesCell = "subServicesCell"
    
    struct gifNames {
        static let inProgressGif = "inProgress.gif"
        static let greenCheckGif = "myGreenGif.gif"
    }
    
    struct seguesNames {
        
        static let informationToMaps = "informationToMaps"
        static let chatsToMessages = "chatsToMessages"
        static let sellerInfoToMessages = "sellerInfoToMessages"
        static let sellerDashboardToProfile = "sellerDashboardToProfile"
        static let sellerDashboardToNotification = "sellerDashboardToNotification"
        static let subServicesToProfile = "subServicesToProfile"
        static let sellerProfileToDashboard = "sellerProfileToDashboard"
        static let sellerProfileToUserType = "sellerProfileToUserType"
        static let userTypeToBuyer = "userTypeToBuyer"
        static let userTypeToSeller = "userTypeToSeller"
        static let loginToUserType = "loginToUserType"
        static let loginToServices = "loginToServices"
        static let servicesToSellers = "servicesToSellers"
        static let sellersToSellerInfo = "sellersToSellerInfo"
        static let sellerInfoToInformation = "sellerInfoToInformation"
        static let notificationsToOrderInfo = "notificationsToOrderInfo"
        static let profileToLogin = "profileToLogin"
        static let loginToSellerProfile = "loginToSellerProfile"
        static let profileToSubservices = "profileToSubservices"
        static let artistInfoToProfile = "artistInfoToProfile"
        static let buyerProfileToServices = "buyerProfileToServices"
        static let locationToWaiting = "locationToWaiting"
        static let waitingToUberInfo = "waitingToUberInfo"
        static let waitingToServices = "waitingToServices"
        static let orderInfoToMaps = "orderInfoToMaps"
        static let mapsToSellerWaiting = "mapsToSellerWaiting"
        static let serviceStartedToCompleted = "serviceStartedToCompleted"
        static let sellerWaitingToMeetup = "sellerWaitingToMeetup"
        static let locationInfoToStarted = "locationInfoToStarted"
    }
    
}

