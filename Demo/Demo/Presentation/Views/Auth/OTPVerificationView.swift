import Combine
import SwiftUI

struct OTPVerificationView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject private var viewModel = DIContainer.shared.makeAuthViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Enter OTP")
                .font(.largeTitle)
                .bold()
            
            Text("Please enter the OTP (Static: 1234)")
                .foregroundColor(.gray)
            
            TextField("OTP", text: $viewModel.otp)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .font(.title)
                .padding(.horizontal, 50)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Button("Verify") {
                viewModel.verifyOTP()
            }
            .disabled(viewModel.isLoading || viewModel.otp.isEmpty)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
            
            if viewModel.isLoading {
                ProgressView()
            }
            
            Spacer()
        }
        .padding()
        .onChange(of: viewModel.isOTPVerified) { success in
            if success {
                coordinator.navigate(to: .login)
            }
        }
        .navigationTitle("OTP")
    }
}
