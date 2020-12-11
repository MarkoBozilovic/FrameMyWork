//
//  DataController +user.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 6.12.20..
//

import Foundation

extension DataController {
    // MARK: - Functions
    
    func login (username: String,
                password: String,
                completion: @escaping (User?) -> Void) {
        
        let endpoint = "users?username=\(username)&password=\(password)"
        executeRequest(endpoint: endpoint,
                       httpMethod: .get) { (data, error) in
            
            guard error == nil else { return completion(nil) }
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String:Any]]
                guard jsonData.count > 0 else { return completion(nil) }
                let user = jsonData.first.map { User($0) }!
                Model.shared.user = user
                completion(user)
            }
            catch {
                completion(nil)
            }
        }
    }
}
