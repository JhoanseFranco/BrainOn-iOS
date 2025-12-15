//
//  KeypadButton.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 14/12/25.
//

import SwiftUI

struct KeypadButton: View {
    
    // MARK: Properties
    
    var label: String?
    var systemIcon: String?
    var backgroundColor = Color.white.opacity(0.15)
    var foregroundColor = Color.white
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(backgroundColor)
                
                if let label {
                    Text(label)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(foregroundColor)
                } else if let systemIcon {
                    Image(systemName: systemIcon)
                        .font(.title2)
                        .foregroundStyle(foregroundColor)
                }
            }
            .frame(height: 80)
        }

    }
}

#Preview {
    KeypadButton(label: "label", backgroundColor: AppAssets.Colors.brandYellow, action: {})
}
