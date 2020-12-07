//
//  User.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 7.12.20..
//

import Foundation

class User {
    var id: Int
    var username: String
    var password: String
    var role: Int
    
    init (_ dict: [String:Any] ){
        id = dict["id"] as! Int
        username = dict["username"] as! String
        password = dict["password"] as! String
        role = dict["role"] as! Int
    }
}
