//
//  Schedule.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 13.1.21..
//

import Foundation

class Schedule {
    // MARK: - Properties
    
    let id: Int?
    let date: Date
    let memberId: Int
    let photographerId: Int
    let title: String
    let details: String
    
    // MARK: - Init
    
    init(dict: [String:Any]) {
        self.id = dict["id"] as? Int
        self.memberId = dict["memberId"] as! Int
        self.photographerId = dict["photographerId"] as! Int
        self.title = dict["title"] as! String
        self.details = dict["details"] as! String
        
        let dateStr = dict["date"] as! String
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "d.MM.yy"
        self.date = dateFormater.date(from: dateStr)!
        
    }
    
    init(id: Int? = nil,
         date: Date,
         memberId: Int,
         photographerId: Int,
         title: String,
         details: String) {
        
        self.id = id
        self.date = date
        self.memberId = memberId
        self.photographerId = photographerId
        self.title = title
        self.details = details
    }
}
