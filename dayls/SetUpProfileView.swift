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
    @State private var selectedDate = Date().addingTimeInterval(-500000)
    
    @State private var isDateSelected = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                VStack {
                    Spacer()
                    
                    VStack {
                        Text("Select your birthdate")
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("To set up a countdown")
                            .foregroundStyle(.secondary)
                        DatePicker("Birthdate", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                            .datePickerStyle(.wheel)
                            .onChange(of: selectedDate) {
                                isDateSelected = true
                            }
                            .labelsHidden()
                    }
                    .padding()
                    .glass(cornerRadius: 20)
                    
                    Spacer()
                    
                    Button(action: setUpProfile) {
                        HStack {
                            Spacer()
                            Text("Continue")
                            Image(systemName: "arrow.right")
                            Spacer()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).fill(.black))
                        .foregroundStyle(.white)
                        .padding()
                    }
                } // VStack
                .padding()
                
                
                .navigationTitle("Set up your profile")
            } // ZStack
            
        } // NavStack
    }
    
    
    private func setUpProfile() {
        withAnimation {
            let newProfile = Profile(birthdate: selectedDate)
            context.insert(newProfile)
        }
    }

}

#Preview {
    SetUpProfileView()
}
