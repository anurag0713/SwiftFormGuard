// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

final class SwiftFormGuard {
    private var fields: [SFGFieldValidator] = []

    @MainActor func register(field: SFGInputField, type: SFGFieldType) {
        let validator = SFGFieldValidator(type: type, field: field)
        validator.addValidationRule()
        fields.append(validator)
    }

    @MainActor func validateAll() -> (isValid: Bool, values: [String: String]) {
        var isAllValid = true
        var results: [String: String] = [:]

        for validator in fields {
            let isValid = validator.validate()
            if !isValid {
                isAllValid = false
            } else if let value = validator.value() {
                results[validator.key] = value
            }
        }

        return (isAllValid, results)
    }
}
