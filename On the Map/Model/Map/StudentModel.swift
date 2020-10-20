//
//  StudentModel.swift
//  On the Map
//
//  Created by Ahmed Maad on 10/20/20.
//  Copyright © 2020 Next Trend. All rights reserved.
//

import Foundation

struct StudentModel: Codable {

    let results: [StudentData]
    
    enum CodingKeys: String, CodingKey{
        case results
    }
    
}


struct StudentData: Codable {
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case latitude
        case longitude
        case mapString
        case mediaURL
    }
    
}
