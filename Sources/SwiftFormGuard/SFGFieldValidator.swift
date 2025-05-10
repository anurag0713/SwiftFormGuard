//
//  SFGFieldValidator.swift
//  SwiftFormGuard
//
//  Created by Anurag Singh on 04/05/25.
//

final class SFGFieldValidator {
    let field: SFGInputField
    let key: String
    let rules: [ValidationRule]

    init(field: SFGInputField, key: String, rules: [ValidationRule]) {
        self.field = field
        self.key = key
        self.rules = rules
    }
    
    @MainActor
    func addValidationRule() {
        self.field.validator = { [weak self] text in
            guard let self = self else { return nil }
            for rule in self.rules {
                if let error = rule.validate(text) {
                    return error.message
                }
            }
            return nil
        }
    }
    
    @MainActor
    func validate() -> Bool {
        return field.validate()
    }

    @MainActor
    func value() -> String? {
        return field.getText()?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
