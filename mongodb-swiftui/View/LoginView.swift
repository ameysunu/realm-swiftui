//
//  LoginView.swift
//  mongodb-swiftui
//
//  Created by Amey Sunu on 14/07/21.
//

import SwiftUI
import RealmSwift

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State var isNavigated: Bool = false
    @State var isSignedBefore: Bool = false
    @State var load: Bool = false
    @State var anyload: Bool = false
    
    @State var alertItem: AlertItem?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
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
                
                NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $isSignedBefore)  {
                    NavigationLink(destination: WelcomeView().navigationBarBackButtonHidden(true), isActive: $isNavigated) {
                        Button(action: {
                            self.load.toggle()
                            RealmAuth(email: email, password: password){
                                (success) -> Void in
                                if success {
                                    self.load.toggle()
                                    let userCheck = try! Realm().objects(UserData.self).filter("userID = '\(uid!)'")
                                    if(userCheck.isEmpty){
                                        self.isNavigated = true
                                    } else {
                                        self.isSignedBefore = true
                                        print(userCheck)
                                    }
                                }else {
                                    self.load.toggle()
                                    self.alertItem = AlertItem(title: Text("Error"), message: Text(e!), dismissButton: .default(Text("Done")))
                                }
                            }
                        }) {
                            if(load == true){
                                HStack {
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
                            } else {
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
                        }
                        .padding(.top, 10)
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: RegisterView()) {
                        Text("I'm new here. Create a new account?")
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
                
            }
            .alert(item: $alertItem){ item in
                Alert(title: item.title, message: item.message, dismissButton: item.dismissButton)
            }
            .navigationTitle("Login")
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
