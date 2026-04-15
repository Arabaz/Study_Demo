import Combine
import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject private var viewModel = DIContainer.shared.makeAuthViewModel()
    @State private var showingAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Forgot Password")
                .font(.largeTitle)
                .bold()
            
            TextField("Enter your registered email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Button("Reset Password") {
                viewModel.forgotPassword()
            }
            .disabled(viewModel.isLoading)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            if viewModel.isLoading {
                ProgressView()
            }
            
            Spacer()
        }
        .padding()
        .onChange(of: viewModel.isPasswordResetEmailSent) { success in
            if success {
                showingAlert = true
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Reset link sent to your email."),
                dismissButton: .default(Text("OK")) {
                    coordinator.goBack()
                }
            )
        }
        .navigationTitle("Reset")
    }
}
