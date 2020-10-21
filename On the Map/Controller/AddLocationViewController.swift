//
//  AddLocationViewController.swift
//  On the Map
//
//  Created by Ahmed Maad on 10/21/20.
//  Copyright © 2020 Next Trend. All rights reserved.
//

import UIKit

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
        }
        
    }
    
    
    func showAlertDialog(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
}
