//
//  DataController.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 6.12.20..
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

class DataController {
    // MARK: - Properties
    
    static var shared = DataController()
    var BASE_URL = "http://localhost:3000/"
    var session: URLSession
    
    private init () {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.waitsForConnectivity = true
        session = URLSession(configuration: config, delegate: nil, delegateQueue: .main)
    }
    
    // MARK: - Functions
    
    func executeRequest (endpoint: String,
                         httpMethod: HTTPMethod,
                         httpBody: Data? = nil,
                         completion: @escaping (Data?, Error?) -> Void) {
        
        let url = URL(string: BASE_URL + endpoint)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpBody = httpBody
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        let dataTask = DataController.shared.session.dataTask(with: urlRequest) { (data, response, error) in
            completion(data, error)
        }
        dataTask.resume()
    }
}
