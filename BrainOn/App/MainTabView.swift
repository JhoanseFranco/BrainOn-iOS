//
//  MainTabView.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 10/12/25.
//

import SwiftUI

struct MainTabView: View {
    
    // MARK: Properties
    
    @State private var selectedTab = 0
    
    // MARK: Body
    
    var body: some View {
        TabView(selection: $selectedTab) {
            AlarmListView()
                .tabItem {
                    Image(systemName: AppAssets.Icons.alarm)
                    Text(CommonStrings.alarms)
                }
                .tag(0)
            
            SettingsView()
                .tabItem {
                    Image(systemName: AppAssets.Icons.settings)
                    Text(CommonStrings.settings)
                }
                .tag(1)
        }
        .preferredColorScheme(.dark)
        .tint(AppAssets.Colors.brandYellow)
    }
}

#Preview {
    MainTabView()
}
