import Foundation
import SwiftUI

enum ColorBlindness {
    static let info: String  = "\nColor blindness occurs when you are unable to see colors in a normal way. It is also known as color deficiency. Color blindness often happens when someone cannot distinguish between certain colors. This usually happens between greens and reds, and occasionally blues.\n\nColor blindness (or, more accurately, color vision deficiency) is an inherited condition that affects males more frequently than females.\n\nMost people who are considered \"color blind\" can see colors, but certain colors appear washed out and are easily confused with other colors, depending on the type of color vision deficiency they have.\n\nThe most common type of color blindness makes it hard to tell the difference between red and green. Another type makes it hard to tell the difference between blue and yellow. People who are completely color blind don’t see color at all, but that’s not very common.\n"
}

extension Color {
    static func rgb(_ r: Double, _ g: Double, _ b: Double) -> Color {
        return Color(uiColor: UIColor.init(r, g, b))
    }
}

extension UIColor {
    convenience init(_ r: Double, _ g: Double, _ b: Double) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

let test = ColorBlindnessTest(levels: [
    TestLevel(colorTypeToPick: .red, colorContext: .redGreen, choices: [
        ColorChoice(color: .rgb(189, 32, 0), type: .red),
        ColorChoice(color: .rgb(250, 30, 14), type: .red),
        ColorChoice(color: .rgb(255, 24, 24), type: .red),
        ColorChoice(color: .rgb(255, 99, 99), type: .red),
        ColorChoice(color: .rgb(205, 24, 24), type: .red),
        ColorChoice(color: .rgb(242, 74, 114),type: .red),
        ColorChoice(color: .rgb(78, 148, 79), type: .green),
        ColorChoice(color: .rgb(131, 189, 117), type: .green),
        ColorChoice(color: .rgb(180, 225, 151), type: .green)
    ]),
    TestLevel(colorTypeToPick: .green, colorContext: .redGreen, choices: [
        ColorChoice(color: .rgb(34, 139, 34), type: .green),
        ColorChoice(color: .rgb(124, 252, 0), type: .green),
        ColorChoice(color: .rgb(0, 128, 0), type: .green),
        ColorChoice(color: .rgb(136, 8, 8), type: .red),
        ColorChoice(color: .rgb(253, 93, 93), type: .red),
        ColorChoice(color: .rgb(136, 8, 8), type: .red),
        ColorChoice(color: .rgb(178, 6, 0), type: .red),
        ColorChoice(color: .rgb(238, 75, 43), type: .red),
        ColorChoice(color: .rgb(210, 43, 43), type: .red)
    ]),
    TestLevel(colorTypeToPick: .red, colorContext: .redLooksGreen, choices: [
        ColorChoice(color: .rgb(238, 75, 43), type: .red),
        ColorChoice(color: .rgb(170, 255, 0), type: .green),
        ColorChoice(color: .rgb(210, 43, 43), type: .red),
        ColorChoice(color: .rgb(80, 200, 120), type: .green),
        ColorChoice(color: .rgb(220, 20, 60), type: .red),
        ColorChoice(color: .rgb(124, 252, 0), type: .green),
        ColorChoice(color: .rgb(210, 4, 45), type: .red),
        ColorChoice(color: .rgb(0, 128, 0), type: .green),
        ColorChoice(color: .rgb(215, 0, 64), type: .red)
    ]),
    TestLevel(colorTypeToPick: .green, colorContext: .greenLooksRed, choices: [
        ColorChoice(color: .rgb(210, 43, 43), type: .red),
        ColorChoice(color: .rgb(80, 200, 120), type: .green),
        ColorChoice(color: .rgb(196, 30, 58), type: .red),
        ColorChoice(color: .rgb(124, 252, 0), type: .green),
        ColorChoice(color: .rgb(215, 0, 64), type: .red),
        ColorChoice(color: .rgb(9, 121, 105), type: .green),
        ColorChoice(color: .rgb(210, 43, 43), type: .red),
        ColorChoice(color: .rgb(11, 218, 81), type: .green),
        ColorChoice(color: .rgb(210, 4, 45), type: .red)
    ]),
    TestLevel(colorTypeToPick: .red, colorContext: .redLooksGreen, choices: [
        ColorChoice(color: .rgb(255, 49, 49), type: .red),
        ColorChoice(color: .rgb(50, 205, 50), type: .green),
        ColorChoice(color: .rgb(220, 20, 60), type: .red),
        ColorChoice(color: .rgb(170, 255, 0), type: .green),
        ColorChoice(color: .rgb(210, 4, 45), type: .red),
        ColorChoice(color: .rgb(124, 252, 0), type: .green),
        ColorChoice(color: .rgb(227, 11, 92), type: .red),
        ColorChoice(color: .rgb(76, 187, 23), type: .green),
        ColorChoice(color: .rgb(220, 20, 60), type: .red)
    ]),
    TestLevel(colorTypeToPick: .green, colorContext: .greenLooksRed, choices: [
        ColorChoice(color: .rgb(136, 8, 8), type: .red),
        ColorChoice(color: .rgb(15, 255, 80), type: .green),
        ColorChoice(color: .rgb(238, 75, 43), type: .red),
        ColorChoice(color: .rgb(80, 200, 120), type: .green),
        ColorChoice(color: .rgb(165, 42, 42), type: .red),
        ColorChoice(color: .rgb(34, 139, 34), type: .green),
        ColorChoice(color: .rgb(128, 0, 32), type: .red),
        ColorChoice(color: .rgb(0, 128, 0), type: .green),
        ColorChoice(color: .rgb(210, 43, 43), type: .red)
    ]),
    TestLevel(colorTypeToPick: .blue, colorContext: .blueGreen, choices: [
        ColorChoice(color: .rgb(63, 0, 255), type: .blue),
        ColorChoice(color: .rgb(11, 218, 81), type: .green),
        ColorChoice(color: .rgb(0, 0, 139), type: .blue),
        ColorChoice(color: .rgb(0, 255, 127), type: .green),
        ColorChoice(color: .rgb(65, 105, 225), type: .blue),
        ColorChoice(color: .rgb(76, 187, 23), type: .green),
        ColorChoice(color: .rgb(0, 0, 255), type: .blue),
        ColorChoice(color: .rgb(50, 205, 50), type: .green),
        ColorChoice(color: .rgb(135, 206, 235), type: .blue)
    ]),
    TestLevel(colorTypeToPick: .green, colorContext: .blueGreen, choices: [
        ColorChoice(color: .rgb(63, 0, 255), type: .blue),
        ColorChoice(color: .rgb(0, 128, 0), type: .green),
        ColorChoice(color: .rgb(63, 0, 255), type: .blue),
        ColorChoice(color: .rgb(0, 255, 127), type: .green),
        ColorChoice(color: .rgb(0, 150, 255), type: .blue),
        ColorChoice(color: .rgb(46, 139, 87), type: .green),
        ColorChoice(color: .rgb(0, 0, 139), type: .blue),
        ColorChoice(color: .rgb(15, 255, 80), type: .green),
        ColorChoice(color: .rgb(0, 0, 255), type: .blue)
    ]),
    TestLevel(colorTypeToPick: .red, colorContext: .redYellow, choices: [
        ColorChoice(color: .rgb(224, 17, 95), type: .red),
        ColorChoice(color: .rgb(250, 250, 51), type: .yellow),
        ColorChoice(color: .rgb(255, 68, 51), type: .red),
        ColorChoice(color: .rgb(255, 234, 0), type: .yellow),
        ColorChoice(color: .rgb(210, 43, 43), type: .red),
        ColorChoice(color: .rgb(253, 218, 13), type: .yellow),
        ColorChoice(color: .rgb(255, 0, 0), type: .red),
        ColorChoice(color: .rgb(255, 255, 0), type: .yellow),
        ColorChoice(color: .rgb(224, 17, 95), type: .red)
    ]),
    TestLevel(colorTypeToPick: .yellow, colorContext: .redYellow, choices: [
        ColorChoice(color: .rgb(255, 49, 49), type: .red),
        ColorChoice(color: .rgb(255, 255, 0), type: .yellow),
        ColorChoice(color: .rgb(220, 20, 60), type: .red),
        ColorChoice(color: .rgb(255, 234, 0), type: .yellow),
        ColorChoice(color: .rgb(255, 68, 51), type: .red),
        ColorChoice(color: .rgb(252, 245, 95), type: .yellow),
        ColorChoice(color: .rgb(210, 4, 45), type: .red),
        ColorChoice(color: .rgb(255, 215, 0), type: .yellow),
        ColorChoice(color: .rgb(222, 49, 99), type: .red)
    ]),
    TestLevel(colorTypeToPick: .red, colorContext: .redPurple, choices: [
        ColorChoice(color: .rgb(255, 68, 51), type: .red),
        ColorChoice(color: .rgb(191, 64, 191), type: .purple),
        ColorChoice(color: .rgb(255, 36, 0), type: .red),
        ColorChoice(color: .rgb(128, 0, 128), type: .purple),
        ColorChoice(color: .rgb(255, 49, 49), type: .red),
        ColorChoice(color: .rgb(203, 195, 227), type: .purple),
        ColorChoice(color: .rgb(220, 20, 60), type: .red),
        ColorChoice(color: .rgb(195, 177, 225), type: .purple),
        ColorChoice(color: .rgb(255, 49, 49), type: .red)
    ]),
    TestLevel(colorTypeToPick: .purple, colorContext: .redPurple, choices: [
        ColorChoice(color: .rgb(210, 43, 43), type: .red),
        ColorChoice(color: .rgb(128, 0, 128), type: .purple),
        ColorChoice(color: .rgb(215, 0, 64), type: .red),
        ColorChoice(color: .rgb(195, 177, 225), type: .purple),
        ColorChoice(color: .rgb(210, 4, 45), type: .red),
        ColorChoice(color: .rgb(191, 64, 191), type: .purple),
        ColorChoice(color: .rgb(220, 20, 60), type: .red),
        ColorChoice(color: .rgb(207, 159, 255), type: .purple),
        ColorChoice(color: .rgb(255, 0, 0), type: .red)
    ]),

    TestLevel(colorTypeToPick: .pink, colorContext: .pinkYellow, choices: [
        ColorChoice(color: .rgb(255, 0, 255), type: .pink),
        ColorChoice(color: .rgb(255, 191, 0), type: .yellow),
        ColorChoice(color: .rgb(255, 105, 180), type: .pink),
        ColorChoice(color: .rgb(250, 250, 51), type: .yellow),
        ColorChoice(color: .rgb(255, 16, 240), type: .pink),
        ColorChoice(color: .rgb(255, 255, 0), type: .yellow),
        ColorChoice(color: .rgb(218, 112, 214), type: .pink),
        ColorChoice(color: .rgb(252, 245, 95), type: .yellow),
        ColorChoice(color: .rgb(255, 255, 143), type: .yellow)
    ]),
    TestLevel(colorTypeToPick: .yellow, colorContext: .pinkYellow, choices: [
        ColorChoice(color: .rgb(218, 112, 214), type: .pink),
        ColorChoice(color: .rgb(252, 245, 95), type: .yellow),
        ColorChoice(color: .rgb(255, 16, 240), type: .pink),
        ColorChoice(color: .rgb(250, 250, 51), type: .yellow),
        ColorChoice(color: .rgb(255, 105, 180), type: .pink),
        ColorChoice(color: .rgb(255, 255, 143), type: .yellow),
        ColorChoice(color: .rgb(255, 0, 255), type: .pink),
        ColorChoice(color: .rgb(255, 191, 0), type: .yellow),
        ColorChoice(color: .rgb(255, 234, 0), type: .yellow)
    ]),
])
