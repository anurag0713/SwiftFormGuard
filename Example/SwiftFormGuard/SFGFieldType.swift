//
//  SFGFieldType.swift
//  SwiftFormGuard
//
//  Created by Anurag Singh on 04/05/25.
//

enum SFGFieldType {
    case email
    case password
    case name
    case age
    case gender
    case relationship
    case language
    case description
    case contactFrequency
    case expertise

    var key: String {
        switch self {
        case .email: return "email"
        case .password: return "password"
        case .name: return "name"
        case .age: return "age"
        case .gender: return "gender"
        case .relationship: return "relationship"
        case .language: return "language"
        case .description: return "description"
        case .contactFrequency: return "contact_frequency"
        case .expertise: return "expertise"
        }
    }

    var rules: [(String?) -> ValidationError?] {
        switch self {
        case .email:
            return [
                SFGValidtionRules.validateRequired,
                SFGValidtionRules.validateEmail
            ]
        case .name:
            return [
                SFGValidtionRules.validateRequired,
                { SFGValidtionRules.validateMaxLength($0, limit: 50) }
            ]
        case .age:
            return [
                SFGValidtionRules.validateNumeric,
                { SFGValidtionRules.validateMaxLength($0, limit: 2) }
            ]
        case .gender:
            return [
                { SFGValidtionRules.validateMaxLength($0, limit: 15) }
            ]
        case .relationship:
            return [
                { SFGValidtionRules.validateMaxLength($0, limit: 50) }
            ]
        case .language:
            return [
                { SFGValidtionRules.validateMaxLength($0, limit: 30) }
            ]
        case .description:
            return [
                { SFGValidtionRules.validateMaxLength($0, limit: 1000) }
            ]
        case .contactFrequency:
            return [
                SFGValidtionRules.validateNotRequired
            ]
        case .expertise:
            return [
                { SFGValidtionRules.validateMaxLength($0, limit: 50) }
            ]
        case .password:
            return [
                SFGValidtionRules.validatePassword
            ]
        }
    }
}
