import SwiftUI

@main
struct ColorApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.restrictToPortrait, appDelegate.restrictToPortrait(_:))
        }
    }
}
