import Foundation
import Combine

class BaseViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func handleError(_ error: Error) {
        DispatchQueue.main.async {
            self.isLoading = false
            if let apiError = error as? APIError {
                self.errorMessage = apiError.customMessage
            } else {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
