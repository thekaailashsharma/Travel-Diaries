//
//  Glows&Shadows.swift
//  Travel Diaries
//
//  Created by Kailash on 11/05/24.
//

import SwiftUI

extension View {
    func glow(color: Color = .customColor(.gray).opacity(0.5), radius: CGFloat = 14) -> some View {
        self
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
    }
}

extension View {
    func innerShadow<S: Shape>(using shape: S, angle: Angle = .degrees(0), color: Color = .customColor(.gray), width: CGFloat = 6, blur: CGFloat = 6) -> some View {
        return self
    }
}
