# SwiftFormGuard

**SwiftFormGuard** is a lightweight Swift library for creating **inline warning fields** with **live input validation** using `UITextField`. Just register your field with a type, and it automatically checks input against validation rules and displays contextual inline errors in real time.

- ✅ Clean, user-friendly inline error messages  
- ⚡️ Real-time validation using `UITextFieldDelegate`  
- 🧩 Supports built-in and Custom rules.

---

## 📸 Screenshots

![Valid Input](./Assets/screenshot.png)

---

## 🎞 Demo

![SwiftFormGuard Demo](./Assets/demo.gif)

---

## ✨ Features

- Modular validation rules (required, email, numeric, password, etc.)
- Developer-defined field keys for the field which get returned in form of dict on successfull validation
- Full control over validation logic and error strings
- Clear API for showing/hiding inline errors
- Custom rules

---

## 🛠 Installation

SPM and Cocoapods coming soon.

In the meantime, feel free to copy the `SwiftFormGuard` folder directly into your project and make any modifications needed to suit your use case.

## 🧪 Usage

### 1. Add the UI Components in Storyboard  
- Drag a `UIStackView` onto your view.
- Place a `UITextField` inside the stack view.
- Assign the class `SFGInputField` (provided by the library) to the `UIStackView`.

### 2. Connect the TextField Outlet  
- In Interface Builder, select the `SFGInputField`.
- Connect its `textField` outlet to the `UITextField` inside the stack view.

### 3. Create the Validator Instance  
In your view controller, declare an instance of `SwiftFormGuard`:

```swift
private let validator = SwiftFormGuard()
```
### 4. Register Your Input Fields

Register each input field with the validator, specifying the field key and array of rules:

```swift
formValidator.register(field: requiredField, key: "required", rules: [SFGRule.RequiredField()])
formValidator.register(field: emailField, key: "email", rules: [SFGRule.RequiredField(), SFGRule.IsValidEmail()])
formValidator.register(field: lengthLimitField, key: "lengthLimit", rules: [SFGRule.MaxLength(limit: 20)])
```

### 5. Custom rules

Add your own custom rules for validation logic to suit your field:

```swift
struct CustomRule: SFGValidationRule {
    func validate(_ value: String?) -> ValidationError? {
        if value?.contains("x") == true {
            return ValidationError(message: "Value must not contain 'x'")
        }
        return nil
    }
}

formValidator.register(field: customRuleField, key: "CustomRule", rules: [CustomRule()])
```

### 6. Validate on submit

Trigger validation when the user taps the submit button:

```swift
@IBAction func didTapSubmit(_ sender: UIButton) {
    let result = validator.validateAll()
    if result.isValid {
        let values = result.values
        print("Validation succeeded with values: \(values)")
    } else {
        print("Validation failed!")
    }
}
```
If all fields are valid you will get the values of all field in a dict with the keys passed while registering the fields.

## What next?

- SwiftPackage and Cocoapods integration
- TextView integration

## 📄 License
MIT License. See LICENSE for details.
