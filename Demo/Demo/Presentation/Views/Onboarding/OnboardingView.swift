import Combine
import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                Text("Welcome to Clean App")
                    .font(.largeTitle)
                    .tag(0)
                
                Text("Discover News and Movies")
                    .font(.largeTitle)
                    .tag(1)
                
                Text("Stay connected always")
                    .font(.largeTitle)
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle())
            
            Button(action: {
                UserDefaults.standard.set(true, forKey: "HasSeenOnboarding")
                coordinator.navigate(to: .login)
            }) {
                Text(currentPage == 2 ? "Get Started" : "Skip")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}
