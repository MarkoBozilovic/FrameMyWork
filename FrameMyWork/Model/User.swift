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
        case 2:
            self = .admin
        case 0:
            self = .member
        case 1:
            self = .photographer
        default:
            self = .unknow
        }
    }
}

protocol UserProfile {
    var id: Int { get }
    var firstName: String { get }
    var lastName: String { get }
    var profileImage: String { get }
}

class User {
    // MARK: - Properties
    
    var id: Int
    var username: String
    var password: String
    var role: UserRole
    var profile: UserProfile? = nil
    
    // MARK: - Init
    
    init (_ dict: [String:Any] ){
        id = dict["id"] as! Int
        username = dict["username"] as! String
        password = dict["password"] as! String
        let roleId = dict["role"] as! Int
        role = UserRole(role: roleId)
    }
}
