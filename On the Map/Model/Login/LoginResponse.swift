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
}


struct Session: Codable{
    let id: String
}
