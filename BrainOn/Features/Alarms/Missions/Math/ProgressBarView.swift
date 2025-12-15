//
//  ProgressBarView.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 14/12/25.
//

import SwiftUI

struct ProgressBarView: View {
    
    var value: CGFloat
    var total: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundStyle(Color.gray)
                
                Rectangle()
                    .frame(width: min(CGFloat(value/total) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundStyle(value < 10 ? .red : AppAssets.Colors.brandYellow)
                    .animation(.linear, value: value)
            }
            .cornerRadius(45) // deprecated
        }
    }
}

#Preview {
    ProgressBarView(value: 2, total: 10)
}
