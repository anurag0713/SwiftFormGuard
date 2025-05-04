//
//  SFGErrors.swift
//  SwiftFormGuard
//
//  Created by Anurag Singh on 04/05/25.
//

enum SFGErrors {
    static let requierdField = "This field is required."
    static let invalidEmailFormat = "Invalid email format."
    static let invalidPasswordFormat = "Password must be 8+ characters, with uppercase, lowercase, number, and special character."
    static let confirmPasswordNotMatch = "Confirm password does not match."
    static let onlyNumricValues = "Only numeric values are allowed."
    
    static func maxLength(limit: Int) -> String {
        return "Must be less than or equal to \(limit) characters."
    }
}
