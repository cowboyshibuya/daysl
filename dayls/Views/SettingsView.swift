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
    
    @State private var selectedDate = Date()
    @State private var enableNotifications = true
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                VStack {
                    infoSection
                    
                    appSection
                    
                    aboutSection
                }
                .padding()
            } // ZStack
            .navigationTitle("Settings")
        } // NavStack
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                Text("Your information")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                Spacer()
                Button("Edit") {
                    
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 3)
                .background(Capsule().fill(.black.opacity(0.1)))
            }
            HStack {
                Image(systemName: "calendar")
                Text("Birthdate")
                Spacer()
                Menu("\(profile.birthdate.formatted(date: .abbreviated, time: .omitted))") {
                    
                }
            }
            HStack {
                Text("🧓")
                Text("Target Age")
                Spacer()
                Text("\(profile.targetAge)")
                    .foregroundStyle(.secondary)
                    .fontWeight(.semibold)
                
            }
        } // VStack
        .padding()
        .glass(cornerRadius: 20)
    }
    
    private var appSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("App")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                Spacer()
            } // HStack
            
            HStack {
                Text("🔔")
                Text("Enable notifications")
                Spacer()
                Toggle("Enable Notifications", isOn: $enableNotifications)
                    .labelsHidden()
            }
        } // VStack
        .padding()
        .glass(cornerRadius: 20)
    }
    
    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            List {
                NavigationLink(destination: {}) {
                    HStack {
                        Text("🪲")
                        Text("Report a bug")
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        } // VStack
        .padding()
        .glass(cornerRadius: 20)
    }
}

#Preview {
    let previewBirthdate = Calendar.current.date(byAdding: .year, value: -20, to: .now)
    let previewProfile = Profile(birthdate: previewBirthdate ?? Date())
    SettingsView(profile: previewProfile)
}
