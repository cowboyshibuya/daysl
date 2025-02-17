//
//  MainView.swift
//  dayls
//
//  Created by Spike Hermann on 17/02/2025.
//

import SwiftUI

struct MainView: View {
    let profile: Profile
    
    @State private var timer: Timer?
    @State private var timeRemaining: TimeInterval = 0
    private var targetDate: Date {
        Calendar.current.date(byAdding: .year, value: profile.targetAge, to: profile.birthdate) ?? profile.birthdate
    }
    var body: some View {
        NavigationStack {
            VStack {
                Text("Time left before you're \(profile.targetAge) years old:")
                Text(formatTime(timeRemaining))
                        .font(.largeTitle)
                        .monospacedDigit()
            } // VStack
            .padding()
            .onAppear {
                startTimer(to: targetDate)
            }
            .onDisappear {
                timer?.invalidate()
            }
        } // NavStack
    }
    
    private func updateTimeRemaining(to date: Date) {
        let diff = date.timeIntervalSinceNow
        timeRemaining = max(diff, 0) // don't go below zero
        if diff <= 0 {
            // stop timer if time passed
            timer?.invalidate()
        }
    }
    
    private func startTimer(to date: Date) {
        timer?.invalidate()
        
        updateTimeRemaining(to: date)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            updateTimeRemaining(to: date)
        }
    }
    
    private func formatTime(_ interval: TimeInterval) -> String {
        let totalSeconds = Int(interval)
        
        let days = totalSeconds / 86400
        let hours = (totalSeconds % 86400) / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        if days > 0 {
            return String(format: "%d days, %2dh:%2dmin:%2dsec", days, hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }
}

#Preview {
    let previewBirthdate = Calendar.current.date(byAdding: .year, value: -20, to: .now)
    let previewProfile = Profile(birthdate: previewBirthdate ?? Date())
    MainView(profile: previewProfile)
}
