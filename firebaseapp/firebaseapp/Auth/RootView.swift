//
//  RootView.swift
//  firebaseapp
//
//  Created by Cam on 3/3/25.
//

import SwiftUI

struct RootView: View {
    
    // State variable to track whether the settings (or authentication) screen should be shown.
    @State private var showSettings: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                // SettingsView is the main content view, but it depends on authentication status.
                SettingsView(showSignInView: $showSettings)
            }
        }
        .onAppear {
            // Check if there is an authenticated user when the view appears.
            // If no user is found, trigger the sign-in view.
            let authUser = try? AuthManager.shared.getAuthenticatedUser()
            self.showSettings = authUser == nil
        }
        .fullScreenCover(isPresented: $showSettings) {
            // If authentication is required, show the AuthView as a full-screen modal.
            NavigationStack {
                AuthView()
            }
        }
    }
}

// Preview provider to allow SwiftUI previews in Xcode.
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
