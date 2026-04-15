import Foundation
import Combine

class NewsViewModel: BaseViewModel {
    @Published var data: [News] = []
    private let getNewsUseCase: GetNewsUseCaseProtocol
    
    init(getNewsUseCase: GetNewsUseCaseProtocol) {
        self.getNewsUseCase = getNewsUseCase
    }
    
    func fetchNews() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedData = try await getNewsUseCase.execute()
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
