
import SwiftUI

struct TestLevelView: View {
    
    let testLevel: TestLevel
    let interItemSpacing: CGFloat = 10
    let colomCount = 3
    
    let formatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.spellOut
        return numberFormatter
    }()
    
    @Binding var selection: Set<ColorChoice>
    @State var error: String? = nil
    @Binding var scale: CGFloat
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let action: () -> Void
    
    var questionView: some View {
        GroupBox {
            (
                Text("Pick ") +
                Text(formatter.string(from: testLevel.correctChoiceCount as NSNumber) ?? "\(testLevel.correctChoiceCount)") +
                Text(" ") +
                Text("\(testLevel.colorTypeToPick.rawValue)")
                    .underline()
                    .bold()
                +
                Text(" colors")
            )
            .font(
                .system(
                    size: horizontalSizeClass == .regular ? 48 : 24,
                    weight: .regular,
                    design: .rounded
                )
            )
            .foregroundColor(Color.primary)
            .frame(maxWidth: .infinity)
        }
    }
    
    var gridView: some View {
        GroupBox {
            GeometryReader { geo in
                ZStack {
                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(
                                .fixed(
                                    getSizeForColor(containerWidth: geo.size.width)),
                                spacing: interItemSpacing
                            ),
                            count: colomCount
                        ),
                        spacing: interItemSpacing
                    ) {
                        ForEach(testLevel.choices) { choice in
                            ColorGridButton(color: choice.color) { isSelected in
                                withAnimation(.easeIn(duration: 0.3)) {
                                    if isSelected {
                                        selection.insert(choice)
                                    } else {
                                        if selection.contains(choice) {
                                            selection.remove(choice)
                                        }
                                    }
                                }
                            }
                            .disabled(selection.count >= testLevel.correctChoiceCount && !selection.contains(choice))
                        }
                        .scaleEffect(scale)
                    }
                    .disabled(error != nil)
                    .blur(radius: error == nil ? 0 : 20)
                    if let error = error {
                        Text(error)
                            .font(.largeTitle)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .transition(
                                .asymmetric(
                                    insertion: .scale,
                                    removal: .scale.combined(with: .opacity)
                                )
                            )
                    }
                }
            }
            .aspectRatio(1, contentMode: .fit)
        }
    }
    
    var actionView: some View {
        Button {
            if selection.count < testLevel.correctChoiceCount {
                withAnimation {
                    error = "Select atleast \(testLevel.correctChoiceCount)"
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        self.error = nil
                    }
                }
            } else {
                action()
            }
        } label: {
            Text("Submit")
                .frame(
                    maxWidth: .infinity,
                    minHeight: horizontalSizeClass == .regular ? 44 : 38
                )
                .font(horizontalSizeClass == .regular ? .title : .headline)
        }
        .buttonStyle(.borderedProminent)
        .padding(.bottom, 24)
        .disabled(error != nil)
        
    }
    
    var progressView: some View {
        HStack {
            ForEach(testLevel.correctChoicesIndexedArray, id: \.1.id) { colorChoiceIndexTuple in
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(uiColor: UIColor.secondarySystemFill))
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: 4)
                            .frame(
                                width: geo.size.width * (
                                    colorChoiceIndexTuple.0 < selection.count ? 1 : 0
                                ),
                                height: 8,
                                alignment: .leading
                            )
                    }
                }
                .frame(height: 8)
            }
        }
        .padding(.horizontal, 2)
    }
    
    var body: some View {
        VStack(spacing: 24) {
            questionView
            progressView
            gridView
            actionView
        }
    }
    
    func getSizeForColor(containerWidth: CGFloat) -> CGFloat {
        let availableSize = containerWidth - (CGFloat(colomCount-1)*interItemSpacing)
        return availableSize/CGFloat(colomCount)
    }
    
}
