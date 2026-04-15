import Foundation
import Combine

class AuthViewModel: BaseViewModel {
    
    @Published var email = ""
    @Published var password = ""
    @Published var isLoggedIn = false
    
    // Signup specific fields
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var age = ""
    @Published var gender = ""
    @Published var phone = ""
    @Published var address = ""
    @Published var profileImageData: Data?
    
    @Published var otp = ""
    @Published var isSignupSuccessful = false
    @Published var isOTPVerified = false
    @Published var isPasswordResetEmailSent = false
    
    private let loginUseCase: LoginUseCaseProtocol
    private let signupUseCase: SignupUseCaseProtocol
    private let verifyOTPUseCase: VerifyOTPUseCaseProtocol
    private let forgotPasswordUseCase: ForgotPasswordUseCaseProtocol
    
    init(loginUseCase: LoginUseCaseProtocol,
         signupUseCase: SignupUseCaseProtocol,
         verifyOTPUseCase: VerifyOTPUseCaseProtocol,
         forgotPasswordUseCase: ForgotPasswordUseCaseProtocol) {
        self.loginUseCase = loginUseCase
        self.signupUseCase = signupUseCase
        self.verifyOTPUseCase = verifyOTPUseCase
        self.forgotPasswordUseCase = forgotPasswordUseCase
    }
    
    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter email and password"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let _ = try await loginUseCase.execute(email: email, password: password)
                // Simulate generating and saving token
                let dummyToken = "dummy_auth_token_123"
                KeychainManager.shared.saveToken(dummyToken)
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.isLoggedIn = true
                }
            } catch {
                handleError(error)
            }
        }
    }
    
    func signup() {
        guard !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty,
              !phone.isEmpty, !address.isEmpty, !gender.isEmpty else {
            errorMessage = "Please fill all fields"
            return
        }
        
        guard let ageInt = Int(age), ageInt > 0 else {
            errorMessage = "Please enter a valid age"
            return
        }
        
        guard profileImageData != nil else {
            errorMessage = "Please select a profile image"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        let user = User(firstName: firstName, lastName: lastName, email: email, age: ageInt, gender: gender, phone: phone, address: address, profileImageData: profileImageData)
        
        Task {
            do {
                let success = try await signupUseCase.execute(user: user)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.isSignupSuccessful = success
                }
            } catch {
                handleError(error)
            }
        }
    }
    
    func verifyOTP() {
        guard !otp.isEmpty else {
            errorMessage = "Please enter OTP"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let success = try await verifyOTPUseCase.execute(otp: otp)
                DispatchQueue.main.async {
                    self.isLoading = false
                    if success {
                        self.isOTPVerified = true
                    } else {
                        self.errorMessage = "Invalid OTP"
                    }
                }
            } catch {
                handleError(error)
            }
        }
    }
    
    func forgotPassword() {
        guard !email.isEmpty else {
            errorMessage = "Please enter your email"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let success = try await forgotPasswordUseCase.execute(email: email)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.isPasswordResetEmailSent = success
                }
            } catch {
                handleError(error)
            }
        }
    }
}
