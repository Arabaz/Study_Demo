import Combine
import SwiftUI
import PhotosUI

struct SignupView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject private var viewModel = DIContainer.shared.makeAuthViewModel()
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Sign Up")
                    .font(.largeTitle)
                    .bold()
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    if let data = viewModel.profileImageData, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                    }
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            DispatchQueue.main.async {
                                viewModel.profileImageData = data
                            }
                        }
                    }
                }
                
                Group {
                    TextField("First Name", text: $viewModel.firstName)
                    TextField("Last Name", text: $viewModel.lastName)
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    TextField("Age", text: $viewModel.age)
                        .keyboardType(.numberPad)
                    TextField("Gender", text: $viewModel.gender)
                    TextField("Phone Number", text: $viewModel.phone)
                        .keyboardType(.phonePad)
                    TextField("Address", text: $viewModel.address)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                Button("Sign Up") {
                    viewModel.signup()
                }
                .disabled(viewModel.isLoading)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .padding()
        }
        .onChange(of: viewModel.isSignupSuccessful) { success in
            if success {
                coordinator.navigate(to: .otp)
            }
        }
        .navigationTitle("Register")
    }
}
