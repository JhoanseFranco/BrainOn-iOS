//
//  AlarmEditorViewModel.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 12/12/25.
//

import Foundation
import SwiftData
import SwiftUICore

@Observable
final class AlarmEditorViewModel {
    
    // MARK: Properties
    
    var time = Date()
    var label = ""
    var selectedMission: MissionType = .math
    var isEnabled = true
    
    var alarmToEdit: AlarmModel?
    
    var title: LocalizedStringKey {
        alarmToEdit == nil ? AlarmsStrings.Edit.newAlarm : AlarmsStrings.Edit.editAlarm
    }
    
    
    // MARK: Initialization
    
    init(alarm: AlarmModel? = nil) {
        self.alarmToEdit = alarm
        
        if let alarm {
            time = alarm.time
            label = alarm.label
            selectedMission = alarm.missionType
            isEnabled = alarm.isEnabled
        }
    }
    
    
    // MARK: Business logic methods
    
    func save(context: ModelContext) {
        if let alarmToEdit {
            update(alarm: alarmToEdit)
        } else {
            createAlarm(context: context)
        }
    }
}


// MARK: Private methods

private extension AlarmEditorViewModel {
    
    func update(alarm: AlarmModel) {
        alarm.time = time
        alarm.label = getLabel()
        alarm.missionType = selectedMission
        alarm.isEnabled = true
    }
    
    func createAlarm(context: ModelContext) {
        let newAlarm = AlarmModel(time: time,
                                  label: getLabel(),
                                  isEnabled: true,
                                  missionType: selectedMission)
        
        context.insert(newAlarm)
    }
    
    func getLabel() -> String {
        if !label.isEmpty {
            label
        } else {
            CommonStrings.alarm.stringValue
        }
    }
}

extension LocalizedStringKey {
    
    var stringValue: String {
        let mirror = Mirror(reflecting: self)
        
        let label = mirror.children.first(where: { label, _ in
            label == "key"
        })?.value as? String
        
        return label ?? ""
    }
}
