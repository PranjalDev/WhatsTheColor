//
//  AppDelegate.swift
//  What's The Color
//
//  Created by Pranjal Verma on 17/12/22.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var restrictedRotation: UIInterfaceOrientationMask = .all
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return restrictedRotation
    }
    
    func restrictToPortrait(_ bool: Bool) {
        if bool {
            print("Setting potrait only")
            restrictedRotation = .portrait
        } else {
            print("Setting all")
            restrictedRotation = .all
        }
    }
}
