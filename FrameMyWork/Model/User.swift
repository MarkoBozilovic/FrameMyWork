//
//  User.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 7.12.20..
//

import Foundation

enum UserRole {
    case admin
    case member
    case photographer
    case unknow
    
    init(role: Int) {
        switch role {
        case 0:
            self = .admin
        case 1:
            self = .member
        case 2:
            self = .photographer
        default:
            self = .unknow
        }
    }
}

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
