//
//  OneToOneChatViewController.swift
//  GetAService
//
//  Created by Geek on 08/03/2021.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Firebase


class OneToOneChatViewController: MessagesViewController{
    //var currentUser : Sender!
    var messageType = [Message]()
    var currentUser :SenderType!
    var sender :SenderType!
    var senderID : String!
    var senderName : String!
    
    //var test : [MessageStructer]!
    
//    var messages = [Message]()
    
    var messageText : String!
    
    var messageBrian = MessageBrain()
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = Sender(senderId: Auth.auth().currentUser!.uid, displayName: "roy")
        sender = Sender(senderId: senderID, displayName: senderName)
        title = senderName
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messageBrian.retrivingMessagesFormFirebase(with : senderID) { (data) in
            print(data)
            //self.test = data
            self.showMessages(with : data)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func showMessages(with data : [MessageStructer]) {
        let dateFormatterUK = DateFormatter()
        dateFormatterUK.dateFormat = "dd-MM-yyyy"
        print(data[0].date)
        
        for i in 0...data.count - 1
        {
         
            if data[i].senderId == currentUser.senderId
            {
            messageType.append(Message(kind: .text(data[i].body), sender:currentUser, messageId: data[i].date, sentDate : Date.init(timeIntervalSinceReferenceDate: 11)))
            }
            else
            {
                messageType.append(Message(kind: .text(data[i].body), sender:sender, messageId: data[i].date, sentDate : Date.init(timeIntervalSinceReferenceDate: 11)))
            }
        }
        messagesCollectionView.reloadData()
        
        messagesCollectionView.scrollToBottom()
        
    }
    
//       func insertNewMessage(_ message: Message) {
//
//            messages.append(message)
//
//            messagesCollectionView.reloadData()
//
//            DispatchQueue.main.async {
//                self.messagesCollectionView.scrollToBottom(animated: true)
//            }
//        }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func sendData() {
        //let uuid = UUID().uuidString
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        let dateString = df.string(from: date)
        let message = MessageStructer(body: messageText,
                                      senderId: Auth.auth().currentUser!.uid,
                                      date: dateString,
                                      receiverId:sender.senderId
        )
        
        messageBrian.storeMessageToFireBase(with: message)
        {
            self.messagesCollectionView.reloadData()

            //self.showMessages(with: self.test)
             print("successful")
        }
        
    }
   
    
}

extension OneToOneChatViewController : MessagesDataSource,MessagesLayoutDelegate,MessagesDisplayDelegate , InputBarAccessoryViewDelegate

{
    func currentSender() -> SenderType {
      return  currentUser
        
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        messageType[indexPath.section]
        
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        messageType.count
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        messageText = text
        sendData()
       // var m = MessageStructer(body: text, senderId: senderID, date: "s")
        //fitest.append(m)
        //showMessages(with: test)
        inputBar.inputTextView.text = ""
        messagesCollectionView.scrollToBottom(animated: true)
        
    }
    
}
