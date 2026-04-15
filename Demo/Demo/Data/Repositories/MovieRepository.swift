import Foundation

class MovieRepository: MovieRepositoryProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func getMovies() async throws -> [Movie] {
        return try await networkManager.request(endpoint: .movies)
    }
}
