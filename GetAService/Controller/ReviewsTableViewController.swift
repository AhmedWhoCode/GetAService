//
//  ReviewsTableViewController.swift
//  GetAService
//
//  Created by Geek on 29/03/2021.
//

import UIKit

class ReviewsTableViewController: UITableViewController {
//MARK: - Local variables
    var sellerId : String?
    var sellerProfileBrain = SellerProfileBrain()
    var reviewList  = [SellerRetrievalReviewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        tableView.register(UINib(nibName:Constants.reviewsTableViewCell, bundle: nil),forCellReuseIdentifier:Constants.reviewCell)
    }
    //MARK: - Calling database functions
    
    //MARK: - Local functions
    
    //MARK: - Onclick functions
    
    //MARK: - Ovveriden functions
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
        navigationItem.hidesBackButton = false
    }
    
    //MARK: - Misc functions
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reviewList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reviewCell, for: indexPath) as? ReviewsTableViewCell
        
        cell?.reviewTextView.text = reviewList[indexPath.row].comment
          
        settingStars(with: cell!, starCount: reviewList[indexPath.row].star)
        

        return cell!
    }

    func settingStars(with cell : ReviewsTableViewCell , starCount : String) {
        
        let count = Int(starCount)
        
        if count == 1
        {
            cell.oneStar.tintColor = .yellow
        }
        
        else if count == 2
        {
            cell.oneStar.tintColor = .yellow
            cell.twoStar.tintColor = .yellow

        }
        else if count == 3
        {
            cell.oneStar.tintColor = .yellow
            cell.twoStar.tintColor = .yellow
            cell.threeStar.tintColor = .yellow
        }
        else if count == 4
        {
            cell.oneStar.tintColor = .yellow
            cell.twoStar.tintColor = .yellow
            cell.threeStar.tintColor = .yellow
            cell.fourStar.tintColor = .yellow

        }
        else if count == 5
        {
            cell.oneStar.tintColor = .yellow
            cell.twoStar.tintColor = .yellow
            cell.threeStar.tintColor = .yellow
            cell.fourStar.tintColor = .yellow
            cell.fiveStar.tintColor = .yellow

        }
        
        
    }

}
