//
//  WhatsTheColorApp.swift
//  WhatsTheColor
//
//  Created by Pranjal Verma on 17/12/22.
//

import SwiftUI

@main
struct WhatsTheColorApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.restrictToPortrait, appDelegate.restrictToPortrait(_:))
        }
    }
}
