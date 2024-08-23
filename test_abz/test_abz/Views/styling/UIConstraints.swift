//
//  UIConstraints.swift
//  test_abz
//
//  Created by mac on 20.08.2024.
//

import Foundation

import SwiftUI

extension Color {
    init(R: Double, G: Double, B: Double, a: Double) {
        self.init(.sRGB, red: R / 255.0, green: G / 255.0, blue: B / 255.0, opacity: a)
    }
}

// Define the DesignSystem class or struct
struct UIConstraints {
    // MARK: - Colors
    
    public static let primary = Color(R: 244, G: 224, B: 65, a: 1)
    public static let primaryDark = Color(red: 1, green: 0.7799999713897705, blue: 0, opacity: 1)
    public static let secondary = Color(red: 0, green: 0.7411764860153198, blue: 0.8274509906768799, opacity: 1)
    public static let secondaryDark = Color(red: 0, green: 0.6083036661148071, blue: 0.7418337464332581, opacity: 1)
    public static let black87 = Color(red: 0, green: 0, blue: 0, opacity: 0.8700000047683716)
    public static let black60 = Color(red: 0, green: 0, blue: 0, opacity: 0.6000000238418579)
    public static let black48 = Color(red: 0, green: 0, blue: 0, opacity: 0.47999998927116394)
    public static let gray = Color(red: 0, green: 0, blue: 0, opacity: 0.13)
    public static let error = Color(red: 0.7960784435272217, green: 0.239215686917305, blue: 0.250980406999588, opacity: 1)
    public static let white = Color(red: 1, green: 1, blue: 1, opacity: 1)
    
    
    // MARK: - Fonts
    static func fontSemiBold(size: CGFloat) -> Font {
        Font.custom("NunitoSans7pt-SemiBold", size: size)
    }
    static func fontRegular(size: CGFloat) -> Font {
        Font.custom("NunitoSans7pt-Regular", size: size)
    }
    
}

public extension Font {
    
    
    static func fontRegular(size: CGFloat) -> Font {
        Font.custom("DMSans-Regular", size: size)
    }
    
}
