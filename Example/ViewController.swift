//
//  ViewController.swift
//  Example
//
//  Created by Anurag Singh on 04/05/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var emailField: SFGInputField!
    @IBOutlet weak var passwordField: SFGInputField!
    @IBOutlet weak var nameField: SFGInputField!
    @IBOutlet weak var wordLimitField: SFGInputField!
    
    private let validator = SwiftFormGuard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValidator()
    }

    @IBAction func didTapSubmit(_ sender: Any) {
        let result = validator.validateAll()
        if result.isValid {
            let values = result.values
            print("Validation success with values: \(values)")
        } else {
            print("Validation failed!")
        }
    }
    
    private func setupValidator() {
        validator.register(field: emailField, type: .email)
        validator.register(field: passwordField, type: .password)
        validator.register(field: nameField, type: .name)
        validator.register(field: wordLimitField, type: .language)
    }
}
