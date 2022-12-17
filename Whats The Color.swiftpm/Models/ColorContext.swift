import Foundation

enum ColorContext: Int {
    // Protanopia and deuteranopia.
    case redGreen
    // Deuteranomaly.
    case greenLooksRed
    // Protanomaly.
    case redLooksGreen
    // Tritanomaly.
    case blueGreen
    case redYellow
    // Tritanopia.
    case redPurple
    case pinkYellow
    
    var name: String {
        switch self {
        case .redGreen:
            return "Red green"
        case .greenLooksRed:
            return "Green looks red"
        case .redLooksGreen:
            return "Red looks green"
        case .blueGreen:
            return "Blue green"
        case .redYellow:
            return "Red yellow"
        case .redPurple:
            return "Red purple"
        case .pinkYellow:
            return "Pink yellow"
        }
    }
}
