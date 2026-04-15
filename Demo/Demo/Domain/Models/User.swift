import Foundation

struct User: Identifiable, Codable {
    var id: String = UUID().uuidString
    var firstName: String
    var lastName: String
    var email: String
    var age: Int
    var gender: String
    var phone: String
    var address: String
    // Profile picture can be stored as Data or URL string based on implementation choice
    var profileImageData: Data?
}
