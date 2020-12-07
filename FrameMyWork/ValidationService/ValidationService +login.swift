//
//  Validation +login.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 6.12.20..
//

import Foundation

// MARK: - Enums

enum LoginValidationError: LocalizedError {
    case invalidInput
    case usernameTooShort
    case usernameTooLong
    case passwordTooLong
    case passwordTooShort
    
    var errorDescription: String? {
        switch self {
        case .usernameTooLong:
            return ""
        case .usernameTooShort:
            return ""
        case .passwordTooLong:
            return ""
        case .passwordTooShort:
            return ""
        case .invalidInput:
            return ""
        }
    }
}

class Validation {
    // MARK: - Functions
    
    func checkUsername(username: String) throws -> String? {
        
        
    }
}
