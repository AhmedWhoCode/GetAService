//
//  OneToOneChatViewController.swift
//  GetAService
//
//  Created by Geek on 08/03/2021.
//

import UIKit
import MessageKit

//struct Messages {
//    var senderId : String
//    var MessageKind : MessageType
//}

struct Message : MessageType{
    //var kind: MessageKind
    
    var kind: MessageKind
    
    var sender: SenderType
    
  //  var sender: Sender
    
    var messageId: String
    
    var sentDate: Date
    
    //var kind: MessageKind
    
//    var chatId : String
//    var sender : SenderType
//    var receiverId : String
//    var Message : String
//    var date : Date
}


//struct SenderT {
//    var senderId : String
//    va
//}
public struct Sender: SenderType {
    public let senderId: String
    public let displayName: String
}


class OneToOneChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    var currentUser : Sender!
    var messageType = [Message]()
    var sender :SenderType!
    var sender2 :SenderType!

    override func viewDidLoad() {
        super.viewDidLoad()
        sender = Sender(senderId: "dd", displayName: "roy")
        sender2 = Sender(senderId: "30330", displayName: "Kam")

        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        for _ in  0...20
        {
            
                messageType.append(Message(kind: .text("Hy"), sender: sender2, messageId: "enf", sentDate: Date.init(timeIntervalSince1970: 10000)))
        
        messageType.append(Message(kind: .text("Hy"), sender: sender, messageId: "enf", sentDate: Date.init(timeIntervalSince1970: 10000)))
        }
        messagesCollectionView.scrollToBottom()
//        messageType.append(
//            Message(chatId: "dj" , sender: sender, receiverId: "ssi", Message: "Hy", date:Date.init(timeIntervalSince1970: 10000))
//            )
//        messageType.append ( Message(chatId: "dj" , sender: sender, receiverId: "ssi", Message: "Hy", date:Date.init(timeIntervalSince1970: 10000))
//        )
//        messageType.append  (Message(chatId: "dj" , sender: sender, receiverId: "ssi", Message: "Hy", date:Date.init(timeIntervalSince1970: 10000))
//                    )
              
                           
        
        
        // Do any additional setup after loading the view.
    }
    func currentSender() -> SenderType {
        return sender2
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        messageType[indexPath.section]
        
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        messageType.count
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
