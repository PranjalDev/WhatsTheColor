import Foundation

struct TestLevel {
    let colorTypeToPick: ColorType
    let colorContext: ColorContext
    let choices: [ColorChoice]
    let correctChoicesIndexedArray: [(Int,ColorChoice)]
    var correctChoiceCount: Int {
        correctChoicesIndexedArray.count
    }
    
    init(colorTypeToPick: ColorType, colorContext: ColorContext, choices: [ColorChoice]) {
        self.colorTypeToPick = colorTypeToPick
        self.colorContext = colorContext
        self.choices = choices.shuffled()
        let correctChoices = choices.filter({ $0.type == colorTypeToPick})
        var correctChoicesIndexedArray: [(Int,ColorChoice)] = []
        for index in 0..<correctChoices.count {
            correctChoicesIndexedArray.append((index, correctChoices[index]))
        }
        self.correctChoicesIndexedArray = correctChoicesIndexedArray
    }
}
