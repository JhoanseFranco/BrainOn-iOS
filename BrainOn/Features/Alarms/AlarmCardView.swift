//
//  AlarmCardView.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 10/12/25.
//

import SwiftUI

struct AlarmCardView: View {
    
    // MARK: Properties
    
    @Bindable var alarm: AlarmModel
    
    // MARK: Body
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                let textColor = alarm.isEnabled ? AppAssets.Colors.brandYellow : AppAssets.Colors.brandBlue
                let shadowColor = alarm.isEnabled ? AppAssets.Colors.brandYellow.opacity(0.3) : .clear
                
                Text(alarm.time, style: .time)
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .foregroundStyle(textColor)
                    .shadow(color: shadowColor, radius: 10)
                
                Text(alarm.label)
                    .font(.headline)
                    .foregroundStyle(.white)
                
                HStack(spacing: 6) {
                    Group {
                        Image(systemName: alarm.missionType.iconName)
                        
                        Text(alarm.missionType.title)
                        
                        Text("• L, M, M, J, V")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }
            }
            
            Spacer()
            
            Toggle("", isOn: $alarm.isEnabled)
                .labelsHidden()
                .tint(AppAssets.Colors.brandYellow)
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 24)
            .fill(Color(red: 0.11,
                        green: 0.11,
                        blue: 0.12)))
        .overlay(RoundedRectangle(cornerRadius: 24)
            .stroke(alarm.isEnabled ? AppAssets.Colors.brandYellow : AppAssets.Colors.brandBlue,
                    lineWidth: 2)
            .shadow(color: alarm.isEnabled ? AppAssets.Colors.brandYellow.opacity(0.5) : .clear,
                    radius: 8,
                    x: 0,
                    y: 0))
        .padding(.horizontal)
        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: alarm.isEnabled)
    }
}

#Preview {
    @Previewable @State var alarm = AlarmModel(id: UUID(), time: Date(), label: "Morning routine", isEnabled: false, difficultyLevel: 1)
    AlarmCardView(alarm: alarm)
}
