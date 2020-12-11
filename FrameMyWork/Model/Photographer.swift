//
//  Photographer.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 11.12.20..
//

import Foundation

class Photographer: UserProfile {
    //MARK: - Properties
    
    var id: Int
    var firstName: String
    var lastName: String
    var profileImage: String
    var sheduleId: Int
    var albumId: Int
    var rating: Int
    
    //MARK: - Init
    
    init (dict: [String:Any]) {
        id = dict["id"] as! Int
        firstName = dict["firstName"] as! String
        lastName = dict["lastName"] as! String
        profileImage = dict["profileImage"] as! String
        sheduleId = dict["sheduleId"] as! Int
        albumId = dict["albumId"] as! Int
        rating = dict["rating"] as! Int
    }
}
