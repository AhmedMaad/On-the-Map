//
//  AddLocationViewController.swift
//  On the Map
//
//  Created by Ahmed Maad on 10/21/20.
//  Copyright © 2020 Next Trend. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class AddLocationViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var linkTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Add location view controller loaded...")
    }
    
    
    @IBAction func findLocation(_ sender: Any) {
        if linkTextField.text == "" || locationTextField.text == "" {
            showAlertDialog(title: "Missing required fields", message: "You should not leave any field empty")
        }
        else{
            //forward written string geocode
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(locationTextField.text ?? "") { (placemarks, error) in
                if (placemarks?.count == 0 || error != nil){
                    self.showAlertDialog(title: "No Address Found", message: "Please write a valid address")
                }
                else{
                    let topResult: CLPlacemark = (placemarks?[0])!
                    let placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                    let lat = (placemark.location?.coordinate.latitude)!
                    let lon = (placemark.location?.coordinate.longitude)!
                    print("Lat: ", lat)
                    print("Lon: ", lon)
                    //Send lat lon to final map view with submit button
                    }
            }
        }
        
    }
    
    
    func showAlertDialog(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
}
