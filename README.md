# SwiftFormGuard

**SwiftFormGuard** is a lightweight Swift library for creating **inline warning fields** with **live input validation** using `UITextField`. Just register your field with a type, and it automatically checks input against validation rules and displays contextual inline errors in real time.

- ✅ Clean, user-friendly inline error messages  
- ⚡️ Real-time validation for `UITextField` and `UITextView`
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

### Swift Package Manager
Open SPM dependency manager through File > Swift Packages > Add Package Dependency....

and insert repository URL:

https://github.com/anurag0713/SwiftFormGuard.git

To add dependency in your own package, just specify a package in dependencies of your Package.swift:
```swift
.package(
name: "SwiftFormGuard",
url: "https://github.com/anurag0713/SwiftFormGuard.git",
.upToNextMajor(from: "1.0.0")
)
```
### Cocoapods
First, be sure to run pod repo update to get the latest version available.
Add pod 'SwiftFormGuard' to your Podfile and run pod install

### Manually
If you dont want to use either of those and want more control then feel free to copy the `SwiftFormGuard` folder directly into your project and make any modifications needed to suit your use case.

## 🧪 Usage

### 1. Add the UI Components in Storyboard  
- Drag a `UIStackView` onto your view.
- Place a `UITextField` inside the stack view.
- Assign the class `SFGInputField` (provided by the library) to the `UIStackView`.

### 2. Connect the TextField Outlet  
- In Interface Builder, select the `SFGInputField`.
- Connect its `textField` or `textView` outlet to the respective UI component inside the stack view.
Note - Only one component can be added for each field. Otherwise you will get fatal error.

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

### 6. Input field configuration

Update the Error label and live validation however you want. More configs will be added in future if needed.

```swift
// Manually changing single components
SFGInputFieldConfig.shared.errorLabelStyle.font      = .systemFont(ofSize: 10, weight: .medium)
SFGInputFieldConfig.shared.errorLabelStyle.textColor = .red

// Change anything for the errorLabel
SFGInputFieldConfig.shared.errorLabelStyle.setupBlock = { label in
    label.textAlignment = .left
}

// Toggle live validation
SFGInputFieldConfig.shared.isLiveValidationEnabled = true
```

### 7. Validate on submit

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

## Known Issues & Contributions
If you come across any bugs or issues, feel free to report them. I’ll do my best to fix them as time permits. Contributions are always welcome! I’d love to improve this project with help from the community, as I’m sure there’s plenty of room for improvement since this is my first time.

### Issues
- Since this project uses UITextViewDelegate for validation, setting your own delegate will override the one used by SFG. This will break the live validation feature.

## 📄 License
MIT License. See LICENSE for details.
