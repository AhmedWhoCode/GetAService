//
//  PortfolioImagesUITableViewController.swift
//  GetAService
//
//  Created by Geek on 17/04/2021.
//

import UIKit
import YPImagePicker
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Firebase
import PhotosUI

class PortfolioImagesUITableViewController: UITableViewController {
    
    var selectedImages = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName:Constants.portfolioImagesTableViewCell, bundle: nil),forCellReuseIdentifier:Constants.portfolioCell)
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hidesBottomBarWhenPushed = true
        
    }
    
    @IBAction func addImages(_ sender: UIBarButtonItem) {
        
        
        selectedImages.removeAll()
        var config = YPImagePickerConfiguration()
        config.library.defaultMultipleSelection  = true
        config.library.maxNumberOfItems = 8
        config.library.mediaType = YPlibraryMediaType.photo
        
        let picker = YPImagePicker(configuration: config)
        
        
        present(picker, animated: true, completion: nil)
        
        picker.didFinishPicking { [unowned picker] items, cancelled in
            
            picker.dismiss(animated: true, completion: nil)
            
            for item in items {
                
                switch item {
                case .photo(let item):
                    self.selectedImages.append(item.originalImage)
                default:
                    print("wont happen")
                }
                
            }
            
            self.tableView.reloadData()
        }
        
    }
    // MARK: - Table view data source
    
    //        override func numberOfSections(in tableView: UITableView) -> Int {
    //            // #warning Incomplete implementation, return the number of sections
    //            return 1
    //        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return selectedImages.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.portfolioCell, for: indexPath) as? PortfolioImagesTableViewCell
      
        
        cell?.portfolioImage.image = selectedImages[indexPath.row]
        
        
        // Configure the cell...
        
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

//extension PortfolioImagesUITableViewController : PHPickerViewControllerDelegate
//{
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        picker.dismiss(animated: true, completion: nil)
//        for result in results {
////                print(result.assetIdentifier)
////                print(result.itemProvider)
//
//                result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
////                    print(object)
////                    print(error)
//                    if let image = object as? UIImage {
//
//                            //let imv = self.newImageView(image: image)
//                            self.selectedImages.append(image)
//                        if self.selectedImages.count == results.count
//                        {
//                            DispatchQueue.main.async {
//
//                            print("cc",self.selectedImages.count)
//                            self.tableView.reloadData()
//                            }
//                        }
//                           // self.scrollView.addSubview(imv)
//                            //self.view.setNeedsLayout()
//
//                    }
//                })
//
//            }
//
//
//    }
//
//
//}


//        var config = PHPickerConfiguration()
//                config.selectionLimit = 3
//                config.filter = PHPickerFilter.images
//
//                let pickerViewController = PHPickerViewController(configuration: config)
//                pickerViewController.delegate = self
//                self.present(pickerViewController, animated: true, completion: nil)
