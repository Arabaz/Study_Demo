import Foundation

protocol MovieRepositoryProtocol {
    func getMovies() async throws -> [Movie]
}
