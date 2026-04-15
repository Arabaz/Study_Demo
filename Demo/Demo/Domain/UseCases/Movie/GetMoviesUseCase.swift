import Foundation

protocol GetMoviesUseCaseProtocol {
    func execute() async throws -> [Movie]
}

struct GetMoviesUseCase: GetMoviesUseCaseProtocol {
    private let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    func execute() async throws -> [Movie] {
        return try await movieRepository.getMovies()
    }
}
