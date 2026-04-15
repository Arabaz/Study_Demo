import Foundation

protocol NewsRepositoryProtocol {
    func getNews() async throws -> [News]
}
