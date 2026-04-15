import Foundation

protocol LoginUseCaseProtocol {
    func execute(email: String, password: String) async throws -> User
}

struct LoginUseCase: LoginUseCaseProtocol {
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func execute(email: String, password: String) async throws -> User {
        return try await authRepository.login(email: email, password: password)
    }
}
