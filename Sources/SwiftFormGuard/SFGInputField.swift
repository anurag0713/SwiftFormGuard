//
//  SFGInputField.swift
//  SwiftFormGuard
//
//  Created by Anurag Singh on 04/05/25.
//
import UIKit

protocol SFGInputComponent {
    @MainActor var inputText: String? { get set }
}

extension UITextField: SFGInputComponent {
    public var inputText: String? {
        get { return text }
        set { text = newValue }
    }
}

extension UITextView: SFGInputComponent {
    public var inputText: String? {
        get { return text }
        set { text = newValue }
    }
}

@IBDesignable
public class SFGInputField: UIStackView {

    @IBOutlet weak var textField: UITextField! {
        didSet {
            guard inputComponent == nil else {
                preconditionFailure("""
                    SFGInputField can only be connected to either a UITextField or UITextView, not both.
                    Make sure only one of the @IBOutlets is connected in Interface Builder.
                """)
            }
            textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
            inputComponent = textField
        }
    }
    @IBOutlet weak var textView: UITextView! {
        didSet {
            guard inputComponent == nil else {
                preconditionFailure("""
                    SFGInputField can only be connected to either a UITextField or UITextView, not both.
                    Make sure only one of the @IBOutlets is connected in Interface Builder.
                """)
            }
            textView.delegate = self
            inputComponent = textView
        }
    }
    
    private var inputComponent: (SFGInputComponent & UIView)?
    private var errorLabel = UILabel()
    private var config = SFGInputFieldConfig.shared
    
    public var validator: ((String?) -> String?)?

    public override func awakeFromNib() {
        super.awakeFromNib()
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.axis = .vertical
            self.spacing = 2
            
            self.setupErrorLabel()
        }
    }
    
    private func setupErrorLabel() {
        errorLabel.removeFromSuperview()
        errorLabel = UILabel()
        
        let config = config.errorLabelStyle

        errorLabel.textColor = config.textColor ?? .systemRed
        errorLabel.font = config.font ?? .systemFont(ofSize: 12)
        errorLabel.numberOfLines = config.numberOfLines ?? 0
        errorLabel.isHidden = true
        
        config.setupBlock?(errorLabel)
        
        addArrangedSubview(errorLabel)
    }


    // MARK: - Validation
    @discardableResult
    func validate() -> Bool {
        hideError()
        
        if let text = inputComponent?.inputText,
           let message = validator?(text)  {
            showError(message)
            return false
        }

        return true
    }

    // MARK: - Public API
    func setText(_ value: String?) {
        inputComponent?.inputText = value
    }

    func getText() -> String? {
        return inputComponent?.inputText
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

extension SFGInputField: UITextViewDelegate {
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if config.isLiveValidationEnabled {
            validate()
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        if config.isLiveValidationEnabled {
            validate()
        }
    }
}
