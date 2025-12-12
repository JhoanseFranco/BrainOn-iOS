//
//  AlarmEditorView.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 12/12/25.
//

import SwiftUI
import SwiftData

struct AlarmEditorView: View {
    
    // MARK: Properties
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var time = Date()
    @State private var label = ""
    @State private var selectedMission: MissionType = .math
    @State private var isEnabled = true
    
    var alarmToEdit: AlarmModel?
    
    
    // MARK: Initialization
    
    init(alarm: AlarmModel? = nil) {
        alarmToEdit = alarm
        
        if let alarm {
            _time = State(initialValue: alarm.time)
            _label = State(initialValue: alarm.label)
            _selectedMission = State(initialValue: alarm.missionType)
            _isEnabled = State(initialValue: alarm.isEnabled)
        }
    }
    
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppAssets.Colors.brandBackground.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .colorMultiply(AppAssets.Colors.brandYellow)
                    
                    Form {
                        Section {
                            TextField(AlarmsStrings.edit.labelPlaceholder, text: $label)
                        } header: {
                            Text(AlarmsStrings.edit.general)
                        }
                        
                        Section {
                            Picker(AlarmsStrings.edit.mission, selection: $selectedMission) {
                                ForEach(MissionType.allCases, id: \.self) { mission in
                                    HStack {
                                        Image(systemName: mission.iconName)
                                        Text(mission.title)
                                    }
                                    .tag(mission)
                                }
                            }
                            .pickerStyle(.navigationLink)
                        } header: {
                            Text(AlarmsStrings.edit.wakeUpChallenge)
                        } footer: {
                            Text(AlarmsStrings.edit.completeThisMissionMessage)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle(alarmToEdit == nil ? AlarmsStrings.edit.newAlarm : AlarmsStrings.edit.editAlarm)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(CommonStrings.save) {
                        saveAlarm()
                    }
                    .foregroundStyle(AppAssets.Colors.brandYellow)
                    .fontWeight(.bold)
                }
            }
        }
    }
}


// MARK: Private methods

private extension AlarmEditorView {
    
    func saveAlarm() {
        if let alarmToEdit {
            alarmToEdit.time = time
            alarmToEdit.label = label.isEmpty ? "Alarma" : label
            alarmToEdit.missionType = selectedMission
            alarmToEdit.isEnabled = true
        } else {
            let newAlarm = AlarmModel(time: time,
                                      label: label.isEmpty ? "Alarma" : label,
                                      isEnabled: true,
                                      missionType: selectedMission)
            
            modelContext.insert(newAlarm)
        }
        
        dismiss()
    }
}

#Preview {
    AlarmEditorView()
}
