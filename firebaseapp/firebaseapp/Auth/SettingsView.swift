//
//  SwiftUIView.swift
//  firebaseapp
//
//  Created by Cam on 3/3/25.
//

import SwiftUI

// ViewModel for handling user settings-related logic, specifically sign-out functionality.
@MainActor
final class SettingsViewModel: ObservableObject {
    func signOut() throws {
        // Calls the AuthManager to sign the user out.
        try AuthManager.shared.signOut()
    }
}

struct SettingsView: View {
    // ViewModel instance to manage authentication-related actions.
    @StateObject private var viewModel = SettingsViewModel()
    
    // Binding to determine whether the sign-in view should be shown.
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            // Button to handle user sign-out.
            Button("Sign Out") {
                Task {
                    do {
                        try viewModel.signOut()
                        // After signing out, update state to show the sign-in screen.
                        showSignInView = true
                    } catch {
                        print(error) // Log any errors that occur during sign-out.
                    }
                }
            }
        }
        .navigationTitle(Text("Settings")) // Sets the navigation title for the settings screen.
    }
}

// Preview provider to allow SwiftUI previews in Xcode.
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            // Passes a constant false binding for preview purposes.
            SettingsView(showSignInView: .constant(false))
        }
    }
}
