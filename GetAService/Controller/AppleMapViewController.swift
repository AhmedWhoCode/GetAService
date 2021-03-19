//
//  AppleMapViewController.swift
//  GetAService
//
//  Created by Geek on 16/03/2021.
//

import UIKit
import MapKit
import FloatingPanel

class AppleMapViewController: UIViewController , LocationProtocol {
   
    @IBOutlet var mapView: MKMapView!
    let panel = FloatingPanelController()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        if let contentVc = storyboard?.instantiateViewController(identifier:"test") as? SearchViewController
        {
            panel.set(contentViewController: contentVc)
            panel.addPanel(toParent:self)
            contentVc.locationDelegant = self

        }

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func didReceiveTheCoordinated(value coordinate: CLLocationCoordinate2D?) {
       mapView.removeAnnotations(mapView.annotations)
        panel.move(to: .tip, animated: true)
        if let c = coordinate
        {
            print("hello")
            let pin = MKPointAnnotation()
            pin.coordinate = c
            mapView.addAnnotation(pin)
            mapView.setRegion(
                MKCoordinateRegion(center: c,
                                span:MKCoordinateSpan(latitudeDelta: 1
                                                      ,longitudeDelta: 1)
            ),
        animated: true)
        }
                
    }

}
