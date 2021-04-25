//
//  SubServicesTableViewController.swift
//  GetAService
//
//  Created by Geek on 17/02/2021.
//

import UIKit

class SubServicesTableViewController: UITableViewController {
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    //all sub services
    var subServices = [String]()
    //selected subservices
    var selectedServices = [String]()
    //main service choosen by the user in previous screen
    var mainService:String!
    
    //to check if the cell is checked or not , when you scroll the  table view the selection repeats
    var cellChecked = [Bool]()
    
    var servicesBrain = ServicesBrain()
    
    var sellerProfileBrain = SellerProfileBrain()
    
    var selectedServiceFromFirebase = [String]()
    
    //map to store selected services with price
    
    var selectedSubServicesWithPrice = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = false
        
        
        showData()
        
        tableView.tableFooterView = UIView()
        
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        // to pervent duplicate data , converting array to set and back to array. set only contains unique values
        let selectedServices1 = Array(Set(self.selectedServices))
        
        if selectedServices1.count > 0 && selectedServices1.count <= 6
        {
            sellerProfileBrain.storeSubServivesToFirebase(with: selectedServices1,withPrice: selectedSubServicesWithPrice) {
                showToast1(controller: self, message: "Data saved", seconds: 1,color: UIColor.green)
                
            }
        }
        else if selectedServices1.count > 6
        {
            showToast1(controller: self, message: "Kindly select only 6 services", seconds: 1,color: UIColor.red)
            
        }
        else
        {
            showToast1(controller: self, message: "No service selected", seconds: 1, color: UIColor.red)
        }
    }
    
    
    
    
    
    func showData() {
        // getting the selected services of user
        self.servicesBrain.retrieveSelectedSubservices { (data) in
            
            self.selectedServiceFromFirebase = data
        
            self.servicesBrain.retrieveSelectedSubservicesWithPrice { (data2) in
                // firebase is returning all the subservices ever selected because of obvious reason , so here im filtering the subservice  . only the current selected service will be shown
                self.refiningPrice(with: data , priceFromDatabase: data2)
                
            }
        }
        
       
        
        //calling function to retrieve data also passing a closure to get the response
        servicesBrain.retrivingSubServicesFromDatabase(with: mainService) { (data) in
            self.subServices = data
            //number of items in tableview
            self.cellChecked = Array(repeating: false, count: self.subServices.count)
            self.tableView.reloadData()
        }
        
    }
    
    func refiningPrice(with selectedSubservice : [String] , priceFromDatabase:[String:String])  {
        // firebase is returning all the subservices ever selected because of obvious reason , so here im filtering the subservice  . only the current selected service will be
        if selectedSubservice.count > 0
        {
            for subserviceAsAKey in selectedSubservice
            {
                
                if let price =  priceFromDatabase[subserviceAsAKey]
                {
                    self.selectedSubServicesWithPrice[subserviceAsAKey] = price
                }
            }
            tableView.reloadData()
            print("updated price" , self.selectedSubServicesWithPrice )
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.subServicesCell, for: indexPath) as? SubServicesTableViewCell
        
        
        //checking if the cell is clicked or not,when you scroll the  table view the selection repeats
        cell!.accessoryType = cellChecked[indexPath.row] ? UITableViewCell.AccessoryType.checkmark : UITableViewCell.AccessoryType.none
        
        cell!.name.text = subServices[indexPath.row]
        
        restoreTheLastState(cell: cell! , indexPathRow: indexPath.row)
                
        return cell!
    }
    
    func restoreTheLastState (cell: SubServicesTableViewCell , indexPathRow :Int) {
        // showing the saved status , marking the saved service when the table view loads.
        if let t = cell.name.text
        {
            if selectedServiceFromFirebase.count > 0
            {
                if selectedServiceFromFirebase.contains(t)
                {
                    cell.accessoryType = UITableViewCell.AccessoryType.checkmark
                    selectedServices.append(t)
                    //selecting the cell too
                    let index = NSIndexPath(row: indexPathRow, section: 0)
                    tableView.selectRow(at: index as IndexPath, animated: true, scrollPosition:.none)
                    print("these are the  rows" , indexPathRow)
                    
                }
                
            }
            
            if let price = selectedSubServicesWithPrice[t]
            {
                cell.price.isHidden = false
                cell.price.text = price
            }
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //deselec
        let cell = tableView.cellForRow(at: indexPath) as? SubServicesTableViewCell
        
//        if  cell!.accessoryType == UITableViewCell.AccessoryType.checkmark
//        {
//            if selectedSubServicesWithPrice[cell!.name.text!] != nil
//            {
//                print("will be removed")
//                selectedSubServicesWithPrice.removeValue(forKey: cell!.name.text!)
//                print("her",selectedSubServicesWithPrice)
//            }
//
//            cellChecked[indexPath.row] = false
//            //if a user deselect the cell , the price label will hide
//            cell?.price.isHidden = true
//
//            cell?.price.text = "$0"
//
//            cell!.accessoryType = UITableViewCell.AccessoryType.none
//            //removing the deselected subservice form array
//            selectedServices.removeAll { $0 == cell!.name.text!}
//            print("her2", selectedServices)
//        }
        
//        else
//          {
        //showing input dialog , this method is defined in the helper folder , extention file
        showInputDialog(viewController: self, title: "Enter the service price", subtitle: "Default price is $1", actionTitle: "add", cancelTitle: "defualt", inputPlaceholder: "enter here", inputKeyboardType: .numberPad) { (action) in
            //if the user pressed the default , defualt price of $1 will be set
            cell?.price.isHidden = false
            cell?.price.text = "$1"
            self.selectedSubServicesWithPrice[(cell?.name.text)!] = cell?.price.text
        } actionHandler: { (price) in
            //else the price entered by user will be set
            cell?.price.isHidden = false
            cell?.price.text = "$\(price ?? "0")"
            self.selectedSubServicesWithPrice[(cell?.name.text)!] = cell?.price.text
            
        }
          
        
        
        cellChecked[indexPath.row] = true
        cell!.accessoryType = UITableViewCell.AccessoryType.checkmark
        //adding selected subservice in an array
        if !selectedServices.contains((cell!.name.text)!)
        {
        selectedServices.append((cell!.name.text)!)
        }
          //}
    }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? SubServicesTableViewCell

        if selectedSubServicesWithPrice[cell!.name.text!] != nil
        {
            print("will be removed")
            selectedSubServicesWithPrice.removeValue(forKey: cell!.name.text!)
            print("her",selectedSubServicesWithPrice)
        }

        cellChecked[indexPath.row] = false
        //if a user deselect the cell , the price label will hide
        cell?.price.isHidden = true

        cell?.price.text = "$0"

        cell!.accessoryType = UITableViewCell.AccessoryType.none
        //removing the deselected subservice form array
        selectedServices.removeAll { $0 == cell!.name.text!}
        //print(selectedServices)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.seguesNames.subServicesToProfile
        {
            if let destinationSegue = segue.destination as? SellerProfile
            {
                destinationSegue.isSourceVcArtistProfile = true
            }
        }
        
    }
    
}



// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation




//    func showToast(controller: UIViewController, message : String, seconds: Double,color :UIColor) {
//        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//        alert.view.backgroundColor = color
//        alert.view.alpha = 0.6
//        alert.view.layer.cornerRadius = 15
//
//        controller.present(alert, animated: true)
//
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
//            alert.dismiss(animated: true)
//
//        }
//
//    }
