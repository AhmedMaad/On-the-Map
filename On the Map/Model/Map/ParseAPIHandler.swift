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
    
    
    class func getStudentLocation(completion: @escaping ([StudentData], Error?) -> Void){
        
        let request = URLRequest(url: Endpoints.studentLocation.url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Error getting students")
                completion([], error)
                return
            }
            do{
                let parsedData = try JSONDecoder().decode(StudentModel.self, from: data!)
                print("Parsed student name data: " , parsedData.results)
                completion(parsedData.results, nil)
            }
            catch{
               print("Error after data returned in catch block")
                completion([], error)
            }
            
            //print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
        
    }
    
}
