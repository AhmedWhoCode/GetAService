//
//  ArtistListTableViewController.swift
//  GetAService
//
//  Created by Geek on 21/01/2021.
//

import UIKit
import SkeletonView

class SellerLists: UITableViewController {
    var sellerShortInfo = [SellerShortInfo]()
    
    var sellerProfileBrain = SellerProfileBrain()
    
    //service selected will be stored here
    var selectedService  : String!
    
    var selectedSellerId : String!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = false
        hidesBottomBarWhenPushed = true
        
        sellerProfileBrain.retrivingFilteredSellers(with: selectedService) { (data) in
            
            self.sellerShortInfo = data
            self.tableView.reloadData()
            self.tableView.stopSkeletonAnimation()
            self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.001))
        }
        //addingDummyData()
        
        
        
        tableView.register(UINib(nibName:Constants.cellNibNameSellerList, bundle: nil),forCellReuseIdentifier:Constants.cellIdentifierSellerList)
        tableView.tableFooterView = UIView()
        
        tableView.isSkeletonable = true
        //view.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .brown), animation: nil, transition: .crossDissolve(0.1))
        
        
    }
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
        navigationItem.hidesBackButton = false
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.seguesNames.sellersToSellerInfo
        {
            if let destinationSegue = segue.destination as? SellerInformation
            {
                destinationSegue.selectedSellerId = selectedSellerId!
            }
        }
    }
    
    //    func addingDummyData() {
    //        // adding dummy data
    //        let artist1 = SellerShortInfo(artistImage: UIImage.init(named: "artistPhoto")!, artistPrice: "$20", artistName: "Emma", artistCountry: "USA", artistAvalability: "Available")
    //
    //        let artist2 = SellerShortInfo(artistImage: UIImage.init(named: "artistPhoto")!, artistPrice: "$30", artistName: "Lina", artistCountry: "France", artistAvalability: "Available")
    //
    //        let artist3 = SellerShortInfo(artistImage: UIImage.init(named: "artistPhoto")!, artistPrice: "$40", artistName: "Alexandra", artistCountry: "France", artistAvalability: "Not Available")
    //
    //        let artist4 = SellerShortInfo(artistImage: UIImage.init(named: "artistPhoto")!, artistPrice: "$50", artistName: "Gal", artistCountry: "Sweden", artistAvalability: "Not Available")
    //
    //        aritsts.append(artist1)
    //        aritsts.append(artist2)
    //        aritsts.append(artist3)
    //        aritsts.append(artist4)
    //
    //    }
}

extension SellerLists: ButtonPressed
{
    func didButtonPressed(with value: String) {
        
        selectedSellerId = value
        performSegue(withIdentifier: Constants.seguesNames.sellersToSellerInfo, sender: nil)
        
    }
    
    
    
}

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
