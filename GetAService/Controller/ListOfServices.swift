//
//  ListOfServicesTableViewController.swift
//  GetAService
//
//  Created by Geek on 20/01/2021.
//

import UIKit
import Firebase

class ListOfServices: UITableViewController, DataManipulation {
    
    var selectedService : String!
    //var services = [ServicesModel]()
    var serviceBrain = ServicesBrain()
    var servicesData  = [ServicesModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //registering this class so that it could receive data from data model
        serviceBrain.dataManipulationDelegant = self
        //calling method to retrieve data
        serviceBrain.retrivingServicesFromDatabase()
        
        modifyingUi()
        
        //registering table view
        tableView.register(UINib(nibName:Constants.cellNibNameServicesList, bundle: nil),forCellReuseIdentifier:Constants.cellIdentifierServicesList)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    ///MARK: - will be called when firebase returns data 
    func didReceiveData(with data: [ServicesModel]) {
        self.servicesData = data
        tableView.reloadData()
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
        return servicesData.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Constants.cellIdentifierServicesList, for: indexPath) as? ListOfServicesXibTableViewCell
        
        //cell?.listButton.setTitle(servicesData[indexPath.row].serviceName, for: .normal)
        cell?.serviceName.text = servicesData[indexPath.row].serviceName
        
//        let serviceName = servicesData[indexPath.row].serviceName
        let servicesImagesRef = servicesData[indexPath.row].serviceImage
        cell?.imageForService.image = UIImage(named: "servicesimageplaceholder")
        cell?.listButton.text(servicesData[indexPath.row].serviceName)
        
        if let imageRef  = servicesImagesRef{
            
            cell?.imageForService.loadCacheImage(with: imageRef)
            
        }
        
        
        //registering for the buttonPressed protocol
        cell?.buttonDelegantServices = self
        return cell!
        
    }
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        logoutUser()
    }
    
    func logoutUser() {
        // call from any screen
        
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}
//MARK: - will perform segue
extension ListOfServices:ButtonPressed
{
    // this function will be called whenever the button is pressed , so act accordingly
    func didButtonPressed(with value: String) {
        selectedService = value
        //print(selectedService!)
        performSegue(withIdentifier: Constants.seguesNames.servicesToSellers, sender: nil)
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
    
    
    
     //MARK: - Navigation
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == Constants.seguesNames.servicesToSellers
            {
                if let destinationSegue = segue.destination as? SellerLists
              {
                    destinationSegue.selectedService = selectedService!
              }
            }
            
        }
    
    
}
////MARK: - its  an extention function to convert UIimage type to string
//extension UIImage {
//    func toString() -> String? {
//        let data: Data? = self.pngData()
//        return data?.base64EncodedString(options: .endLineWithLineFeed)
//    }
//
//}




