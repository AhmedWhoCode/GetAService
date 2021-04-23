//
//  NotificationsListTableViewController.swift
//  GetAService
//
//  Created by Geek on 26/01/2021.
//

struct InfoToBeSend {
    var name : String
    var image : String
}

import UIKit

class NotificationsList: UITableViewController, NotificationBrainDelegate {
    
    var notifications = [NotificationModel]()
    
    var notificationBrain = NotificationBrain()
    
    //to check the previuos class , to differentiate seller and buyer notifications
    var areSellerNotifications : Bool?
    
    var buyerID : String?
    var buyerImage : String?
    var buyerName : String?
    
    var userInfoToBeSend = [String:InfoToBeSend]()
    
    var cell2 : NotificationsTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationBrain.retrivingNotifications()
        ERProgressHud.sharedInstance.show()

        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = false
        
        navigationItem.hidesBackButton = false
        notificationBrain.notificationBrainDelegant = self
        
        tableView.register(UINib(nibName:Constants.cellNibNameNotification, bundle: nil),forCellReuseIdentifier:Constants.cellIdentifierNotification)
        
        //to hide extra line
         tableView.tableFooterView = UIView()

        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //ERProgressHud.sharedInstance.show()

    }
    
    func didReceiveTheData(values: [NotificationModel]) {
        notifications = values
        ERProgressHud.sharedInstance.hide()

        tableView.reloadData()
        print("yarr",values)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notifications.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifierNotification, for: indexPath) as? NotificationsTableViewCell
      
        if notifications[indexPath.row].bookingStatus == "unSeen"
        {
            cell?.innerVIew.backgroundColor = .systemBlue
            cell?.button.backgroundColor = .systemBlue
        }
        cell?.customerImage.loadCacheImage(with: notifications[indexPath.row].buyerImage )
        cell?.customerName.text = notifications[indexPath.row].buyerName
        cell?.customerCountry.text = notifications[indexPath.row].buyerCountry
        cell?.button.setTitle( notifications[indexPath.row].buyerUID , for: .normal)
        //buyerName = notifications[indexPath.row].buyerName
        //buyerImage = notifications[indexPath.row].buyerImage
        cell?.buttonDelegantNotification = self
        cell2 = cell
        
        // adding value to dictionary
       
            let infoToBeSend = InfoToBeSend(name: notifications[indexPath.row].buyerName,
                                            image: notifications[indexPath.row].buyerImage
                                            )
            userInfoToBeSend[notifications[indexPath.row].buyerUID] = infoToBeSend
        
        
        

        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.seguesNames.notificationsToOrderInfo
        {
            if let destinationSegue = segue.destination as? CustomerRequestScreen
            {
                
                guard let buyerID = buyerID else {return}
                guard let buyerImage = buyerImage else {return}
                guard let buyerName = buyerName else {return}
                
                print("this is iddd" , buyerID)
                
                destinationSegue.buyerName = buyerName
                destinationSegue.buyerImage = buyerImage
                destinationSegue.buyerID = buyerID
            }
        }
    }
    
}
extension NotificationsList : ButtonPressed
{
    func didButtonPressed(with value: String) {
        ERProgressHud.sharedInstance.show(withTitle: "Checking status please wait")

        if userInfoToBeSend.keys.contains(value)
        {
            buyerName = userInfoToBeSend[value]?.name
            buyerImage = userInfoToBeSend[value]?.image
            buyerID = value
        }
        else
        {
            showToast1(controller: self, message: "Error while retriving values", seconds: 1, color: .red)
        }
                
        
        notificationBrain.navigateToCorrectScreen(with: buyerID!) { (response) in
            ERProgressHud.sharedInstance.hide()
            print("hey here " , response)
            if response == "started"
            {
                
                self.performSegue(withIdentifier: Constants.seguesNames.notificationsToStarted, sender: nil)
            }
             else if response == "completed"
            {
                showToast1(controller: self, message: "The service was completed", seconds: 1, color: .red)
            }
             else if response == "rejected"
            {
                showToast1(controller: self, message: "The service was rejected", seconds: 1, color: .red)
            }
             
            else
            {
                self.performSegue(withIdentifier: Constants.seguesNames.notificationsToOrderInfo, sender: nil)
                
            }
        }
        
    }
    
    
}
