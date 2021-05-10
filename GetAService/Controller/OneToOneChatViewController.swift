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
    //MARK: - local variable
    //Type of message structer supported by messagekit
    var messageType = [Message]()
    var messageBrian = MessageBrain()
    //storing current user and other user
    var currentUser :SenderType!
    var sender :SenderType!
    // getting value and name of other user from previous class
    var otherUserID : String!
    var otherUserName : String!
    var otherUserImage : String!
    //message typed by the user
    var messageText : String!
    var currentUserImage : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up current user
        currentUser = Sender(senderId: Auth.auth().currentUser!.uid, displayName: "")
        
        //setting other user
        sender = Sender(senderId: otherUserID, displayName: otherUserName ?? "")
        
        title = otherUserName      //title of navbar
        settingUpMessageKitView()
        
        //retriving current user image form firebase
        messageBrian.gettingCurrentUserImage(with: currentUser.senderId) { (imageInString) in
            self.currentUserImage = imageInString
            self.messagesCollectionView.reloadData()

        }
        
        //calling function to retrive messages with other user using senderID
        messageBrian.retrivingMessagesFormFirebase(with : otherUserID) { (data) in
            //data contains all the message
            self.showMessages(with : data)
        }
        
        
        // Do any additional setup after loading the view.
    }
    //MARK: - Calling database functions
    
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
            let sender = PushNotificationSender()
            guard let token = BookingBrain.sharedInstance.sellerTokenId else
            {
                showToast1(controller: self, message: "couldnot send the notification", seconds: 1, color: .alizarin)
                return
                
            }
            
            sender.sendPushNotification(to: token, title: "You have a message", body: "kindly open an app")
            self.messagesCollectionView.reloadData()
            
        }
        
    }
    
    //MARK: - Local functions
    
    func settingUpMessageKitView() {
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.backgroundColor = .init(named: "screenBackgroundDark")
        messageInputBar.contentView.backgroundColor = .init(named: "screenBackgroundDark")
        messageInputBar.backgroundView.backgroundColor = .init(named: "screenBackgroundDark")
        messageInputBar.sendButton.tintColor = .init(named: "screenBackgroundDark")
        messageInputBar.sendButton.setTitleColor(UIColor.init(named: "paragraphTextColor"), for: .normal)
    }
    
    //MARK: - Onclick functions
    
    //MARK: - Ovveriden functions
    
    //MARK: - Misc functions
    
    
    
    
}

//MARK: - Meesage kit extentions

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
            if let image = currentUserImage
            {
                avatarView.loadCacheImage(with: image)
            }
            
        }
        
        
    }
    
}
