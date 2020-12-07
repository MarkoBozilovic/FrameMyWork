//
//  Validation +login.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 6.12.20..
//

import Foundation

// MARK: - Enums

enum LoginValidationError: LocalizedError {
    case invalidValue
    case usernameTooShort
    case usernameTooLong
    case passwordTooLong
    case passwordTooShort
    case incorrectCredentials
    
    var errorDescription: String? {
        switch self {
        case .usernameTooLong:
            return "Your username is too long."
        case .usernameTooShort:
            return "Your username is too short."
        case .passwordTooLong:
            return "Your password is too long."
        case .passwordTooShort:
            return "Your password is too short."
        case .invalidValue:
            return "Please enter your informations."
        case .incorrectCredentials:
            return "Invalid username and/or password"
        }
    }
}

class ValidationService {
    // MARK: - Functions
    
    static func validateUsername (username: String?) throws -> String {
        let username = username!
        guard username.count != 0 else { throw LoginValidationError.invalidValue }
        guard username.count >= 3 else { throw LoginValidationError.usernameTooShort }
        guard username.count < 20 else { throw LoginValidationError.usernameTooLong }
        return username
    }
    
    static func validatePassword (password: String?) throws -> String {
        let password = password!
        guard password.count != 0 else { throw LoginValidationError.invalidValue }
        guard password.count >= 5 else { throw LoginValidationError.passwordTooShort }
        guard password.count < 20 else { throw LoginValidationError.passwordTooLong }
        return password
    }
    
    static func generateErrorMessage (for error: LoginValidationError) -> String {
        return error.errorDescription!
    }
}
