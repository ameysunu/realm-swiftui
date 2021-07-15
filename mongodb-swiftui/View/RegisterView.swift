//
//  RegisterView.swift
//  mongodb-swiftui
//
//  Created by Amey Sunu on 14/07/21.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmpwd: String = ""
    @State var createdAcc: Bool = false
    @State var load: Bool = false
    
    @State var alertItem: AlertItem?
    
    var body: some View {
        VStack(alignment: .leading){
            
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
                .padding(.bottom, 20)
            
            SecureField("Confirm Password", text: $confirmpwd)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 5.0)
                            .stroke(lineWidth: 1.0))
            
            Button(action: {
                if(password == confirmpwd){
                    self.load.toggle()
                    RealmRegister(email: email, password: password){
                        (success) -> Void in
                        if success {
                            self.createdAcc.toggle()
                            self.load.toggle()
                        } else {
                            self.load.toggle()
                        }
                    }
                } else {
                    self.alertItem = AlertItem(title: Text("Error"), message: Text("Passwords do not match."), dismissButton: .default(Text("Done")))
                }
            }) {
                if(load != true){
                Text("Create an account")
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2.0)
                                .shadow(color: .blue, radius: 10.0))
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                } else {
                    HStack{
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 2.0)
                                    .shadow(color: .gray, radius: 10.0))
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
                    .disabled(true)
                }
            }
            .padding(.top, 10)
            
            if(createdAcc == true){
                Text("Created account successfully! Go back to login and sign in again.")
                    .font(.title3)
                    .foregroundColor(.green)
                    .padding(.top, 10)
            }
            
        }
        .alert(item: $alertItem){ item in
            Alert(title: item.title, message: item.message, dismissButton: item.dismissButton)
        }
        .navigationTitle("Register")
        .padding()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
