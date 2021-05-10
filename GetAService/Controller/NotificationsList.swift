//
//  NotificationsListTableViewController.swift
//  GetAService
//
//  Created by Geek on 26/01/2021.
//


import UIKit
import SkeletonView


class NotificationsList: UITableViewController {
    
    //MARK: - Local variables
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
        notificationBrain.notificationBrainDelegant = self
        
        notificationBrain.retrivingNotifications()
        settingTableAndSkeletonView()
        
    }
    
    //MARK: - Calling database functions
    
    //MARK: - Local functions
    func settingTableAndSkeletonView() {
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = false
        
        tableView.register(UINib(nibName:Constants.cellNibNameNotification, bundle: nil),forCellReuseIdentifier:Constants.cellIdentifierNotification)
        
        tableView.tableFooterView = UIView() //to hide extra lines
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .brown), animation: nil, transition: .crossDissolve(0.1))
    }
    
    //MARK: - Onclick functions
    
    //MARK: - Ovveriden functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.seguesNames.notificationsToOrderInfo
        {
            if let destinationSegue = segue.destination as? BuyerRequestScreen
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
            cell?.innerVIew.backgroundColor = .init(named: "notificationCell")
            cell?.button.backgroundColor = .init(named: "notificationCell")
            cell?.innerStack.backgroundColor = .init(named: "notificationCell")
            cell?.view.backgroundColor = .init(named: "notificationCell")
        }
        cell?.customerImage.loadCacheImage(with: notifications[indexPath.row].buyerImage )
        cell?.customerName.text = notifications[indexPath.row].buyerName
        cell?.customerCountry.text = notifications[indexPath.row].buyerState
        cell?.button.setTitle( notifications[indexPath.row].buyerUID , for: .normal)
        cell?.buttonDelegantNotification = self
        // cell2 = cell
        
        // adding value to dictionary , we will use it in didButtonpressedMethod
        let infoToBeSend = InfoToBeSend(name: notifications[indexPath.row].buyerName,
                                        image: notifications[indexPath.row].buyerImage
        )
        userInfoToBeSend[notifications[indexPath.row].buyerUID] = infoToBeSend
        
        return cell!
    }
    
    
}


//MARK: - Getting notifications
extension NotificationsList : NotificationBrainDelegate
{
    func didReceiveTheData(values: [NotificationModel]) {
        notifications = values
        tableView.reloadData()
        self.tableView.stopSkeletonAnimation()
        self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.001))
    }
    
    func didReceiveAnEmptyData(value: Bool) {
        if value
        {
            self.tableView.stopSkeletonAnimation()
            self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.001))
            showToast1(controller: self, message: "No notfications for now", seconds: 2, color: .red)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.navigationController?.popViewController(animated: true)
                
            }
        }
    }
    
}

//MARK: - To know when the cell clicked
extension NotificationsList : ButtonPressed
{
    
    func didButtonPressed(with value: String) {
        ERProgressHud.sharedInstance.show(withTitle: "Checking status please wait")
        //checking if the dictionary contain the key , if yes then take values from the dictionary and store in variables , these values will be sent to next screen.
        
        if userInfoToBeSend.keys.contains(value)
        {
            buyerName = userInfoToBeSend[value]?.name
            buyerImage = userInfoToBeSend[value]?.image
            buyerID = value
        }
        
        else
        {
            showToast1(controller: self, message: "Error while retriving values", seconds: 1, color: .red)
            return
        }
        
        //MARK: - Navigation to correct screen
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

//MARK: - SkeletonTableViewDataSource

extension NotificationsList : SkeletonTableViewDataSource
{
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return Constants.cellIdentifierNotification
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
}

