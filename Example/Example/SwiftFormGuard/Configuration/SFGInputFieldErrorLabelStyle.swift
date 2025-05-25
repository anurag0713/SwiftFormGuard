//
//  SFGInputFieldErrorLabelStyle.swift
//  SwiftFormGuard
//
//  Created by Anurag Singh on 25/05/25.
//
import UIKit

public struct SFGInputFieldErrorLabelStyle {
    public var textColor: UIColor?
    public var font: UIFont?
    public var numberOfLines: Int?
    public var setupBlock: ((UILabel) -> Void)?
    
    public init(textColor: UIColor? = nil,
                font: UIFont? = nil,
                numberOfLines: Int? = nil,
                setupBlock: ((UILabel) -> Void)? = nil) {
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
        self.setupBlock = setupBlock
    }
}
