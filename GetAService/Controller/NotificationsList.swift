//
//  NotificationsListTableViewController.swift
//  GetAService
//
//  Created by Geek on 26/01/2021.
//

import UIKit

class NotificationsList: UITableViewController, NotificationBrainDelegant {

    var notifications = [NotificationModel]()
    
    var notificationBrain = NotificationBrain()
    
    //to check the previuos class , to differentiate seller and buyer notifications
    var areSellerNotifications : Bool?
    
    var buyerID : String?
    var buyerImage : String?
    var buyerName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = false

        navigationItem.hidesBackButton = false
        notificationBrain.notificationBrainDelegant = self
        
        tableView.register(UINib(nibName:Constants.cellNibNameNotification, bundle: nil),forCellReuseIdentifier:Constants.cellIdentifierNotification)
        //addingDummyData()
       
        notificationBrain.retrivingNotifications()


    }
    
    func didReceiveTheData(values: [NotificationModel]) {
        notifications = values
        tableView.reloadData()
        print(values)
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
         buyerName = notifications[indexPath.row].buyerName
         buyerImage = notifications[indexPath.row].buyerImage
        cell?.customerImage.loadCacheImage(with: notifications[indexPath.row].buyerImage )
        cell?.customerName.text = notifications[indexPath.row].buyerName
        cell?.customerCountry.text = notifications[indexPath.row].buyerCountry
        cell?.button.setTitle( notifications[indexPath.row].buyerUID , for: .normal)
        cell?.buttonDelegantNotification = self
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
        
        buyerID = value
        
        print("idb \(value)")

        performSegue(withIdentifier: Constants.seguesNames.notificationsToOrderInfo, sender: nil)
    }

    
}
