//
//  MissionType.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 10/12/25.
//

import Foundation

enum MissionType: String, CaseIterable, Codable {
    
    case math
    case memory
    
    var title: String {
        switch self {
        case .math:
            "Matemáticas" // TODO: Localizar
        case .memory:
            "Memoria"
        }
    }
    
    var iconName: String {
        switch self {
        case .math:
            "plus.forwardslash.minus" // TODO: struct que contenga imagenes estáticas
        case .memory:
            "brain.head.profile"
        }
    }
}
