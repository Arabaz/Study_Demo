import SwiftUI

struct HomeView: View {
    // In a real app, this would be fetched from user session
    @State private var userName = "John Doe"
    
    var body: some View {
        VStack {
            Text("Welcome to Clean Architecture App!")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Hello, \(userName)")
                .font(.headline)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Home")
    }
}
