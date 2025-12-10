//
//  AlarmListView.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 10/12/25.
//

import SwiftUI

struct AlarmListView: View {
    var body: some View {
        NavigationStack{
            ZStack {
                AppAssets.Colors.brandBackground
                    .ignoresSafeArea()
                
                VStack {
                    Text(AlarmsStrings.List.empty)
                        .foregroundStyle(.white)
                }
            }
            .navigationTitle(Text(AlarmsStrings.title))
            .toolbarBackground(AppAssets.Colors.brandBackground, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

#Preview {
    AlarmListView()
}
