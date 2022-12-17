//
//  RestrictToPortraitKey.swift
//  What's The Color
//
//  Created by Pranjal Verma on 17/12/22.
//

import SwiftUI

private struct RestrictToPortraitKey: EnvironmentKey {
    static let defaultValue: (Bool) -> Void = { _ in }
}

extension EnvironmentValues {
    var restrictToPortrait: (Bool) -> Void {
        get { self[RestrictToPortraitKey.self] }
        set { self[RestrictToPortraitKey.self] = newValue }
    }
}
