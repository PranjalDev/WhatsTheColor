//
//  SwiftUIView.swift
//  
//
//  Created by Pranjal Verma on 17/12/22.
//

import SwiftUI

struct ColorBlindnessIconView: View {
    
    let colors: [Color]
    
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.secondary)
            .frame(width: 20, height: 20)
            .overlay(
                HStack(spacing: 2) {
                    ForEach(colors, id: \.hashValue) { color in
                        color
                    }
                }
                    .frame(width: 16, height: 16)
            )
    }
}

struct ColorBlindnessIconView_Previews: PreviewProvider {
    static var previews: some View {
        ColorBlindnessIconView(colors: [.red, .blue, .green])
    }
}
