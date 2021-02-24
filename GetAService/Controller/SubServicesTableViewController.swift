//
//  SubServicesTableViewController.swift
//  GetAService
//
//  Created by Geek on 17/02/2021.
//

import UIKit

class SubServicesTableViewController: UITableViewController {
    @IBOutlet weak var submitButton: UIButton!
    //all sub services
    var subServices = [String]()
    //selected subservices
    var selectedServices = [String]()
    //main service choosen by the user in previous screen
    var mainService:String!
    //to check if the cell is checked or not , when you scroll the  table view the selection repeats
    var cellChecked = [Bool]()
    
    var servicesBrain = ServicesBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showData()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.subServicesCell)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    func showData() {
        
        submitButton.layer.cornerRadius = 20
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        
        //calling function to retrieve data also passing a closure to get the response
        servicesBrain.retrivingSubServicesFromDatabase(with: mainService) { (data) in
            
            self.subServices = data
            //number of items in tableview
            self.cellChecked = Array(repeating: false, count: self.subServices.count)
            self.tableView.reloadData()
        }
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subServices.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.subServicesCell, for: indexPath) as UITableViewCell
        //checking if the cell is clicked or not
        
        cell.accessoryType = cellChecked[indexPath.row] ? UITableViewCell.AccessoryType.checkmark : UITableViewCell.AccessoryType.none
        cell.textLabel?.text = subServices[indexPath.row]
        
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cellChecked[indexPath.row] = true
        cell!.accessoryType = UITableViewCell.AccessoryType.checkmark
        //adding selected subservice in an array
        selectedServices.append((cell?.textLabel?.text!)!)
        print(selectedServices)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cellChecked[indexPath.row] = false
        
        cell!.accessoryType = UITableViewCell.AccessoryType.none
        //removing the deselected subservice form array
        selectedServices.removeAll { $0 == cell?.textLabel?.text!}
        print(selectedServices)
        
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        if selectedServices.count > 0
        {
            //addSubser
        }
        
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
