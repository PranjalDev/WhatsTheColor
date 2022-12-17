import Foundation

struct TestAverageResult {
    
    var colorBlindnessTypeArray: [(colorBlindnessType: ColorBlindnessType, percentage: Float)]
    var colorContextArray: [(context: ColorContext, percentage: Float)] = []
    var mostProbableBlindness: (colorBlindnessType: ColorBlindnessType, percentage: Float)?
    
    init(result: [TestLevelResult]) {
        let groupedContent = Dictionary(grouping: result, by: \.context)
        var tempMap: [ColorContext: Float] = [:]
        for (key, value) in groupedContent {
            let sumOfInverseAccurancy = value.reduce(Float(0), { $0 + $1.inverseAccurancy })
            tempMap[key] = sumOfInverseAccurancy / Float(value.count)
        }
        self.colorContextArray = tempMap
            .sorted(by: {
                $0.key.rawValue < $1.key.rawValue
        })
        .map({ (key: ColorContext, value: Float) in
            return (context: key, percentage: value)
        })
        var mostProbableBlindness: (colorBlindnessType: ColorBlindnessType, percentage: Float)?
        self.colorBlindnessTypeArray = ColorBlindnessType.allCases.compactMap({ type in
            let percentages = type.colorContexts.map { context in
                tempMap[context] ?? 0
            }
            let percentage = percentages.reduce(0.0, {$0 + $1})/Float(percentages.count)
            if percentage <= 0 {
                return nil
            }
            let blindness = (colorBlindnessType: type, percentage: percentage)
            if mostProbableBlindness?.percentage ?? 0 < percentage {
                mostProbableBlindness = blindness
            }
            return blindness
        })
        self.mostProbableBlindness = mostProbableBlindness
    }
}
