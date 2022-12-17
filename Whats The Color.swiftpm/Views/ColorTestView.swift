
import SwiftUI

struct ColorTestView: View {
    
    let interItemSpacing: CGFloat = 10
    let colomCount = 3
    @ObservedObject var viewModel = ColorTestViewModel(test: test)
    @State var instructionViewPresented: Bool = false
    @State var scale: CGFloat = 0.5
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack(spacing: 24) {
            if viewModel.isTestEnded {
                TestResultView(result: viewModel.result)
            } else {
                TestLevelView(
                    testLevel: viewModel.currentTestLevel,
                    selection: $viewModel.currentTestSelection,
                    scale: $scale
                ) {
                    viewModel.moveToNextTest()
                    scale = 0.5
                    withAnimation {
                        scale = 1
                    }
                }
                .onAppear {
                    withAnimation {
                        scale = 1
                    }
                }
            }
        }
        .padding(.horizontal, 24)
        .navigationTitle(viewModel.isTestEnded ? "Test Result" : "Color Blindness Test \(viewModel.levelText)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            instructionViewPresented.toggle()
        })
        .onDisappear {
            viewModel.reset()
        }
        .sheet(isPresented: $instructionViewPresented) {
            ColorTestInstructionView(instructionViewPresented: $instructionViewPresented)
        }
    }
}


struct ColorTestPreviews: PreviewProvider {
    static var previews: some View {
        ColorTestView()
    }
}

