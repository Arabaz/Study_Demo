import Combine
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    
    // Static user info as per requirement
    private let firstName = "John"
    private let lastName = "Doe"
    private let email = "abc@gmail.com"
    private let phone = "1234567890"
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .padding(.top, 40)
            
            Text("\(firstName) \(lastName)")
                .font(.title)
                .bold()
            
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.gray)
                    Text(email)
                }
                
                HStack {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.gray)
                    Text(phone)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            
            Spacer()
            
            Button("Logout") {
                coordinator.logout()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .navigationTitle("Profile")
    }
}
