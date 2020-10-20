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
        emailTextField.text = "atef.ahmed1341@gmail.com"
        passwordTextField.text = "TheMeditator1!"
    }
    
    
    @IBAction func login(_ sender: Any) {
        
        UdacityAPIHandler.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLoginResponse(success:error:))
        
        
        /*var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //TODO: To be deleted
        let innerBody = LoginData(username: "", password: "")
        let body = LoginRequest(udacity: innerBody)
        do{
            request.httpBody = try JSONEncoder().encode(body)
        }
        catch{
            print("Error")
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
            
            do{
                let returnedData = try JSONDecoder().decode(LoginResponse.self, from: newData!)
                print(returnedData.session.id)
            }
            catch{
                print(error.localizedDescription)
            }
            
            
        }
        task.resume()*/
    }
    
    @IBAction func signup(_ sender: Any) {
        if let url = URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com") {
            UIApplication.shared.open(url)
        }
    }
    
    func handleLoginResponse(success: Bool, error: Error?){
        if success {
            //make ur segue
            print("Login success...")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "TabBarController", sender: nil)
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

