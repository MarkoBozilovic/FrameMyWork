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
                completion: @escaping (Bool) -> Void) {
        
        let endpoint = "users?username=\(username)&password=\(password)"
        executeRequest(endpoint: endpoint,
                       httpMethod: .get) { (data, error) in
            
            guard error == nil else { return completion(false) }
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String:Any]]
                guard jsonData.count > 0 else { return completion(false) }
                let jsonDict = jsonData.first!
                let user = User(jsonDict)
                Model.shared.user = user
                
                var endpoint = ""
                switch user.role {
                case .member:
                    let id = jsonDict["memberId"] as! Int
                    endpoint = "members/?id=\(id)"
                case .photographer:
                    let id = jsonDict["photographerId"] as! Int
                    endpoint = "photographers/?id=\(id)"
                default:
                    DispatchQueue.main.async {
                        completion(true)
                    }
                }
                self.getProfile(endpoint: endpoint,
                                userRole: user.role) { (profile) in
                    if profile != nil {
                        DispatchQueue.main.async {
                            Model.shared.user?.profile = profile
                            completion(true)
                        }
                    }
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    func getProfile (endpoint: String,
                     userRole: UserRole,
                     completion: @escaping (UserProfile?) -> Void) {
        
        executeRequest(endpoint: endpoint, httpMethod: .get) { (data, error) in
            guard error == nil else { return completion(nil) }
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String:Any]]
                guard jsonData.count > 0 else { return completion(nil) }
                let jsonDict = jsonData.first!
                
                switch userRole {
                case .member:
                    let profile = Member(jsonDict)
                    completion(profile)
                case .photographer:
                    let profile = Photographer(jsonDict)
                    completion(profile)
                default:
                    assertionFailure("getProfile() error")
                }
            }
            catch {
                completion(nil)
            }
        }
    }
    // MARK: - Registration
    
    func registerUser (user: User,
                       completion: @escaping (Bool) -> Void) {
        Model.shared.user = user
        
        saveProfile(user.profile!, role: user.role) { (success) in
            guard success else { return completion(false) }
            self.executeRequest(endpoint: "users",
                           httpMethod: .post,
                           httpBody: user.convertToJson()) { (data, error) in
                guard error == nil else { return completion(false) }
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!,
                    options: .allowFragments) as! [String: Any]
                    user.id = jsonData["id"] as? Int
                    DispatchQueue.main.async {
                        completion(true)
                    }
                } catch {
                    assertionFailure("registerUser() error: data error")
                }
            }
        }
    }
    
    func saveProfile(_ profile: UserProfile,
                     role: UserRole,
                     completion: @escaping (Bool) -> Void) {
        
        let endpoint = role == .member ? "members" : "photographers"
        executeRequest(endpoint: endpoint,
                       httpMethod: .post,
                       httpBody: profile.convertToJson()) { (data, error) in
            guard error == nil else { return completion(false) }
            let jsonData = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
            profile.id = jsonData["id"] as? Int
            completion(true)
        }
    }
    
    func getSchedules() {
        let endpoint = "schedules"
        
        executeRequest(endpoint: endpoint,
                       httpMethod: .get) { (data, error) in
            guard error == nil else { return }
            let jsonData = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String:Any]]
            
            let schedules = jsonData.map{ Schedule(dict: $0) }
            Model.shared.schedules = schedules
            print(schedules)
        }
        
    }
    
    func getMember(by id: Int, completion: @escaping (Member?) -> Void) {
        let endpoint = "members/?id=\(id)"
        
        executeRequest(endpoint: endpoint,
                       httpMethod: .get) { (data, error) in
            guard error == nil else { return completion(nil) }
            let jsonData = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String:Any]]
            if let dict = jsonData.first {
                let member = Member(dict)
                completion(member)
            }
            completion(nil)
        }
    }
}
