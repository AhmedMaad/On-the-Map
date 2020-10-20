//
//  LoginResponse.swift
//  On the Map
//
//  Created by Ahmed Maad on 10/20/20.
//  Copyright © 2020 Next Trend. All rights reserved.
//

import Foundation

struct LoginResponse: Codable{
    
    let session: Session
    
    enum CodingKeys: CodingKey{
        case session
    }
    
}


struct Session: Codable{
    let id: String
    
    enum CodingKeys: CodingKey{
        case id
    }
    
}
