import Foundation

class AuthRepository: AuthRepositoryProtocol {
    
    // Simulating delay for local authentication
    private func simulateNetworkDelay() async throws {
        try await Task.sleep(nanoseconds: 1_000_000_000)
    }
    
    func login(email: String, password: String) async throws -> User {
        try await simulateNetworkDelay()
        
        // Static Validation as per requirement
        if email == "abc@gmail.com" && password == "Abc@123" {
            let user = User(
                firstName: "John",
                lastName: "Doe",
                email: email,
                age: 30,
                gender: "Male",
                phone: "1234567890",
                address: "123 Main St"
            )
            return user
        } else {
            throw NSError(domain: "AuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])
        }
    }
    
    func signup(user: User) async throws -> Bool {
        try await simulateNetworkDelay()
        // Simulate successful signup
        return true
    }
    
    func verifyOTP(otp: String) async throws -> Bool {
        try await simulateNetworkDelay()
        return otp == "1234"
    }
    
    func forgotPassword(email: String) async throws -> Bool {
        try await simulateNetworkDelay()
        if email == "abc@gmail.com" {
            return true
        } else {
            throw NSError(domain: "AuthError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Email not found"])
        }
    }
}
