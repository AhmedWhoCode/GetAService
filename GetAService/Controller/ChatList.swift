//
//  ChatsListTableViewController.swift
//  GetAService
//
//  Created by Geek on 30/01/2021.
//

import UIKit
import FirebaseAuth
import Firebase
import SkeletonView

class ChatList: UITableViewController, ChatBrainDelegate {
    
    func didReceiveTheData(values: [ChatModel]) {
        self.chatList = values
        self.tableView.stopSkeletonAnimation()
        self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.001))
        self.tableView.reloadData()
        
    }
    
    // var chats = [Chats]()
    var chatBrain = ChatBrain()
    
    var currentUser = Auth.auth().currentUser?.uid
    
    //payload to send to messages contains the info of pressed user
    var userId : String!
    var userName : String!
    var userImage : String!
    
    var chatList = [ChatModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatBrain.chatBrainDelegant = self
        retrivingChats()
    
        
        
        tableView.register(UINib(nibName:Constants.cellNibNameChatList, bundle: nil),forCellReuseIdentifier:Constants.cellIdentifierChatList)
        tableView.tableFooterView = UIView()
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .brown), animation: nil, transition: .crossDissolve(0.1))
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hidesBottomBarWhenPushed = false
        //navigationController?.hidesBottomBarWhenPushed = false
    }
    
    
    func retrivingChats() {
        
        chatBrain.retrivingChatsFromDatabase { (data) in
            
            //after getting all chats id now we are getting info of those ids
            self.chatBrain.gettingUserInfo(with: data)
            
            
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chatList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Constants.cellIdentifierChatList, for: indexPath) as? ChatsTableViewCell
        
        //userImage = chatList[indexPath.row].image
        cell?.chatImage.loadCacheImage(with: chatList[indexPath.row].image)
        cell?.chatName.text = chatList[indexPath.row].name
        cell?.chatCountry.text = chatList[indexPath.row].state
        // Configure the cell...
        
        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userId = chatList[indexPath.row].userId
        userName = chatList[indexPath.row].name
        userImage = chatList[indexPath.row].image
        BookingBrain.sharedInstance.sellerTokenId = chatList[indexPath.row].tokenId
        performSegue(withIdentifier: Constants.seguesNames.chatsToMessages , sender: self)
        //tableView.cellForRow(at: indexPath)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.seguesNames.chatsToMessages
        {
            if let destinationSegue = segue.destination as? OneToOneChatViewController
            {
                destinationSegue.otherUserID = userId
                destinationSegue.otherUserName = userName
                destinationSegue.otherUserImage = userImage
            }
        }
        
    }
    
    
}
extension ChatList : SkeletonTableViewDataSource
{
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return Constants.cellIdentifierChatList
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 6
    }
}
