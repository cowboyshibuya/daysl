//
//  Footer.swift
//  dayls
//
//  Created by Spike Hermann on 18/02/2025.
//

import Foundation
import SwiftUI

public var footer: some View {
    HStack {
        VStack {
            Text("@cowboyshibuya")
            Text("v\(getAppVersion())" + "\(getBuildNumber())")
        }
    }
    .font(.footnote)
    .foregroundStyle(.secondary)
}

private func getAppVersion() -> String {
    if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
        return appVersion
    }
    
    return "Unknown"
}

private func getBuildNumber() -> String {
    if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
        return buildNumber
    }
    return "Unknown"
}


