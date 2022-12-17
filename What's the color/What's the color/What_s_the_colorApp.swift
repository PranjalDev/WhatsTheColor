//
//  What_s_the_colorApp.swift
//  What's the color
//
//  Created by Pranjal Verma on 17/12/22.
//

import SwiftUI

@main
struct What_s_the_colorApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.restrictToPortrait, appDelegate.restrictToPortrait(_:))
        }
    }
}
