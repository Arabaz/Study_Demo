import Foundation

protocol ForgotPasswordUseCaseProtocol {
    func execute(email: String) async throws -> Bool
}

struct ForgotPasswordUseCase: ForgotPasswordUseCaseProtocol {
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func execute(email: String) async throws -> Bool {
        return try await authRepository.forgotPassword(email: email)
    }
}
