//
//  ViewController.swift
//  Example
//
//  Created by Anurag Singh on 10/05/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var requiredField: SFGInputField!
    @IBOutlet weak var customRuleField: SFGInputField!
    @IBOutlet weak var emailField: SFGInputField!
    @IBOutlet weak var lengthLimitField: SFGInputField!
    @IBOutlet weak var resultLabel: UILabel!
    
    private let formValidator = SwiftFormGuard()
    
    // Custom rule. Would be better to add it in global scope so that you can access it everywhere.
    struct CustomRule: SFGValidationRule {
        func validate(_ value: String?) -> ValidationError? {
            if value?.contains("x") == true {
                return ValidationError(message: "Value must not contain 'x'")
            }
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValidation()
    }
    
    private func setupValidation() {
        formValidator.register(field: requiredField, key: "required", rules: [SFGRule.RequiredField()])
        formValidator.register(field: customRuleField, key: "CustomRule", rules: [CustomRule()])
        formValidator.register(field: emailField, key: "email", rules: [SFGRule.RequiredField(), SFGRule.IsValidEmail()])
        formValidator.register(field: lengthLimitField, key: "lengthLimit", rules: [SFGRule.MaxLength(limit: 20)])
    }

    @IBAction func didTapSubmit(_ sender: Any) {
        let validator = formValidator.validateAll()
        if validator.isValid {
            resultLabel.text = validator.values.description
        } else {
            resultLabel.text = "Validation failed!!!"
        }
    }
}
