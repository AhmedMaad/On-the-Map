//
//  ViewController.swift
//  On the Map
//
//  Created by Ahmed Maad on 10/19/20.
//  Copyright © 2020 Next Trend. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func login(_ sender: Any) {
        UdacityAPIHandler.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLoginResponse(success:error:))
    }
    
    @IBAction func signup(_ sender: Any) {
        if let url = URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com") {
            UIApplication.shared.open(url)
        }
    }
    
    func handleLoginResponse(success: Bool, error: Error?){
        if success {
            print("Login success...")
            DispatchQueue.main.async {
                let navVC = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
                self.present(navVC, animated:true, completion:nil)
            }
        }
        else{
            print("Login Failure...")
            DispatchQueue.main.async {
               self.showLoginFailure(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
}

