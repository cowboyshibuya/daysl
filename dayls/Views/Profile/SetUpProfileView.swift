//
//  SetUpProfileView.swift
//  dayls
//
//  Created by Spike Hermann on 17/02/2025.
//

import SwiftUI
import SwiftData

struct SetUpProfileView: View {
    @Environment(\.modelContext) private var context
    
    // form properties
    @State private var name: String = ""
    @State private var selectedDate = Date().addingTimeInterval(-500000)
    @State private var targetAge = 30.0
    @State private var showButton = false
    
    // animation properties
    @State private var showNameForm: Bool = false
    @State private var showDateForm: Bool = false
    @State private var showTargetAgeForm: Bool = false
    
    @FocusState private var isNameFocused: Bool
    @FocusState private var isDateFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                    .ignoresSafeArea()
                
                VStack {
                    VStack(spacing: 30) {
                        
                        if showNameForm {
                            VStack {
                                Text("How should we call you?")
                                    .font(.headline)
                                TextField("Name", text: $name)
                                    .focused($isNameFocused)
                                    .padding()
                                    .glass(cornerRadius: 20)
                                    .onChange(of: isNameFocused) { _,focused in
                                        if !focused {
                                            withAnimation(.spring(duration: 1)) {
                                                showDateForm = true
                                            }
                                        }
                                    }
                            }
                            .opacity(showNameForm ? 1 : 0)
                        }
                        
                        if showDateForm {
                            VStack {
                                Text("Select your birthdate")
                                    .font(.headline)
                                DatePicker("Birthdate", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                                    .focused($isDateFocused)
                                    .datePickerStyle(.compact)
                                    .onChange(of: selectedDate) {
                                        withAnimation(.spring(duration: 1)) {
                                            showTargetAgeForm = true
                                            showButton = true
                                        }
                                    }
                                    .labelsHidden()
                            }
                            .opacity(showDateForm ? 1 : 0)
                        }
                        
                        if showTargetAgeForm {
                            #warning("Fix this")
                            VStack {
                                Text("Select a target age")
                                    .font(.headline)
                                Picker("Target Age", selection: $targetAge) {
                                    ForEach(18...100, id: \.self) {
                                        Text("\($0) year").tag(targetAge)
                                    }
                                }
                                .labelsHidden()
                                .pickerStyle(.wheel)
                                
                            }
                            .opacity(showTargetAgeForm ? 1 : 0)
                        }
                    }
                    .padding()
                    
                    if showButton {
                        Button(action: setUpProfile) {
                            HStack {
                                Spacer()
                                Text("Continue")
                                Image(systemName: "arrow.right")
                                Spacer()
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                            .foregroundStyle(.black)
                            .padding()
                        }
                    }
                } // VStack
                .padding()
                .onAppear {
                    withAnimation(.spring(duration: 1)) {
                        showNameForm = true
                    }
                }
                .navigationTitle("Let's set your profile 🧑‍🎤")
                .toolbar {
                    Button("Skip") {
                        //TODO: Create an empty profile with default value
                    }
                }
            } // ZStack
        } // NavStack
    }
    
    
    private func setUpProfile() {
        withAnimation {
            let newProfile = Profile(name: name, birthdate: selectedDate, targetAge: Int(targetAge))
            context.insert(newProfile)
        }
    }
}


#Preview {
    SetUpProfileView()
}
