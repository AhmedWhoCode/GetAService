//
//  ArtistListTableViewController.swift
//  GetAService
//
//  Created by Geek on 21/01/2021.
//

import UIKit
import SkeletonView

class SellerLists: UITableViewController {
    //MARK: - Local variables
    var sellerShortInfo = [SellerShortInfo]()
    var sellerProfileBrain = SellerProfileBrain()
    //these values are coming from previous screen
    var selectedService  : String!//service selected will be stored here
    var selectedSellerId : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = false
        hidesBottomBarWhenPushed = true
        
        retrivingFilteredSellers()
        settingTableViewAndSkeleton()
        
        
    }
    //MARK: - Calling database functions
    
    func retrivingFilteredSellers()
    {
        sellerProfileBrain.retrivingFilteredSellers(with: selectedService) { (data) in
            
            self.sellerShortInfo = data
            self.tableView.reloadData()
            self.tableView.stopSkeletonAnimation()
            self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.001))
        }
    }
    
    //MARK: - Local functions
    
    func settingTableViewAndSkeleton() {
        tableView.register(UINib(nibName:Constants.cellNibNameSellerList, bundle: nil),forCellReuseIdentifier:Constants.cellIdentifierSellerList)
        
        tableView.tableFooterView = UIView()
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .brown), animation: nil, transition: .crossDissolve(0.1))
    }
    
    //MARK: - Onclick functions
    
    //MARK: - Ovveriden functions
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
        navigationItem.hidesBackButton = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.seguesNames.sellersToSellerInfo
        {
            if let destinationSegue = segue.destination as? SellerInformation
            {
                destinationSegue.selectedSellerId = selectedSellerId!
            }
        }
    }
    
    
    
    //MARK: - Misc functions
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sellerShortInfo.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:Constants.cellIdentifierSellerList, for: indexPath) as? SellerListXibTableViewTableViewCell
        
        
        let sellerImagesRef :String? = sellerShortInfo[indexPath.row].image
        
        cell?.sellerPriceLabel.text = "$\(sellerShortInfo[indexPath.row].price)"
        cell?.sellerNameLabel.text = sellerShortInfo[indexPath.row].name
        let sellerLocation = "\(sellerShortInfo[indexPath.row].state),\(sellerShortInfo[indexPath.row].city)"
        cell?.sellerCountryLabel.text = sellerLocation
        cell?.sellerAvailabilityLabel.text = sellerShortInfo[indexPath.row].availability
        cell?.sellerInfoButton.setTitle(sellerShortInfo[indexPath.row].uid, for: .normal)
        if let image = sellerImagesRef
        {
            cell?.sellerImage.loadCacheImage(with: image)
        }
        
        if sellerShortInfo[indexPath.row].status == Constants.online
        {
            cell?.onlineStatusImage.backgroundColor = .green
        }
        else
        {
            cell?.onlineStatusImage.backgroundColor = .gray
        }
        
        cell?.artistButtonDelegant = self
        
        
        return cell!
    }
    
    
    
}

//MARK: - inform when the  cell pressed
extension SellerLists: ButtonPressed
{
    func didButtonPressed(with value: String) {
        
        selectedSellerId = value
        performSegue(withIdentifier: Constants.seguesNames.sellersToSellerInfo, sender: nil)
        
    }
    
    
    
}

//MARK: - SkeletonTableViewDataSource

extension SellerLists : SkeletonTableViewDataSource
{
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return Constants.cellIdentifierSellerList
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 6
    }
}
