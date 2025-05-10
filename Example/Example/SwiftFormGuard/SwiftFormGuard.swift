// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public class SwiftFormGuard {
    private var fields: [SFGFieldValidator] = []
    
    @MainActor
    func register(field: SFGInputField, key: String, rules: [SFGValidationRule]) {
        let validator = SFGFieldValidator(field: field, key: key, rules: rules)
        validator.addValidationRule()
        fields.append(validator)
    }
    
    @MainActor
    func validateAll() -> (isValid: Bool, values: [String: Any]) {
        var isAllValid = true
        var results: [String: Any] = [:]
        
        for validator in fields {
            let isValid = validator.validate()
            isAllValid = isAllValid && isValid
            
            if isValid, let value = validator.value() {
                results[validator.key] = value
            }
        }
        return (isAllValid, results)
    }
}
