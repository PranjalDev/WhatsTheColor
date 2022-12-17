import SwiftUI

struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.restrictToPortrait) var restrictToPortrait
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    GroupBox {
                        VStack(alignment: .leading, spacing: 16) {
                            VStack {
                                Label("Color blindness", systemImage: "eyes.inverse")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                Group{
                                    Text(ColorBlindness.info)
                                    Text("Types of color blindness")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                }
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color(uiColor: .secondaryLabel))
                                LazyVGrid(
                                    columns: horizontalSizeClass == .regular ? [GridItem(), GridItem(), GridItem()] : [GridItem()],
                                    alignment: .leading,
                                    spacing: 16
                                ) {
                                    ForEach(ColorBlindnessType.allCases, id: \.name) { type in
                                        ColorBlindnessInfoView(
                                            colors: type.colors,
                                            name: type.name,
                                            infoMarkdown: type.details
                                        )
                                    }
                                }
                            }
                            
                        }
                        .padding(.bottom, 16)
                        GroupBox {
                            VStack(spacing: 16) {
                                GroupBoxNavigationLink(
                                    title: "Color Recogniser",
                                    systemImage: "camera",
                                    subtitle: "We have created a color detection camera, which helps people with color blindness to understand colors around them."
                                ) {
                                    ColorRecogniserView(restrictToPortrait: restrictToPortrait)
                                        .edgesIgnoringSafeArea(.all)
                                        
                                }
                                GroupBoxNavigationLink(
                                    title: "Color Blindness Test",
                                    systemImage: "square.grid.3x3.square",
                                    subtitle: "We have created a test to diagnose potential color blindness to educate people more about the types of color blindness they have and how it affects their color perception."
                                ) {
                                    ColorTestView()
                                }
                                
                            }
                            .fixedSize(horizontal: false, vertical: true)
                        } label: {
                            Label("Tools and tests", systemImage: "gamecontroller.fill")
                        }
                        .shadow(radius: 8)
                        
                    }
                }
                .buttonStyle(.plain)
                .padding()
                .navigationBarTitle("What's the Color")
                .navigationBarTitleDisplayMode(.inline)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}



