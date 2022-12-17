import SwiftUI

struct CircularProgressView: View {
    let progress: Float
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: .init(lineWidth: 8))
                .fill(Color(uiColor: .tertiarySystemFill))
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(style: .init(lineWidth: 6, lineCap: .round))
                .fill(Color.accentColor)
            Text(String(format: "%.0f", progress * 100) + "%").font(
                .system(
                    size: 34,
                    weight: .bold,
                    design: .rounded
                )
            )
            .minimumScaleFactor(.leastNonzeroMagnitude)
            .frame(maxWidth: 34 - 12)
        }
        .frame(width: 34, height: 34)
    }
}
