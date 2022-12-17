import Foundation
import SwiftUI

enum ColorBlindnessType: Int, CaseIterable {
    
    // Red-Green
    case deuteranomaly
    case protanomaly
    case protanopiaAndDeuteranopia
    
    // Blue-yellow
    case tritanomaly
    case tritanopia
    
    var name: String {
        switch self {
        case .deuteranomaly:
            return "Deuteranomaly"
        case .protanomaly:
            return "Protanomaly"
        case .protanopiaAndDeuteranopia:
            return "Protanopia & Deuteranopia"
        case .tritanomaly:
            return "Tritanomaly"
        case .tritanopia:
            return "Tritanopia"
        }
    }
    
    var colors: [Color] {
        switch self {
        case .deuteranomaly, .protanomaly, .protanopiaAndDeuteranopia:
            return [.red, .green]
        case .tritanomaly:
            return [.blue, .green, .red, .yellow]
        case .tritanopia:
            return [.blue, .green, .red, .purple, .pink, .yellow]
        }
    }
    
    var presentingColorContexts: [ColorContext] {
        switch self {
        case .deuteranomaly:
            return [.greenLooksRed]
        case .protanomaly:
            return [.redLooksGreen]
        case .protanopiaAndDeuteranopia:
            return [.redGreen]
        case .tritanomaly:
            return [.blueGreen, .redYellow]
        case .tritanopia:
            return [.blueGreen, .redPurple, .pinkYellow]
        }
    }
    
    var colorContexts: [ColorContext] {
        switch self {
        case .deuteranomaly:
            return [.greenLooksRed]
        case .protanomaly:
            return [.redLooksGreen]
        case .protanopiaAndDeuteranopia:
            return [.redGreen, .redLooksGreen, .greenLooksRed]
        case .tritanomaly:
            return [.blueGreen, .redYellow]
        case .tritanopia:
            return [.blueGreen, .redPurple, .pinkYellow]
        }
    }
    
    var details: String {
        switch self {
        case .deuteranomaly:
            return """
It is the most common type of red-green color blindness. It makes green look more red. This type is mild and doesn’t usually get in the way of normal activities.
"""
        case .protanomaly:
            return """
It makes red look more green and less bright. This type is mild and usually doesn’t get in the way of normal activities.
"""
        case .protanopiaAndDeuteranopia:
            return """
`Protanopia` and `deuteranopia` both make you unable to tell the difference between red and green at all.
"""
        case .tritanomaly:
            return """
This type of color blindness makes it hard to tell the difference between blue and green, and between yellow and red.
"""
        case .tritanopia:
            return """
This type of color blindness makes you unable to tell the difference between blue and green, purple and red, and yellow and pink. It also makes colors look less bright.
"""
        }
    }
}
