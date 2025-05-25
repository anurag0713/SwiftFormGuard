//
//  String+Ext.swift
//  SwiftFormGuard
//
//  Created by Anurag Singh on 04/05/25.
//
import UIKit

extension String {

    func isValidEmail() -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
}
