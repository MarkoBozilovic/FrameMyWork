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
    
    func toInt() -> Int {
      switch self {
      case .admin:
        return 2
      case .photographer:
        return 1
      case .member:
        return 0
      default:
        return -1
      }
    }
}

protocol UserProfile {
    var id: Int? { get set }
    var firstName: String { get set }
    var lastName: String { get set }
    var profileImage: String? { get set }
}

class User {
    // MARK: - Properties
    
    var id: Int?
    var username: String
    var password: String
    var role: UserRole
    var profile: UserProfile? = nil
    
    // MARK: - Init
    
    init (_ dict: [String:Any] ){
        id = dict["id"] as? Int
        username = dict["username"] as! String
        password = dict["password"] as! String
        let roleId = dict["role"] as! Int
        role = UserRole(role: roleId)
    }
    
    init(id: Int? = nil, username: String, password: String, role: Int, profile: UserProfile? = nil) {
        self.id = id
        self.username = username
        self.password = password
        self.role = UserRole(role: role)
    }
    
    // MARK: - Functions
    
    func convertToJson() -> Data {
        var jsonObject = [String:Any]()
        
        jsonObject["id"] = id
        jsonObject["username"] = username
        jsonObject["password"] = password
        jsonObject["role"] = role.toInt()
        
        if self.role == .member {
            jsonObject["memberId"] = Model.shared.user?.profile?.id
        } else if self.role == .photographer {
            jsonObject["photographerId"] = Model.shared.user?.profile?.id
        }
        
        return try! JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
    }
}
