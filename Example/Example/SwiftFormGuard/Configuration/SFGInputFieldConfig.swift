//
//  SFGInputFieldConfig.swift
//  SwiftFormGuard
//
//  Created by Anurag Singh on 25/05/25.
//

@MainActor
public class SFGInputFieldConfig {
    public static let shared = SFGInputFieldConfig()
    
    private init() {}
    
    public var errorLabelStyle = SFGInputFieldErrorLabelStyle()
}
