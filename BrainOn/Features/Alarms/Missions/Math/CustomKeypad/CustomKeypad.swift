//
//  CustomKeypad.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 14/12/25.
//

import SwiftUI

struct CustomKeypad: View {
    
    // MARK: Properties
    
    let action: (KeypadKey) -> Void
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(1...9, id: \.self) { number in
                KeypadButton(label: "\(number)") {
                    action(.number("\(number)"))
                }
            }
            
            KeypadButton(systemIcon: AppAssets.Icons.deleteLeft, backgroundColor: .red) {
                action(.delete)
            }
            
            KeypadButton(label: CommonStrings.zero) {
                action(.number(CommonStrings.zero))
            }
            
            KeypadButton(systemIcon: AppAssets.Icons.checkmark, backgroundColor: AppAssets.Colors.brandYellow, foregroundColor: .black) {
                action(.check)
            }
        }
    }
}

#Preview {
    CustomKeypad(action: { _ in })
}
