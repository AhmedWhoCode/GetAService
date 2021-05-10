//
//  ListOfServicesTableViewController.swift
//  GetAService
//
//  Created by Geek on 20/01/2021.
//

import UIKit
import Firebase

class ListOfServices: UITableViewController, DataManipulation {
    
    //MARK: - Local variables
    var selectedService : String!
    var serviceBrain = ServicesBrain()
    var servicesData  = [ServicesModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BookingBrain.sharedInstance.check = true
        
        //registering this class so that it could receive data from data model
        serviceBrain.dataManipulationDelegant = self
        //calling method to retrieve data
        serviceBrain.retrivingServicesFromDatabase()
        
        
        //registering table view
        tableView.register(UINib(nibName:Constants.cellNibNameServicesList, bundle: nil),forCellReuseIdentifier:Constants.cellIdentifierServicesList)
        
    }
    
    //MARK: - Calling database functions
    
    func didReceiveData(with data: [ServicesModel]) {
        self.servicesData = data
        tableView.reloadData()
    }
    
    
    //MARK: - Local functions
    
    //MARK: - Onclick functions
    
    
    //MARK: - Ovveriden functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.seguesNames.servicesToSellers
        {
            if let destinationSegue = segue.destination as? SellerLists
            {
                destinationSegue.selectedService = selectedService!
            }
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        modifyingUi()
        //hidesBottomBarWhenPushed = false
        //navigationController?.hidesBottomBarWhenPushed = false
        let userDefault = UserDefaults.standard
        
        //checking if the service was started or not
        if userDefault.string(forKey: Constants.navigationInfo) == "started"
        {
            //setting global values
            if let sellerId = userDefault.string(forKey: Constants.sellerIdForNavigation)
            {
                BookingBrain.sharedInstance.sellerId = sellerId
            }
            
            if let notificationId = userDefault.string(forKey: Constants.notificationIdForNavigation)
            {
                BookingBrain.sharedInstance.currentBookingDocumentId = notificationId
            }
            
            if let buyerId = userDefault.string(forKey: Constants.buyerIdForNavigation)
            {
                BookingBrain.sharedInstance.buyerId = buyerId
            }
            performSegue(withIdentifier: Constants.seguesNames.servicesToStarted, sender: self)
            navigationItem.hidesBackButton = true
            hidesBottomBarWhenPushed = true
            
        }
    }
    
    
    //MARK: - Misc functions
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
    
    override func viewWillDisappear(_ animated: Bool) {
        hidesBottomBarWhenPushed = true
        navigationController?.hidesBottomBarWhenPushed = true
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
    
}




