//
//  TabBarViewController.swift
//  On the Map
//
//  Created by Ahmed Maad on 10/20/20.
//  Copyright © 2020 Next Trend. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logout(_ sender: Any) {
        print("Should log out")
        UdacityAPIHandler.logout {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
