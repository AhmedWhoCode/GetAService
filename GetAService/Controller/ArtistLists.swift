//
//  ArtistListTableViewController.swift
//  GetAService
//
//  Created by Geek on 21/01/2021.
//

import UIKit

class ArtistLists: UITableViewController {
    var aritsts = [Artists]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        addingDummyData()
        
        
    
        tableView.register(UINib(nibName:Constants.cellNibNameArtistList, bundle: nil),forCellReuseIdentifier:Constants.cellIdentifierArtistList)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func addingDummyData() {
        // adding dummy data
        let artist1 = Artists(artistImage: UIImage.init(named: "artistPhoto")!, artistPrice: "$20", artistName: "Emma", artistCountry: "USA", artistAvalability: "Available")
        
        let artist2 = Artists(artistImage: UIImage.init(named: "artistPhoto")!, artistPrice: "$30", artistName: "Lina", artistCountry: "France", artistAvalability: "Available")
        
        let artist3 = Artists(artistImage: UIImage.init(named: "artistPhoto")!, artistPrice: "$40", artistName: "Alexandra", artistCountry: "France", artistAvalability: "Not Available")
        
        let artist4 = Artists(artistImage: UIImage.init(named: "artistPhoto")!, artistPrice: "$50", artistName: "Gal", artistCountry: "Sweden", artistAvalability: "Not Available")
        
        aritsts.append(artist1)
        aritsts.append(artist2)
        aritsts.append(artist3)
        aritsts.append(artist4)
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return aritsts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Constants.cellIdentifierArtistList, for: indexPath) as? ArtistListXibTableViewTableViewCell

        cell?.artistImage.image = aritsts[indexPath.row].artistImage
        cell?.artistPriceLabel.text = aritsts[indexPath.row].artistPrice
        cell?.artistNameLabel.text = aritsts[indexPath.row].artistName
        cell?.artistCountryLabel.text = aritsts[indexPath.row].artistCountry
        cell?.artistAvailabilityLabel.text = aritsts[indexPath.row].artistAvalability

        
        
        cell?.artistButtonDelegant = self
        
        //closure to sense onclick
//        cell?.buttonClicked =
//            {
//                print(indexPath.row)
//            }
        // Configure the cell.

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

extension ArtistLists: ButtonPressed
{
    func didButtonPressed(with value: String) {
     print(value)
        performSegue(withIdentifier: Constants.seguesNames.artistsToArtistsInfo, sender: nil)
        
    }
    
    
    
}
