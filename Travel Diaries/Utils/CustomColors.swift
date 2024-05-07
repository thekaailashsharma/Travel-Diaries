//
//  CustomColors.swift
//  Travel Diaries
//
//  Created by Kailash on 07/05/24.
//

import Foundation
import SwiftUI

enum Colors: String {
    case blue = "Blue"
    case gray = "Gray"
    case green = "Green"
    case orange = "orange"
    case pink = "Pink"
    case white = "White"
    case yellow = "Yellow"
}

extension Color {
    static func customColor(_ color: Colors) -> Color {
        return Color(color.rawValue)
    }
}

