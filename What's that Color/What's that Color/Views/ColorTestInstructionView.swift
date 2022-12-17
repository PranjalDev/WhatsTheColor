//
//  SwiftUIView.swift
//  
//
//  Created by Pranjal Verma on 17/12/22.
//

import SwiftUI

struct ColorTestInstructionView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Binding var instructionViewPresented: Bool
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    GroupBox {
                        Text("The color blindness test is designed to articulate probable color blindness.\n\nYou will be asked 14 color selection questions, where you will need select N number of certain type of colors out of 3X3 color grid.\n\nOnce you have selected the number of color asked, you can submit that level and progress to the next.\n\nAfter selecting colors for all 14 levels, you will be presented your result where you can check your probable color blindness and the factor that led to the conclusion.")
                            .font(.system(Font.TextStyle.title3, design: Font.Design.monospaced))
                            .padding()
                            .navigationTitle("Instruction")
                    }
                    .padding()

                }
                .safeAreaInset(edge: .bottom) {
                    Button {
                        instructionViewPresented = false
                    } label: {
                        if horizontalSizeClass == .regular {
                            Text("Continue")
                                .font(.title)
                                .bold()
                                .frame(maxWidth: .infinity, minHeight: 48)
                        } else {
                            Text("Continue")
                                .font(.headline)
                                .frame(maxWidth: .infinity, minHeight: 38)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    .background(.thinMaterial)
                }
            }
            
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ColorTestInstructionView(instructionViewPresented: .constant(true))
    }
}
