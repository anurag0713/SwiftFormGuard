//
//  SFGValidtionRules.swift
//  SwiftFormGuard
//
//  Created by Anurag Singh on 04/05/25.
//
import UIKit

public protocol ValidationRule {
    func validate(_ value: String?) -> ValidationError?
}

public enum SFGRule {
    
    // MARK: - Built-in rules
    public struct NoValidationRequired: ValidationRule {
        public init() {}
        public func validate(_ value: String?) -> ValidationError? {
            return nil
        }
    }
    
    public struct RequiredField: ValidationRule {
        public init() {}
        public func validate(_ value: String?) -> ValidationError? {
            guard let value = value?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty else {
                return ValidationError(message: SFGErrors.requierdField)
            }
            return nil
        }
    }
    
    public struct MaxLength: ValidationRule {
        let limit: Int
        public init(limit: Int) {
            self.limit = limit
        }
        public func validate(_ value: String?) -> ValidationError? {
            guard let value = value, value.count <= limit else {
                return ValidationError(message: SFGErrors.maxLength(limit: limit))
            }
            return nil
        }
    }
    
    public struct IsNumeric: ValidationRule {
        public init() {}
        public func validate(_ value: String?) -> ValidationError? {
            guard let value = value, CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: value)) else {
                return ValidationError(message: SFGErrors.onlyNumricValues)
            }
            return nil
        }
    }
    
    public struct IsValidEmail: ValidationRule {
        public init() {}
        public func validate(_ value: String?) -> ValidationError? {
            guard let value = value, value.isValidEmail() else {
                return ValidationError(message: SFGErrors.invalidEmailFormat)
            }
            return nil
        }
    }
    
    public struct IsValidPassword: ValidationRule {
        private let regex: String
        
        public init(regex: String = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*(),.?\":{}|<>]).{8,}$") {
            self.regex = regex
        }
        
        public func validate(_ value: String?) -> ValidationError? {
            guard let value = value else {
                return ValidationError(message: SFGErrors.invalidPasswordFormat)
            }
            
            let regexValid = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: value)
            
            if !regexValid {
                return ValidationError(message: SFGErrors.invalidPasswordFormat)
            }
            return nil
        }
    }
}
