//
//  SearchViewController.swift
//  GetAService
//
//  Created by Geek on 16/03/2021.
//

import UIKit
import FloatingPanel
import CoreLocation




protocol LocationProtocol : AnyObject {
   
   func didReceiveTheCoordinated(value coordinate: CLLocationCoordinate2D?)
}


class SearchViewController: UIViewController, ButtonPressed2, UITextFieldDelegate  {
    
    

    @IBOutlet weak var enterLocation: UITextField!

    var location = [Location]()
     
    var coordinates  = [CLLocationCoordinate2D]()
    
    //this protocol is defined in buttonpressed file
    var locationDelegant:LocationProtocol?
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        enterLocation.delegate = self
        initializeHideKeyboard()
        tableView.register(UINib(nibName:"LocationTableViewCell", bundle: nil),forCellReuseIdentifier:"locationCell")
        // Do any additional setup after loading the view.
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let query = textField.text
        {
            LocationManager.shared.findLocation(with: query) { (address) in
                self.location = address
                self.tableView.reloadData()
                
            }
        }
    }
    
    func didButtonPressed(with value: UIButton) {
        print("ok")
        let value = coordinates[value.tag]
        print("check1   \(value)")
        locationDelegant?.didReceiveTheCoordinated(value: value)
        print("2")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return location.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as? LocationTableViewCell
        cell?.locationLabel.text = location[indexPath.row].title
        cell?.locationLabel.numberOfLines = 3
        coordinates.append(location[indexPath.row].coordinates!)
        cell?.button.tag = indexPath.row
        cell?.pressed = self
        return cell!
    }
    
    
}

