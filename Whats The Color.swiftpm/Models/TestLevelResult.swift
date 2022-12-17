import Foundation

struct TestLevelResult: Identifiable {
    let id = UUID()
    let context: ColorContext
    let accurancy: Float
    var inverseAccurancy: Float {
        Float(1) - accurancy
    }
}
