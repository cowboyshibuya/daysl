//
//  Item.swift
//  dayls
//
//  Created by Spike Hermann on 17/02/2025.
//

import Foundation
import SwiftData

@Model
final class Profile {
    var birthdate: Date
    var targetAge: Int
    
    init(birthdate: Date, targetAge: Int = 85) {
        self.birthdate = birthdate
        self.targetAge = targetAge
    }
}
