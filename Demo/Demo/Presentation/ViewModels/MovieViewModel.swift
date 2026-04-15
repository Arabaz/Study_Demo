import Foundation
import Combine

class MovieViewModel: BaseViewModel {
    @Published var data: [Movie] = []
    private let getMoviesUseCase: GetMoviesUseCaseProtocol
    
    init(getMoviesUseCase: GetMoviesUseCaseProtocol) {
        self.getMoviesUseCase = getMoviesUseCase
    }
    
    func fetchMovies() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedData = try await getMoviesUseCase.execute()
                DispatchQueue.main.async {
                    self.data = fetchedData
                    self.isLoading = false
                }
            } catch {
                handleError(error)
            }
        }
    }
}
