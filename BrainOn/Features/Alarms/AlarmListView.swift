//
//  AlarmListView.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 10/12/25.
//

import SwiftUI
import SwiftData

struct AlarmListView: View {
    
    // MARK: Properties
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \AlarmModel.time) private var alarms: [AlarmModel]
    
    @State private var selectedAlarm: AlarmModel?
    @State private var showCreateEditor = false
    
    
    // MARK: Body
    
    var body: some View {
        NavigationStack{
            ZStack {
                AppAssets.Colors.brandBackground
                    .ignoresSafeArea()
                
                VStack {
                    AlarmsHeaderView()
                        .padding(.bottom, 20)
                    
                    if alarms.isEmpty {
                        ContentUnavailableView(AlarmsStrings.List.empty, systemImage: AppAssets.Icons.alarm, description: Text(AlarmsStrings.List.empty))
                    } else {
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(alarms) { alarm in
                                    AlarmCardView(alarm: alarm)
                                        .onTapGesture {
                                            selectedAlarm = alarm
                                        }
                                        .contextMenu {
                                            Button(role: .destructive) {
                                                deletAlarm(alarm)
                                            } label: {
                                                Label(CommonStrings.delete, systemImage: AppAssets.Icons.trash)
                                            }
                                        }
                                }
                            }
                            .padding(.vertical)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showCreateEditor = true } ) {
                        Image(systemName: AppAssets.Icons.plus)
                            .foregroundStyle(AppAssets.Colors.brandYellow)
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $showCreateEditor) {
                AlarmEditorView()
            }
            .sheet(item: $selectedAlarm) { alarm in
                AlarmEditorView(alarm: alarm)
            }
        }
    }
}


// MARK: - Private methods

private extension AlarmListView {
    
    func deletAlarm(_ alarm: AlarmModel) {
        modelContext.delete(alarm)
    }
}

#Preview {
    AlarmListView()
}
