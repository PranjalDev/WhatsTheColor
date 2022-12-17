import SwiftUI

struct ColorGridButton: View {
    
    let color: Color
    let action: (_ isSelected: Bool) -> Void
    
    @State var isSelected = false
    
    var body: some View {
        Button {
            isSelected.toggle()
            action(isSelected)
            UISelectionFeedbackGenerator().selectionChanged()
        } label: {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(color)
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                    .inset(by: 2)
                    .stroke(lineWidth: isSelected ? 4.0 : 0.0)
                    .foregroundColor(isSelected ? Color.primary : Color.clear)
                )
        }
    }
}
