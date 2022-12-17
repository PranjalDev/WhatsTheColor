import SwiftUI

struct TestResultView: View {
    
    let testAverageResult: TestAverageResult
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    init(result: [TestLevelResult]) {
        testAverageResult = TestAverageResult(result: result)
    }
    
    var body: some View {
        
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                if let blidness = testAverageResult.mostProbableBlindness {
                    GroupBox("You may have following color blindness") {
                        GroupBox{
                            HStack {
                                Text(blidness.colorBlindnessType.name)
                                    .font(.largeTitle)
                                    .minimumScaleFactor(0.5)
                                    .lineLimit(1)
                                Spacer()
                                CircularProgressView(progress: blidness.percentage)
                            }
                        }
                    }
                } else {
                    GroupBox{
                        Text("You do not have any color blidness")
                            .font( horizontalSizeClass == .regular ? .largeTitle : .title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                
                if testAverageResult.colorBlindnessTypeArray.isEmpty == false {
                    GroupedGridView(data: testAverageResult.colorBlindnessTypeArray, id: \.colorBlindnessType, gridColumCount: 3, title: "Color Blindness Type") { result in
                        
                        VStack(alignment: .leading, spacing: 16) {
                            HStack(alignment: .center, spacing: 16) {
                                CircularProgressView(progress: result.percentage)
                                VStack(alignment: .leading) {
                                    Text(result.colorBlindnessType.name)
                                        .font(.headline)
                                        .lineLimit(1)
                                    Text(ListFormatter.localizedString(byJoining: result.colorBlindnessType.presentingColorContexts.map(\.name)))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .lineLimit(1)
                                }
                            }
                            if let markdownAttr = try? AttributedString(markdown: result.colorBlindnessType.details, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)) {
                                GroupBox {
                                    Text(markdownAttr)
                                        .frame(height: 160, alignment: .topLeading)
                                    
                                }
                            }
                        }
                        .frame(height: 240, alignment: .topLeading)
                    }
                }
                
                if testAverageResult.colorContextArray.isEmpty == false {
                    GroupedGridView(data: testAverageResult.colorContextArray, id: \.context, gridColumCount: 3, title: "Color Defects") { result in
                        HStack {
                            Text(result.context.name)
                            Spacer()
                            CircularProgressView(progress: result.percentage)
                        }
                    }
                }
            }
            .padding(24)
        }
    }
}
