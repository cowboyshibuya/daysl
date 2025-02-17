//
//  GlassView.swift
//  dayls
//
//  Created by Spike Hermann on 17/02/2025.
//

import Foundation
import SwiftUI

struct GlassView: View {
    let cornerRadius: CGFloat
    let fill: Color
    let opacity: CGFloat
    let shadowRadius: CGFloat

    init(cornerRadius: CGFloat, fill: Color = .white, opacity: CGFloat = 0.25, shadowRadius: CGFloat = 10.0) {
        self.cornerRadius = cornerRadius
        self.fill = fill
        self.opacity = opacity
        self.shadowRadius = shadowRadius
    }

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(fill)
            .opacity(opacity)
            .shadow(radius: shadowRadius)
    }
}
