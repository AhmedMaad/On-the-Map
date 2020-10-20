//
//  UdacityResponse.swift
//  On the Map
//
//  Created by Ahmed Maad on 10/20/20.
//  Copyright © 2020 Next Trend. All rights reserved.
//

import Foundation

struct UdacityResponse: Codable{
    
    let error: String
}

extension UdacityResponse: LocalizedError{
    var errorDescription: String?{
        return error
    }
}
