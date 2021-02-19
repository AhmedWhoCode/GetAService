//
//  Constants.swift
//  GetAService
//
//  Created by Geek on 02/02/2021.
//

import Foundation


struct Constants {
    
    //notificationlist constants
    static let cellIdentifierNotification = "notificationCell"
    static let cellNibNameNotification = "NotificationsTableViewCell"
    
    //artistList constants
    static let cellIdentifierArtistList = "artistInfoCell"
    static let cellNibNameArtistList = "ArtistListXibTableViewTableViewCell"

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
        
        static let userTypeToBuyer = "userTypeToBuyer"
        static let userTypeToSeller = "userTypeToSeller"
        static let loginToUserType = "loginToUserType"
        static let loginToServices = "loginToServices"
        static let servicesToArtists = "servicesToArtists"
        static let artistsToArtistsInfo = "artistsToArtistsInfo"
        static let artistInfoToConfirmBooking = "artistInfoToConfirmBooking"
        static let notificationsToOrderInfo = "notificationsToOrderInfo"

    }
    
}

