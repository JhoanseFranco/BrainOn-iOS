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
    
    @State private var viewModel = AlarmEditorViewModel()
    
    
    // MARK: Initialization
    
    init(alarm: AlarmModel? = nil) {
        if let alarm {
            _viewModel = State(initialValue: AlarmEditorViewModel(alarm: alarm))
        }
    }
    
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppAssets.Colors.brandBackground.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    DatePicker("", selection: $viewModel.time, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .colorMultiply(AppAssets.Colors.brandYellow)
                    
                    Form {
                        Section {
                            TextField(AlarmsStrings.edit.labelPlaceholder, text: $viewModel.label)
                        } header: {
                            Text(AlarmsStrings.edit.general)
                        }
                        
                        Section {
                            Picker(AlarmsStrings.edit.mission, selection: $viewModel.selectedMission) {
                                ForEach(MissionType.allCases, id: \.self) { mission in
                                    HStack {
                                        Image(systemName: mission.iconName)
                                        Text(mission.title)
                                    }
                                    .tag(mission)
                                }
                            }
                        } header: {
                            Text(AlarmsStrings.edit.wakeUpChallenge)
                        } footer: {
                            Text(AlarmsStrings.edit.completeThisMissionMessage)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(CommonStrings.save) {
                        viewModel.save(context: modelContext)
                        dismiss()
                    }
                    .foregroundStyle(AppAssets.Colors.brandYellow)
                    .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    AlarmEditorView()
}
