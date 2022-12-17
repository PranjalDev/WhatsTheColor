import Foundation
import Combine

class ColorTestViewModel: ObservableObject {
    
    let test: ColorBlindnessTest
    
    @Published var currentTestIndex = 0
    @Published var currentTestSelection = Set<ColorChoice>()
    @Published var isTestEnded: Bool = false
    
    var currentTestLevel: TestLevel {
        test.levels[currentTestIndex]
    }
    var result: [TestLevelResult] = []
    
    var levelText: String {
        if currentTestIndex < test.levels.count {
            return "\(currentTestIndex + 1)/\(test.levels.count)"
        } else {
            return ""
        }
    }
    
    init(test: ColorBlindnessTest) {
        self.test = test
    }
    
    func getResult(forLevel level: TestLevel, selection: Set<ColorChoice>) -> TestLevelResult {
        let correctChoiceCount = level.correctChoiceCount
        let selectedCorrectCount = selection.filter({ $0.type == level.colorTypeToPick }).count
        return TestLevelResult(context: level.colorContext, accurancy: Float(selectedCorrectCount)/Float(correctChoiceCount))
    }
    
    func moveToNextTest() {
        guard currentTestIndex <= test.levels.count - 1 else { return }
        let currentResult = getResult(forLevel: currentTestLevel, selection: currentTestSelection)
        result.append(currentResult)
        currentTestSelection.removeAll()
        currentTestIndex += 1
        if currentTestIndex == test.levels.count {
            isTestEnded = true
            
        }
    }
    
    func checkAndProduceHaptic() {
        
    }
        
    func reset() {
        isTestEnded = false
        currentTestIndex = 0
        result = []
    }
}
