//
//  ParseAPIHandler.swift
//  On the Map
//
//  Created by Ahmed Maad on 10/20/20.
//  Copyright © 2020 Next Trend. All rights reserved.
//

import Foundation

class ParseAPIHandler {
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1/StudentLocation"
        
        case studentLocation
        
        var stringValue: String {
            switch self {
                
            case .studentLocation:
                return Endpoints.base + "?limit=100&order=-updatedAt"
            
                
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void){
        
        var request = URLRequest(url: Endpoints.studentLocation.url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Error getting students")
                completion(false, error)
                return
            }
            
            
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
        
    }
    
}
