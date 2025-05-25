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
    @IBOutlet weak var descriptionField: SFGInputField!
    
    private let formValidator = SwiftFormGuard()
    
    // Custom rule. Would be better to add it in global scope so that you can access it everywhere.
    struct CustomRule: ValidationRule {
        func validate(_ value: String?) -> ValidationError? {
            if value?.contains("x") == true {
                return ValidationError(message: "Value must not contain 'x'")
            }
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        
        setupValidation()
        customConfiguration()
    }
    
    private func initialSetup() {
        descriptionField.textView.layer.borderColor = UIColor.placeholderText.cgColor
        descriptionField.textView.layer.borderWidth = 1
        descriptionField.textView.layer.cornerRadius = 15
    }
    
    private func setupValidation() {
        formValidator.register(field: requiredField, key: "required", rules: [SFGRule.RequiredField()])
        formValidator.register(field: customRuleField, key: "CustomRule", rules: [CustomRule()])
        formValidator.register(field: emailField, key: "email", rules: [SFGRule.RequiredField(), SFGRule.IsValidEmail()])
        formValidator.register(field: lengthLimitField, key: "lengthLimit", rules: [SFGRule.MaxLength(limit: 20)])
        formValidator.register(field: descriptionField, key: "description", rules: [SFGRule.MaxLength(limit: 100)])
    }
    
    // Do these configs in Appdelegate to make sure its applied everywhere as the config class is singleton and global
    private func customConfiguration() {
        // Manually changing single components
        SFGInputFieldConfig.shared.errorLabelStyle.font      = .systemFont(ofSize: 10, weight: .medium)
        SFGInputFieldConfig.shared.errorLabelStyle.textColor = .red
        
        // Change anything for the errorLabel
        SFGInputFieldConfig.shared.errorLabelStyle.setupBlock = { label in
            label.textAlignment = .left
        }
        
        // Toggle live validation
        SFGInputFieldConfig.shared.isLiveValidationEnabled = true
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
