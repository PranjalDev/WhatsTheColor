import Foundation
import SwiftUI

struct ColorChoice: Identifiable, Hashable {
    let id = UUID()
    let color: Color
    let type: ColorType
}
