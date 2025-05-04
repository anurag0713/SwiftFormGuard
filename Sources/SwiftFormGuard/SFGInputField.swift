//
//  SFGInputField.swift
//  SwiftFormGuard
//
//  Created by Anurag Singh on 04/05/25.
//
import UIKit

@IBDesignable
class SFGInputField: UIStackView {

    @IBOutlet weak var textField: UITextField!
    private var errorLabel = UILabel()
    
    public var validator: ((String?) -> String?)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        DispatchQueue.main.async {
            self.axis = .vertical
            self.spacing = 2
            self.textField.delegate = self
            
            self.setupErrorLabel()
        }
    }
    
    private func setupErrorLabel() {
        errorLabel.textColor = .systemRed
        errorLabel.font = UIFont(name: "Manrope-Regular", size: 12)!
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        addArrangedSubview(errorLabel)
    }

    // MARK: - Validation
    @discardableResult
    func validate() -> Bool {
        hideError()
        if let message = validator?(textField.text), !message.isEmpty {
            showError(message)
            return false
        }
        return true
    }

    // MARK: - Public API
    func setText(_ value: String?) {
        textField.text = value
    }

    func getText() -> String? {
        return textField.text
    }

    func setKeyboardType(_ type: UIKeyboardType) {
        textField.keyboardType = type
    }

    func setPlaceholder(_ placeholder: String) {
        textField.placeholder = placeholder
    }

    // MARK: - Error Management
    public func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }

    public func hideError() {
        errorLabel.text = nil
        errorLabel.isHidden = true
    }
}

extension SFGInputField: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        validate()
    }
}


