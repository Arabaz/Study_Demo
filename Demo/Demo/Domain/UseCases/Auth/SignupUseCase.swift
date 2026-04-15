import Foundation

protocol SignupUseCaseProtocol {
    func execute(user: User) async throws -> Bool
}

struct SignupUseCase: SignupUseCaseProtocol {
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func execute(user: User) async throws -> Bool {
        return try await authRepository.signup(user: user)
    }
}
