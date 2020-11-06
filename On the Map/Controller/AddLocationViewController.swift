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

class AddLocationViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var findLocationBtn: UIButton!
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Add location view controller loaded...")
        mapView.delegate = self
    }
    
    
    @IBAction func findLocation(_ sender: Any) {
        activityIndicator.isHidden = false
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
                    self.activityIndicator.isHidden = true
                    self.locationTextField.isHidden = true
                    self.linkTextField.isHidden = true
                    self.findLocationBtn.isHidden = true
                    //show map with btn
                    let topResult: CLPlacemark = (placemarks?[0])!
                    let placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                    self.latitude = (placemark.location?.coordinate.latitude)!
                    self.longitude = (placemark.location?.coordinate.longitude)!
                    print("Lat: ", self.latitude)
                    print("Lon: ", self.longitude)
                    self.showDataInMap()
                }
            }
        }
    }
    
    
    func showAlertDialog(title: String, message: String) {
        activityIndicator.isHidden = true
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    func showDataInMap(){
        mapView.isHidden = false
        finishBtn.isHidden = false
        //Markers
        var annotations = [MKPointAnnotation]()
        
        //show written location in pin
        let coordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        
        //Preparing the marker
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = locationTextField.text ?? ""
        annotations.append(annotation)
        
        // When the array is complete, we add the annotations to the map.
        self.mapView.addAnnotations(annotations)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    @IBAction func addLocation(_ sender: Any) {
        print("Should Add location")
        ParseAPIHandler.addStudentLocation(locationString: locationTextField.text ?? "", linkString: linkTextField.text ?? "", lat: self.latitude, lon: self.longitude, completion: addStudentLocationHandler(success:error:))
    }
    
    func addStudentLocationHandler(success: Bool, error: Error?){
        if success {
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
        else{
            DispatchQueue.main.async {
                self.showAlertDialog(title: "Error", message: error?.localizedDescription ?? "")
            }
            
        }
    }
    
}
