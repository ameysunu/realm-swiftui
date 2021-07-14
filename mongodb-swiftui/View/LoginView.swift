//
//  LoginView.swift
//  mongodb-swiftui
//
//  Created by Amey Sunu on 14/07/21.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {

            Text("Login")
                .font(.title)
                .padding(.bottom, 10)
            
            TextField("Email ID",text: $email)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 5.0)
                            .stroke(lineWidth: 1.0))
                .padding(.bottom, 20)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 5.0)
                            .stroke(lineWidth: 1.0))
            Button(action: {
                
            }) {
                Text("Login")
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2.0)
                                .shadow(color: .blue, radius: 10.0))
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
            }
            .padding(.top, 10)
            
            HStack {
                Spacer()
                Text("OR")
                Spacer()
            }
            .padding()
            
            Button(action: {
                
            }) {
                Text("Login Anonymously")
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2.0)
                                .shadow(color: .blue, radius: 10.0))
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
            }

        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
