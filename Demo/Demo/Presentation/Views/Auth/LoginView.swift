import Combine
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject private var viewModel = DIContainer.shared.makeAuthViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .bold()
            
            TextField("Email (abc@gmail.com)", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            SecureField("Password (Abc@123)", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
            
            Button("Login") {
                viewModel.login()
            }
            .disabled(viewModel.isLoading)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            HStack {
                Button("Forgot Password?") {
                    coordinator.navigate(to: .forgotPassword)
                }
                Spacer()
                Button("Sign Up") {
                    coordinator.navigate(to: .signup)
                }
            }
            .padding(.top)
            
            if viewModel.isLoading {
                ProgressView()
            }
            
            Spacer()
        }
        .padding()
        .onChange(of: viewModel.isLoggedIn) { isLoggedIn in
            if isLoggedIn {
                coordinator.navigate(to: .mainTab)
            }
        }
        .navigationBarHidden(true)
    }
}
