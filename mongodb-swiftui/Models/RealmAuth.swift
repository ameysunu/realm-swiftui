//
//  RealmAuth.swift
//  mongodb-swiftui
//
//  Created by Amey Sunu on 14/07/21.
//

import Foundation
import RealmSwift

let app = App(id: "swiftapp-ebdla")

func RealmAuth(email:String, password:String){
    app.login(credentials: Credentials.emailPassword(email: email, password: password)) { (result) in
        switch result {
        case .failure(let error):
            print("Login failed: \(error.localizedDescription)")
        case .success(let user):
            print("Successfully logged in as user \(user)")
        // Now logged in, do something with user
        // Remember to dispatch to main if you are doing anything on the UI thread
        }
    }
}

func RealmAuthAnonymous(){
    let anonymousCredentials = Credentials.anonymous
    app.login(credentials: anonymousCredentials) { (result) in
        switch result {
        case .failure(let error):
            print("Login failed: \(error.localizedDescription)")
        case .success(let user):
            print("Successfully logged in as user \(user)")
            // Now logged in, do something with user
            // Remember to dispatch to main if you are doing anything on the UI thread
        }
    }

}

func RealmRegister(email:String, password:String){
    let client = app.emailPasswordAuth
    let email = email
    let password = password
    client.registerUser(email: email, password: password) { (error) in
        guard error == nil else {
            print("Failed to register: \(error!.localizedDescription)")
            return
        }
        // Registering just registers. You can now log in.
        print("Successfully registered user.")
    }

}
