//
//  AlarmsHeaderView.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 10/12/25.
//

import SwiftUI

struct AlarmsHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: AppAssets.Icons.brain)
                    .font(.title2)
                    .foregroundStyle(AppAssets.Colors.brandYellow)
                
                Text(AlarmsStrings.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(AppAssets.Colors.brandBlue)
                
                Spacer()
            }
            
            Text("Good Morning, Dev!")
                .font(.subheadline)
                .foregroundStyle(.gray)
            
            Text(Date().formatted(date: .complete, time: .omitted))
                .font(.caption)
                .foregroundStyle(.gray.opacity(0.6))
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

#Preview {
    AlarmsHeaderView()
}
