//
//  ChatsListTableViewController.swift
//  GetAService
//
//  Created by Geek on 30/01/2021.
//

import UIKit

class ChatList: UITableViewController {
    var chats = [Chats]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //hides back button of top navigation
        navigationItem.hidesBackButton = false
        addingDummyData()

        tableView.register(UINib(nibName:Constants.cellNibNameChatList, bundle: nil),forCellReuseIdentifier:Constants.cellIdentifierChatList)
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
        return chats.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Constants.cellIdentifierChatList, for: indexPath) as? ChatsTableViewCell
        cell?.chatImage.image = chats[indexPath.row].chatImage
        cell?.chatName.text = chats[indexPath.row].chatName
        cell?.chatCountry.text = chats[indexPath.row].chatCountry
        // Configure the cell...

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
    func addingDummyData() {
        let c1 = Chats(chatImage:UIImage.init(named: "male photo")!, chatName: "John", chatCountry: "USA")
        let c2 = Chats(chatImage:UIImage.init(named: "male photo")!, chatName: "anna", chatCountry: "Maxico")
        let c3 = Chats(chatImage:UIImage.init(named: "male photo")!, chatName: "hugh Jackman", chatCountry: "Newzeland")
        let c4 = Chats(chatImage:UIImage.init(named: "male photo")!, chatName: "tom lythan", chatCountry: "Brazil")
        let c5 = Chats(chatImage:UIImage.init(named: "male photo")!, chatName: "John", chatCountry: "USA")


        chats.append(c1)
        chats.append(c2)
        chats.append(c3)
        chats.append(c4)
        chats.append(c5)

    }

}
