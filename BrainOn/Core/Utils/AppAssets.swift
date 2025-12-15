//
//  AppAssets.swift
//  BrainOn
//
//  Created by jhoan sebastian franco cardona on 10/12/25.
//

import SwiftUI

/// Centraliza todos los recursos visuales de la app.
/// Se usa 'enum' para evitar la instanciación accidental de esta clase utilitaria.

enum AppAssets {
    
    enum Icons {
        
        static let alarm = "alarm.fill"
        static let brain = "brain.head.profile"
        static let checkmark = "checkmark"
        static let chevronRight = "chevron.right"
        static let deleteLeft = "delete.left"
        static let math = "plus.forwardslash.minus"
        static let play = "play.fill"
        static let plus = "plus"
        static let settings = "gearshape.fill"
        static let trash = "trash"
        static let xmark = "xmark"
    }

    enum Colors {
        
        static let brandBackground = Color("BrandBackground")
        static let brandBlue = Color("BrandBlue")
        static let brandYellow = Color("BrandYellow")
    }
    
    enum Images {
        // static let logo = "BrainOnLogo"
    }
}
