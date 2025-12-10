//
//  SettingsView.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 10/12/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            ZStack{
                AppAssets.Colors.brandBackground
                    .ignoresSafeArea()
                
                Text(CommonStrings.settings)
                    .foregroundStyle(.white)
            }
            .navigationTitle(Text(CommonStrings.settings))
        }
    }
}

#Preview {
    SettingsView()
}
