//
//  CustomFont.swift
//  Travel Diaries
//
//  Created by Kailash on 30/04/24.
//

import SwiftUI

enum Fonts: String {
    case poppins = "Poppins-Regular"
    case frosting = "FROSTINGBWPERSONALUSE-Bold"
}

extension Font {
    static func customFont(_ font: Fonts, size: CGFloat) -> Font {
        return Font.custom(font.rawValue, size: size)
    }
}
