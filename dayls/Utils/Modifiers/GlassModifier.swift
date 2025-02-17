//
//  GlassModifier.swift
//  dayls
//
//  Created by Spike Hermann on 17/02/2025.
//

import Foundation
import SwiftUI

struct GlassModifier: ViewModifier {
    let cornerRadius: CGFloat
    let fill: Color
    let opacity: CGFloat
    let shadowRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background {
                GlassView(cornerRadius: cornerRadius, fill: fill, opacity: opacity, shadowRadius: shadowRadius)
            }
    }
}

extension View {
    func glass(cornerRadius: CGFloat, fill: Color = .white, opacity: CGFloat = 0.25, shadowRadius: CGFloat = 10.0) -> some View {
        modifier(GlassModifier(cornerRadius: cornerRadius, fill: fill, opacity: opacity, shadowRadius: shadowRadius))
    }
}
