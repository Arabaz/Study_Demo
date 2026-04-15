import Combine
import Foundation
import SwiftUI

enum AppRoute: Hashable {
    case onboarding
    case login
    case signup
    case otp
    case forgotPassword
    case mainTab
}

class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var currentRoute: AppRoute = .onboarding
    
    init() {
        checkInitialRoute()
    }
    
    func checkInitialRoute() {
        if KeychainManager.shared.getToken() != nil {
            currentRoute = .mainTab
        } else {
            let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "HasSeenOnboarding")
            currentRoute = hasSeenOnboarding ? .login : .onboarding
        }
    }
    
    func navigate(to route: AppRoute) {
        if route == .mainTab || route == .login || route == .onboarding {
            // Changing root
            currentRoute = route
            path = NavigationPath() // Clear stack
        } else {
            // Push onto stack
            path.append(route)
        }
    }
    
    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func logout() {
        KeychainManager.shared.removeToken()
        navigate(to: .login)
    }
}
