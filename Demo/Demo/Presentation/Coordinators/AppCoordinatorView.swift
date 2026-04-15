import Combine
import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        Group {
            switch coordinator.currentRoute {
            case .onboarding:
                OnboardingView()
                    .environmentObject(coordinator)
            case .mainTab:
                MainTabView()
                    .environmentObject(coordinator)
            case .login, .signup, .otp, .forgotPassword:
                NavigationStack(path: $coordinator.path) {
                    LoginView()
                        .environmentObject(coordinator)
                        .navigationDestination(for: AppRoute.self) { route in
                            switch route {
                            case .signup:
                                SignupView()
                                    .environmentObject(coordinator)
                            case .otp:
                                OTPVerificationView()
                                    .environmentObject(coordinator)
                            case .forgotPassword:
                                ForgotPasswordView()
                                    .environmentObject(coordinator)
                            default:
                                EmptyView()
                            }
                        }
                }
            }
        }
    }
}
