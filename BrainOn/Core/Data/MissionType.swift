//
//  MissionType.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 10/12/25.
//

import SwiftUICore

enum MissionType: String, CaseIterable, Codable {
    
    case math
    case memory
    
    var title: LocalizedStringKey {
        switch self {
        case .math:
            CommonStrings.math
        case .memory:
            CommonStrings.memory
        }
    }
    
    var iconName: String {
        switch self {
        case .math:
            AppAssets.Icons.math
        case .memory:
            AppAssets.Icons.math
        }
    }
}
