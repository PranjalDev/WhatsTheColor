//
//  Disclaimer.swift
//  What's that Color
//
//  Created by Pranjal Verma on 21/12/22.
//

import SwiftUI

struct DisclaimerView: View {
    
//    @Binding var disclaimerViewPresented: Bool
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(wrappedValue: false, "disclaimerPresented") var disclaimerPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    GroupBox {
                        Text("""
                    Please note that this app is intended for informational purposes only and is not a substitute for professional medical advice, diagnosis, or treatment. The results of the color blindness test provided by this app should not be used to self-diagnose any medical condition. If you have any concerns about your vision or believe you may have a color vision deficiency, __you should consult a qualified healthcare professional__. The app's test results are based on statistical data and should not be considered a definitive diagnosis of any individual's color vision. The app's developers and publishers make no warranties or representations as to the accuracy of the test results or the reliability of the app. By using this app, you agree to these terms and acknowledge that you are solely responsible for any decisions you make based on the test results.

                    We have tried to replicate the HUE test from below mentioned research:

                    https://www.nei.nih.gov/learn-about-eye-health/eye-conditions-and-diseases/color-blindness/testing-color-blindness
                    """)
                        .font(.system(Font.TextStyle.title3, design: Font.Design.monospaced))
                        .padding()
                        .navigationTitle("Disclaimer")
                        
                    }
                    .padding()
                }
                .safeAreaInset(edge: .bottom) {
                    Button {
                        disclaimerPresented = true
                        presentationMode.wrappedValue.dismiss()
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
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .background(.thinMaterial)
                }
            }
        }
    }
}

struct Disclaimer_Previews: PreviewProvider {
    static var previews: some View {
        DisclaimerView()
    }
}
