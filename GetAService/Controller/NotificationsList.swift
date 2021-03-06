//
//  NotificationsListTableViewController.swift
//  GetAService
//
//  Created by Geek on 26/01/2021.
//

import UIKit

class NotificationsList: UITableViewController {

    var notifications = [Notifications]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
         addingDummyData()
        
        tableView.register(UINib(nibName:Constants.cellNibNameNotification, bundle: nil),forCellReuseIdentifier:Constants.cellIdentifierNotification)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        cell?.customerImage.image = notifications[indexPath.row].customerImage
        cell?.customerName.text = notifications[indexPath.row].customerName
        cell?.customerCountry.text = notifications[indexPath.row].customerCountry

        cell?.buttonDelegantNotification = self
        return cell!
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension NotificationsList : ButtonPressed
{
    func didButtonPressed(with value: String) {
        performSegue(withIdentifier: Constants.seguesNames.notificationsToOrderInfo, sender: nil)
        print(value)
    }

    
    func addingDummyData() {
        let n1 = Notifications(customerImage:UIImage.init(named: "male photo")!, customerName: "John", customerCountry: "USA")
        let n2 = Notifications(customerImage:UIImage.init(named: "male photo")!, customerName: "TOM", customerCountry: "UK")
        let n3 = Notifications(customerImage:UIImage.init(named: "male photo")!, customerName: "Ravi", customerCountry: "India")
        let n4 = Notifications(customerImage:UIImage.init(named: "male photo")!, customerName: "Alexo", customerCountry: "Mexico")
        let n5 = Notifications(customerImage:UIImage.init(named: "male photo")!, customerName: "Tom Banton", customerCountry: "Swizerland")

        notifications.append(n1)
        notifications.append(n2)
        notifications.append(n3)
        notifications.append(n4)
        notifications.append(n5)

    }
    
}
