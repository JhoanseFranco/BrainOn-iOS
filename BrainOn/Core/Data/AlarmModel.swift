//
//  AlarmModel.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 10/12/25.
//

import Foundation
import SwiftData

@Model
final class AlarmModel {
    // TODO: Validar si pueden ser let en lugar de var
    var id: UUID
    var time: Date
    var label: String
    var isEnabled: Bool
    var repeatDays: [Int]
    var missionType: MissionType
    var difficultyLevel: Int
    
    init(id: UUID = UUID(),
         time: Date,
         label: String,
         isEnabled: Bool,
         repeatDays: [Int] = [],
         missionType: MissionType = .math,
         difficultyLevel: Int = 1) {
        self.id = id
        self.time = time
        self.label = label
        self.isEnabled = isEnabled
        self.repeatDays = repeatDays
        self.missionType = missionType
        self.difficultyLevel = difficultyLevel
    }
}
