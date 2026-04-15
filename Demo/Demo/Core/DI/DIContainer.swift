import Foundation

class DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    // MARK: - Core
    lazy var networkManager: NetworkManagerProtocol = NetworkManager.shared
    
    // MARK: - Repositories
    lazy var authRepository: AuthRepositoryProtocol = AuthRepository()
    lazy var newsRepository: NewsRepositoryProtocol = NewsRepository(networkManager: networkManager)
    lazy var movieRepository: MovieRepositoryProtocol = MovieRepository(networkManager: networkManager)
    
    // MARK: - Use Cases
    // Auth
    lazy var loginUseCase: LoginUseCaseProtocol = LoginUseCase(authRepository: authRepository)
    lazy var signupUseCase: SignupUseCaseProtocol = SignupUseCase(authRepository: authRepository)
    lazy var verifyOTPUseCase: VerifyOTPUseCaseProtocol = VerifyOTPUseCase(authRepository: authRepository)
    lazy var forgotPasswordUseCase: ForgotPasswordUseCaseProtocol = ForgotPasswordUseCase(authRepository: authRepository)
    
    // News & Movies
    lazy var getNewsUseCase: GetNewsUseCaseProtocol = GetNewsUseCase(newsRepository: newsRepository)
    lazy var getMoviesUseCase: GetMoviesUseCaseProtocol = GetMoviesUseCase(movieRepository: movieRepository)
    
    // MARK: - ViewModels
    func makeAuthViewModel() -> AuthViewModel {
        return AuthViewModel(
            loginUseCase: loginUseCase,
            signupUseCase: signupUseCase,
            verifyOTPUseCase: verifyOTPUseCase,
            forgotPasswordUseCase: forgotPasswordUseCase
        )
    }
    
    func makeNewsViewModel() -> NewsViewModel {
        return NewsViewModel(getNewsUseCase: getNewsUseCase)
    }
    
    func makeMovieViewModel() -> MovieViewModel {
        return MovieViewModel(getMoviesUseCase: getMoviesUseCase)
    }
}
