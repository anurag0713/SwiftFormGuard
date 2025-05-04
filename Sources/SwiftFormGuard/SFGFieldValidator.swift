//
//  SFGFieldValidator.swift
//  SwiftFormGuard
//
//  Created by Anurag Singh on 04/05/25.
//

final class SFGFieldValidator {
    let field: SFGInputField
    let type: SFGFieldType

    init(type: SFGFieldType, field: SFGInputField) {
        self.type = type
        self.field = field
    }
    
    @MainActor func addValidationRule() {
        self.field.validator = { [weak self] text in
            guard let self = self else { return nil }
            for rule in type.rules {
                if let error = rule(text) {
                    return error.message
                }
            }
            return nil
        }
    }

    @MainActor func validate() -> Bool {
        let text = field.getText()
        for rule in type.rules {
            if let error = rule(text) {
                field.showError(error.message)
                return false
            }
        }
        field.hideError()
        return true
    }

    @MainActor func value() -> String? {
        return field.getText()?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var key: String {
        return type.key
    }
}
