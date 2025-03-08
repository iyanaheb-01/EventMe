//
//  firebaseappApp.swift
//  firebaseapp
//
//  Created by Cam on 2/28/25.

import SwiftUI
import Firebase

@main
struct firebaseappApp: App {
    
    // Use UIApplicationDelegateAdaptor to connect the AppDelegate class,
    // which is necessary for Firebase initialization.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            // RootView serves as the main entry point of the UI.
            RootView()
        }
    }
}

// AppDelegate is responsible for handling app lifecycle events,
// specifically initializing Firebase when the app launches.
class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Configure Firebase when the app starts.
        FirebaseApp.configure()
        
        return true
    }
}
