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
    //Type of message structer supported by messagekit
    var messageType = [Message]()
    
    //storing current user and other user
    var currentUser :SenderType!
    var sender :SenderType!
    
    // getting value and name of other user from previous class
    var otherUserID : String!
    var otherUserName : String!
    var otherUserImage : String!
    
    //message typed by the user
    var messageText : String!
    
    var messageBrian = MessageBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting up current user
        currentUser = Sender(senderId: Auth.auth().currentUser!.uid, displayName: "roy")
        //setting other user
        sender = Sender(senderId: otherUserID, displayName: otherUserName)
        //title of navbar
        title = otherUserName
        
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        //calling function to retrive messages with other user using senderID
        messageBrian.retrivingMessagesFormFirebase(with : otherUserID) { (data) in
            //data contains all the message
            self.showMessages(with : data)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    //showing messages received from database
    func showMessages(with data : [MessageStructer]) {
        //formatting date
        let dateFormatterUK = DateFormatter()
        dateFormatterUK.dateFormat = "dd-MM-yyyy"
        
        for i in 0...data.count - 1
        {
            
            //if the message sender id is of current user then make sender as current user , it is used to make conversation left and right
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    //sending data on pressing send
    func sendData() {
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
        
        inputBar.inputTextView.text = ""
        messagesCollectionView.scrollToBottom(animated: true)
        
    }
    
    //adding images to chats
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        if message.sender.senderId == otherUserID
        {
            if let image = otherUserImage
            {
                avatarView.loadCacheImage(with: image)
            }
        }
        else
        {
            avatarView.image = #imageLiteral(resourceName: "profile")
            
        }
        
        
    }
    
}
