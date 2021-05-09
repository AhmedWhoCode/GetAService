//
//  EnlargedImageViewController.swift
//  GetAService
//
//  Created by Geek on 08/05/2021.
//

import UIKit

class EnlargedImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var image : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let i = image else {
            return
        }
        imageView.loadCacheImage(with: i)
        // Do any additional setup after loading the view.
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
