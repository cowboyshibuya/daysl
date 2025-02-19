//
//  SettingsView.swift
//  dayls
//
//  Created by Spike Hermann on 18/02/2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.modelContext) private var context
    let profile: Profile
    
    // sheet properties
    @State private var showBackgroundColorSelectionSheet: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                VStack(spacing: 20) {
                    // TODO
                    // Random quotes about time
                    Text("Don't lose this precious time by scrolling your feed !")
                        .padding()

                    VStack(spacing: 20) {
                        Text("🎯\(profile.targetAge) years old")
                            .font(.headline)
                            .padding()
                        //TODO: Random picture here
                        Image("selfie")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                        
                        VStack(spacing: 5) {
                            //TODO: Store user name
                            Text("Spike, \(profile.age)")
                                .font(.title2).bold()
                            Text("Born on **\(profile.birthdate.formatted(date: .abbreviated, time: .omitted))**").foregroundStyle(.secondary)
                        }
                    }
                    .padding()
                    .glass(cornerRadius: 50)
                    
                    VStack(spacing: 20) {
                        HStack {
                            DefaultButton(icon: "paintpalette.fill", title: "Background", action: {})
                            DefaultButton(icon: "pencil", action: {})
                        }
                        DefaultButton(icon: "laptopcomputer", title: "Visit our website", action: {})

                    }
                    Spacer()
                    
                    VStack(spacing: 15) {
                        // Trust & Security
                        Button("Trust and Security") {}
                            .bold()
                        // Contact US
                        Button("Contact Us"){}
                            .bold()
                    }
                }
                .padding()
            } // ZStack
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Menu {
                    Button("Report a bug") {}
                    Button("Delete", role: .destructive) {}
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
            .sheet(isPresented: $showBackgroundColorSelectionSheet) {
                
            }
        } // NavStack
    }
}

#Preview {
    let previewBirthdate = Calendar.current.date(byAdding: .year, value: -20, to: .now)
    let previewProfile = Profile(birthdate: previewBirthdate ?? Date())
    SettingsView(profile: previewProfile)
}
