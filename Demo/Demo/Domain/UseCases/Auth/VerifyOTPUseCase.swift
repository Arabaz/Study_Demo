import Foundation

protocol VerifyOTPUseCaseProtocol {
    func execute(otp: String) async throws -> Bool
}

struct VerifyOTPUseCase: VerifyOTPUseCaseProtocol {
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func execute(otp: String) async throws -> Bool {
        return try await authRepository.verifyOTP(otp: otp)
    }
}
