//
//  Model.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 11.12.20..
//

import Foundation

class Model {
    // MARK: - Properties
    static var shared = Model()
    var user: User?
    var schedules: [Schedule]?
    
    // MARK: - Init
    private init () {}
}
