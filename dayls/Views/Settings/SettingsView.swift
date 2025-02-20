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
    @State private var showEditProfileSheet: Bool = false
    
    @State private var showResetAlert = false

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
                            Text("\(profile.name), \(profile.age)")
                                .font(.title2).bold()
                            Text("Born on **\(profile.birthdate.formatted(date: .abbreviated, time: .omitted))**").foregroundStyle(.secondary)
                        }
                    }
                    .padding()
                    .glass(cornerRadius: 50)
                    
                    VStack(spacing: 20) {
                        HStack {
                            DefaultButton(icon: "paintpalette.fill", title: "Background", action: {})
                            DefaultButton(icon: "pencil", action: {
                                showEditProfileSheet.toggle()
                            })
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
                    Button("Reset", role: .destructive) {
                        resetProfile()
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
            .sheet(isPresented: $showBackgroundColorSelectionSheet) {
                
            }
            .sheet(isPresented: $showEditProfileSheet) {
                EditProfileView(profile: profile)
            }
            .alert("Reset App", isPresented: $showResetAlert) {
                Button("Reset", role: .destructive) {
                    withAnimation {
                        context.delete(profile)
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure you want to reset your profile? All your informations will be cleared.")
            }
        } // NavStack
    }
    
    private func resetProfile() {
        showResetAlert = true
    }
}

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    let profile: Profile
    
    // form properties
    @State private var name = ""
    @State private var targetAge: Int = 0
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Text("🙋 Name").font(.headline).foregroundStyle(.secondary)
                        TextField("Name", text: $name)
                            .padding()
                            .glass(cornerRadius: 20)
                        
                        Text("🎯 Target Age")
                            .font(.headline).foregroundStyle(.secondary)
                        TextField("Target Age", value: $targetAge, format: .number)
                            .padding()
                            .glass(cornerRadius: 20)
                        
                        Text("🥳 Birthdate").font(.headline).foregroundStyle(.secondary)
                        HStack {
                            Spacer()
                            DatePicker("Birthdate", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                                .labelsHidden()
                                .datePickerStyle(.compact)
                            Spacer()
                        }
                    } // VStack
                    .padding()
                }
            } // ZStack
            .onAppear {
                name = profile.name
                targetAge = profile.targetAge
                selectedDate = profile.birthdate
            }
            .navigationTitle("Edit Information")
            .toolbar {
                Button("Done") {
                    if targetAge > 0 && targetAge > profile.age {
                        profile.name = name
                        profile.birthdate = selectedDate
                        profile.targetAge = targetAge
                    }
                    dismiss()
                }
            }
        } // NavStack
    }
}



#Preview {
    let previewBirthdate = Calendar.current.date(byAdding: .year, value: -20, to: .now)
    let previewProfile = Profile(name: "Spike", birthdate: previewBirthdate ?? Date())
    SettingsView(profile: previewProfile)
}
