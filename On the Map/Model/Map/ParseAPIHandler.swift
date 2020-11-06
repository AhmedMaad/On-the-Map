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
        case addStudentLocation
        
        var stringValue: String {
            switch self {
                
            case .studentLocation:
                return Endpoints.base + "?limit=100&order=-updatedAt"
            case .addStudentLocation:
                return Endpoints.base
                
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
                let parsedData = try JSONDecoder().decode(StudentInformation.self, from: data!)
                completion(parsedData.results, nil)
            }
            catch{
               print("Error after data returned in catch block")
                completion([], error)
            }
        }
        task.resume()
        
    }
    
    class func addStudentLocation(locationString: String, linkString: String, lat: Double, lon: Double, completion: @escaping (Bool, Error?) -> Void){
        var request = URLRequest(url: Endpoints.addStudentLocation.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = StudentData(firstName: "Candroid", lastName: "Kitkat", latitude:lat, longitude:lon, mapString: locationString, mediaURL:linkString)
        request.httpBody = try! JSONEncoder().encode(body)
        /*request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".data(using: .utf8)*/
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                //completion(false, error)
                let descriptiveError = try! JSONDecoder().decode(UdacityResponse.self, from: error as! Data)
                completion(false, descriptiveError)
                return
            }
            else{
                completion(true, nil)
            }
        }
        task.resume()
    }
    
}
