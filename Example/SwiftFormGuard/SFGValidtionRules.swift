//
//  SFGValidtionRules.swift
//  SwiftFormGuard
//
//  Created by Anurag Singh on 04/05/25.
//

import UIKit

final class SFGValidtionRules {
    
    static func validateNotRequired(_ value: String?) -> ValidationError? {
        return nil
    }
    
    static func validateRequired(_ value: String?) -> ValidationError? {
        guard let value = value?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty else {
            return ValidationError(message: SFGErrors.requierdField)
        }
        return nil
    }

    static func validateMaxLength(_ value: String?, limit: Int) -> ValidationError? {
        guard let value = value, value.count <= limit else {
            return ValidationError(message: SFGErrors.maxLength(limit: limit))
        }
        return nil
    }

    static func validateNumeric(_ value: String?) -> ValidationError? {
        guard let value = value, CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: value)) else {
            return ValidationError(message: SFGErrors.onlyNumricValues)
        }
        return nil
    }

    static func validateEmail(_ value: String?) -> ValidationError? {
        guard let value = value, value.isValidEmail() else {
            return ValidationError(message: SFGErrors.invalidEmailFormat)
        }
        return nil
    }
    
    static func validatePassword(_ value: String?) -> ValidationError? {
        guard let value = value, value.isValidPassword() else {
            return ValidationError(message: SFGErrors.invalidPasswordFormat)
        }
        return nil
    }
}


