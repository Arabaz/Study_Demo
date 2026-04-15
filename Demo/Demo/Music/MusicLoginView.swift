//
//  MusicLoginView.swift
//  Demo
//
//  Created by Apps WeLove on 10/04/26.
//

import SwiftUI


struct MusicLoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSecure: Bool = true
    var body: some View {
        VStack {
            SocialSignInButton(
                title: "Sign in with Google",
                imageName: "googleLogo",
                backgroundColor: Color(hex: "#D7503F")
            ) {
                print("Google tapped @")
            }
            .padding(.horizontal, 15)
            .padding(.top, 10)
            
            SocialSignInButton(
                title: "Sign in with Apple",
                imageName: "appleLogo",
                backgroundColor: .black
            ) {
                print("Apple tapped")
            }
            .padding(.horizontal, 15)
            
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(height: 1)
                
                Text("or")
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 15)
            
            TextField("Enter username", text: $username)
                .textFieldStyle(.plain)
                .frame(minHeight: 45, maxHeight: 45)
                .padding(.horizontal, 5)        // inner text padding (inside gray box)
                .background(Color.gray.opacity(0.1))
                .padding(.horizontal, 15)        // 👈 outer padding — creates space left & right

            
            PasswordTextField(password: $password, isSecure: $isSecure)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .border(Color.blue, width: 1)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(10)
    }
}

#Preview {
    MusicLoginView()
}

struct SocialSignInButton: View {
    let title: String
    let imageName: String
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .cornerRadius(8)
            .shadow(radius: 2)
        }
    }
}

struct PasswordTextField: View {
    @Binding var password: String
    @Binding var isSecure: Bool
    
    var body: some View {
        HStack {
            if isSecure {
                SecureField("Enter password", text: $password)
                    .textFieldStyle(.plain)
                    .frame(minHeight: 45, maxHeight: 45)
                    .padding(.horizontal, 5)
            }else {
                TextField("Enter password", text: $password)
                    .textFieldStyle(.plain)
                    .frame(minHeight: 45, maxHeight: 45)
                    .padding(.horizontal, 5)
            }
            Button {
                isSecure.toggle()
            } label: {
                Image(systemName: isSecure ? "eye.slash" : "eye")
                    .frame(minWidth: 20, maxWidth: 20, minHeight: 20, maxHeight: 20)
            }.padding(.trailing, 10)
            
        }
        .background(Color.gray.opacity(0.1))
        .padding(.horizontal, 15)
    }
    
}
