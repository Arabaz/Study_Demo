import Foundation

protocol AuthRepositoryProtocol {
    func login(email: String, password: String) async throws -> User
    func signup(user: User) async throws -> Bool
    func verifyOTP(otp: String) async throws -> Bool
    func forgotPassword(email: String) async throws -> Bool
}
