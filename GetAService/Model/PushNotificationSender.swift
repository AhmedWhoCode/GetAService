//
//  PushNotificationSender.swift
//  GetAService
//
//  Created by Geek on 21/04/2021.
//

//AAAA0vBv_rQ:APA91bHYaXtm5tyo3ad1DJw6gGv7l4y6ujG46-9F-L2aIr6sFJs1SFpiFfse4SQZT8kdsh3Hb2fyGrKfq7lwJn2SYQ4SRdXtEoQxAv8Nj4w8rooZEqugsb2YypboAZPfaDQq1Ma0EH5z
import UIKit
class PushNotificationSender {
    func sendPushNotification(to token: String, title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title, "body" : body,"sound": "default",                    "badge": 1],
                                           "priority" : "high",
                                           "data" : ["user" : "test_id"]
                                           
        ]
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAA0vBv_rQ:APA91bHYaXtm5tyo3ad1DJw6gGv7l4y6ujG46-9F-L2aIr6sFJs1SFpiFfse4SQZT8kdsh3Hb2fyGrKfq7lwJn2SYQ4SRdXtEoQxAv8Nj4w8rooZEqugsb2YypboAZPfaDQq1Ma0EH5z", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}
