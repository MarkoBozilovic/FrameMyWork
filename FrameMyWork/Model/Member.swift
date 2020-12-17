//
//  Member.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 11.12.20..
//

import Foundation

class Member: UserProfile {
    //MARK: - Properties
    
    var id: Int
    var firstName: String
    var lastName: String
    var profileImage: String
    
    //MARK: - Init
    
    init (_ dict: [String:Any]) {
        id = dict["id"] as! Int
        firstName = dict["firstName"] as! String
        lastName = dict["lastName"] as! String
        profileImage = dict["profileImage"] as! String
    }
}
