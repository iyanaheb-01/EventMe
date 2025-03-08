//
//  SignInEmailView.swift
//  firebaseapp
//
//  Created by Cam on 3/3/25.
//

import SwiftUI

// ViewModel responsible for handling email/password sign-in logic.
@MainActor
final class SignUpEmailViewModel: ObservableObject {
    // Published properties to store user input.
    @Published var email: String = ""
    @Published var password: String = ""
    
    // Function to handle user sign-in.
    func signIn() {
        // Ensure email and password are not empty before attempting sign-in.
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        Task {
            do {
                // Attempt to create/sign in the user with Firebase authentication.
                let returnedUserData = try await AuthManager.shared.createUser(email: email, password: password)
                print("Signed in user: \(returnedUserData)")
            } catch {
                print(error.localizedDescription) // Handle and display authentication errors.
            }
        }
    }
}

struct SignInEmailView: View {
    
    // ViewModel instance to manage authentication state.
    @StateObject private var viewModel = SignUpEmailViewModel()
    
    var body: some View {
        VStack {
            // Text field for email input.
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            // Secure text field for password input.
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            // Sign-in button that triggers the authentication process.
            Button {
                viewModel.signIn()
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding(10)
        .navigationTitle(Text("Sign In With Email")) // Sets navigation title.
    }
}

// Preview provider to allow SwiftUI previews in Xcode.
struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInEmailView()
        }
    }
}
