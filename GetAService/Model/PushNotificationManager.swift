//
//  PushNotificationManager.swift
//  GetAService
//
//  Created by Geek on 21/04/2021.
//

import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseMessaging
import UIKit
import UserNotifications

class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {
  

    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }

        UIApplication.shared.registerForRemoteNotifications()
        updateFirestorePushTokenIfNeeded()
    }

    func updateFirestorePushTokenIfNeeded() {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let sellerProfile = SellerProfileBrain()
        let buyerProfile =  BuyerProfileBrain()

        if let token = Messaging.messaging().fcmToken {
            
            isUserSellerOrBuyer(userID: userID) { (response) in
                
                if response == "seller"
                {
                    sellerProfile.addingTokenToProfile(with: token)
                }
                else if response == "buyer"
                {
                    buyerProfile.addingTokenToProfile(with: token)
                }
                
            }

        }
    }

//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//        print(remoteMessage.appData)
//    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
       //print("token",fcmToken)
        updateFirestorePushTokenIfNeeded()
    }
    
    

    //user response to the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("this is the response" , response)
    }
}
