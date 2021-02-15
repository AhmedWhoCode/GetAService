//
//  ListOfServicesTableViewController.swift
//  GetAService
//
//  Created by Geek on 20/01/2021.
//

import UIKit
class ListOfServices: UITableViewController {
    
    var services = [Services]()

    override func viewDidLoad() {
        super.viewDidLoad()
        modifyingUi()
        
        let image = UIImage(named: "Nails")
        // adding dummy data
        let service1 = Services(serviceName: "Nails",serviceImage: image)
        let service2 = Services(serviceName: "Hairs",serviceImage: image)
        let service3 = Services(serviceName: "MakeUp",serviceImage: image)
        let service4 = Services(serviceName: "Pedicure",serviceImage: image)

        services.append(service1)
        services.append(service2)
        services.append(service3)
        services.append(service4)

        //registering table view
        tableView.register(UINib(nibName:Constants.cellNibNameServicesList, bundle: nil),forCellReuseIdentifier:Constants.cellIdentifierServicesList)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func modifyingUi()  {
        ///MARK: - enabling bottom toolbar
        navigationController?.isToolbarHidden = false
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = true
    }
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return services.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Constants.cellIdentifierServicesList, for: indexPath) as? ListOfServicesXibTableViewCell
        cell?.listButton.setTitle(services[indexPath.row].serviceName, for: .normal)
        cell?.listButton.setBackgroundImage(services[indexPath.row].serviceImage, for: .normal)

        //registering for the buttonPressed protocol
         cell?.buttonDelegantServices = self
        
//        cell?.buttonClicked =
//        {
//            print(indexPath)
//            self.performSegue(withIdentifier: Constants.seguesNames.servicesToArtists, sender: nil)
//
//
//        }
        
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
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }


}
//MARK: - its  an extention function to convert UIimage type to string
extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
   
}

//MARK: - will perform segue
extension ListOfServices:ButtonPressed
{
    // this function will be called whenever the button is pressed , so act accordingly
    func didButtonPressed(with value: String) {
        print(value)
        performSegue(withIdentifier: Constants.seguesNames.servicesToArtists, sender: nil)
}
    
}
    

