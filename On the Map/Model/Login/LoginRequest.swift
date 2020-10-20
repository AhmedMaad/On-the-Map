//
//  LoginRequest.swift
//  On the Map
//
//  Created by Ahmed Maad on 10/20/20.
//  Copyright © 2020 Next Trend. All rights reserved.
//

import Foundation

struct LoginRequest: Codable{
    let udacity: LoginData
}

struct LoginData: Codable{
    let username: String
    let password: String
}
