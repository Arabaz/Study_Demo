//
//  test.swift
//  Demo
//
//  Created by Apps WeLove on 09/04/26.
//

//import SwiftUI
//
//struct TestView: View {
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//
//                VStack {
//
//                    HStack {
//                        Text("User Name :")
//                            .foregroundColor(.white)
//                            .frame(minWidth: 110, maxWidth: 110)
//                        TextField("", text: .constant(""))
//                            .foregroundColor(.black)
//                            .background(Color.white)
//                            .padding(.trailing, 30)
//                    }
//                    .position(x: geometry.size.width / 2 - 10, y: 20)
//                    
//                    HStack {
//                        Text("Password :  ")
//                            .foregroundColor(.white)
//                            .frame(minWidth: 110, maxWidth: 110)
//                        TextField("", text: .constant(""))
//                            .foregroundColor(.black)
//                            .background(Color.white)
//                            .padding(.trailing, 30)
//                    }
//                    .position(x: geometry.size.width / 2 - 10, y: -140)
//  
//                }
//                .frame(width: geometry.size.width - 40, height: geometry.size.height * 0.5 - 20)
//                .background(Color.gray)
//                .padding(.leading, 20)
//                .padding(.top, 20)
//            }
//        }
//    }
//}

import SwiftUI

struct TestView: View {
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                VStack(spacing: 20) {
                    
                    HStack {
                        Text("User Name :")
                            .foregroundColor(.white)
                            .frame(width: 110, alignment: .leading)
                        
                        TextField("", text: .constant(""))
                            .foregroundColor(.black)
                            .background(Color.white)
                    }
                    .padding(.top, 10)
                    
                    HStack {
                        Text("Password :")
                            .foregroundColor(.white)
                            .frame(width: 110, alignment: .leading)
                        
                        TextField("", text: .constant(""))
                            .foregroundColor(.black)
                            .background(Color.white)
                    }
                    
                }
                .padding(.horizontal, 20)
                .frame(
                    width: geometry.size.width - 40,
                    height: geometry.size.height * 0.5 - 20,
                    alignment: .top
                )
                .background(Color.gray)
                .padding(.top, 20)
                .padding(.leading, 20)
            }
        }
    }
}

#Preview {
    TestView()
}
