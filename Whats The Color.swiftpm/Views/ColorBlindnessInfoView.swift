import SwiftUI

struct ColorBlindnessInfoView: View {
    
    let colors: [Color]
    let name: String
    let infoMarkdown: String
    
    @State var isPopOverShown: Bool = false
    
    @ViewBuilder
    var markdownView: some View {
        if let markdownAttr = try? AttributedString(markdown: infoMarkdown, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)) {
            GroupBox {
                Text(markdownAttr)
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 100,
                        maxHeight: 300
                    )
            }
            .padding()
            .transition(.scale)
        }
    }
    
    var body: some View {
        GroupBox {
            HStack(spacing: 8) {
                ColorBlindnessIconView(colors: colors)
                Text(name)
                    .bold()
                    .lineLimit(1)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                Button {
                    isPopOverShown = true
                } label: {
                    Image(systemName: "info.circle")
                }
                .buttonStyle(.borderless)
                .popover(isPresented: $isPopOverShown.animation()) {
                    markdownView
                }
            }
        }
    }
}
