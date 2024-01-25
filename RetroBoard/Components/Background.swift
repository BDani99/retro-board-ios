//
//  Background.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 10..
//

import Foundation
import SwiftUI


struct CustomBackground: ViewModifier {
    func body(content:Content) -> some View {
        content
            .foregroundColor(.clear)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.56, green: 0.85, blue: 1), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.07, green: 0.5, blue: 0.72), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.25, y: -0.33),
                    endPoint: UnitPoint(x: -0.83, y: 0.69)
                )
            )
    }
}
