//
//  BackgroundSelectionView.swift
//  dayls
//
//  Created by Spike Hermann on 19/02/2025.
//

import SwiftUI

struct BackgroundSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedBackgroundColor: [Color] = []
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                VStack {
                    // TODO: Set a LazyVGrid
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 100)
                        Circle()
                            .fill(LinearGradient(colors: [.green.opacity(0.5), .teal.opacity(0.5)], startPoint: .topLeading, endPoint: .topTrailing))
                            .frame(width: 100, height: 100)
                    }
                }
            } // ZStack
            .navigationTitle("Background")
            .toolbar {
                Button("Done") {
                    
                }
            }
        } // Nav Stack
    }
}

// TODO: Capsule Color

#Preview {
    BackgroundSelectionView()
}
