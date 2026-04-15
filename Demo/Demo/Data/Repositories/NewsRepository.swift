import Foundation

class NewsRepository: NewsRepositoryProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func getNews() async throws -> [News] {
        return try await networkManager.request(endpoint: .news)
    }
}
