import SwiftUI

struct GroupBoxNavigationLink<Destination: View>: View {
        
    let title: String
    let systemImage: String
    let subtitle: String
    let destination: Destination

    init(title: String, systemImage: String, subtitle: String, _ destination: Destination) {
        self.destination = destination
        self.title = title
        self.systemImage = systemImage
        self.subtitle = subtitle
    }
    
    init(title: String, systemImage: String, subtitle: String, @ViewBuilder _ destination: (() -> Destination)) {
        self.destination = destination()
        self.title = title
        self.systemImage = systemImage
        self.subtitle = subtitle
    }
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            GroupBox {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Label(title, systemImage: systemImage)
                            .font(.headline)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .aspectRatio(1, contentMode: .fill)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
    }
}
