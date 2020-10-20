//
//  UdacityAPIHandler.swift
//  On the Map
//
//  Created by Ahmed Maad on 10/20/20.
//  Copyright © 2020 Next Trend. All rights reserved.
//

import Foundation

class UdacityAPIHandler {
    
    struct Auth {
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1/session"

        case login
        
        var stringValue: String {
            switch self {
            case .login:
                return Endpoints.base
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    

    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void){
        
        var request = URLRequest(url: Endpoints.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //TODO: To be deleted
        let innerBody = LoginData(username: username, password: password)
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
                let descriptiveError = try! JSONDecoder().decode(UdacityResponse.self, from: error as! Data)
                completion(false, descriptiveError)
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
            
            do{
                let returnedData = try JSONDecoder().decode(LoginResponse.self, from: newData!)
                Auth.sessionId = returnedData.session.id
                print(returnedData.session.id)
                completion(true, nil)
            }
            catch{
                print("JSON Error: ", error.localizedDescription)
                let descriptiveError = try! JSONDecoder().decode(UdacityResponse.self, from: newData!)
                print("New Error Format: ", descriptiveError.errorDescription)
                completion(false, descriptiveError)
            }
        
    }
        task.resume()
    
}

}
