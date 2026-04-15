import Foundation

protocol GetNewsUseCaseProtocol {
    func execute() async throws -> [News]
}

struct GetNewsUseCase: GetNewsUseCaseProtocol {
    private let newsRepository: NewsRepositoryProtocol
    
    init(newsRepository: NewsRepositoryProtocol) {
        self.newsRepository = newsRepository
    }
    
    func execute() async throws -> [News] {
        return try await newsRepository.getNews()
    }
}
