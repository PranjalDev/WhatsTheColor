//
//  What_s_that_ColorApp.swift
//  What's that Color
//
//  Created by Pranjal Verma on 17/12/22.
//

import SwiftUI

@main
struct What_s_that_ColorApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.restrictToPortrait, appDelegate.restrictToPortrait(_:))
        }
    }
}
