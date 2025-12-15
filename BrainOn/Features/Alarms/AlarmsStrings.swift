//
//  AlarmsStrings.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 10/12/25.
//

import SwiftUICore

enum AlarmsStrings {
    
    static var title: LocalizedStringKey = "alarms.title"
    
    enum Edit {
        
        static var labelPlaceholder: LocalizedStringKey = "Label (e.g. Work)"
        static var general: LocalizedStringKey = "General"
        static var mission: LocalizedStringKey = "Mission"
        static var wakeUpChallenge: LocalizedStringKey = "Wake-up Challenge"
        static var completeThisMissionMessage: LocalizedStringKey = "You must complete this mission to turn off the alarm."
        static var newAlarm: LocalizedStringKey = "New alarm"
        static var editAlarm: LocalizedStringKey = "Edit alarm"
    }
    
    enum List {
        
        static var empty: LocalizedStringKey = "alarms.list.empty"
    }
    
    enum Missions {
        
        static var solveToStopAlarm: LocalizedStringKey = "Solve to stop the alarm"
    }
    
    enum WakeUp {
        
        static var iAmAwake: LocalizedStringKey = "I'M AWAKE"
    }
}
