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
            VStack {
                Text("When were you born ?")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("It will help us to to...")
                    .foregroundStyle(.secondary)
                
                DatePicker("Birthdate", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .onChange(of: selectedDate) {
                        isDateSelected = true
                    }
                
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
