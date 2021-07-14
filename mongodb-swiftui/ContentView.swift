//
//  ContentView.swift
//  mongodb-swiftui
//
//  Created by Amey Sunu on 14/07/21.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    init (){
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
                let user = User()
                user.gender = "Female"
                user.name = "Quinn Harper"
        
                try! realm.write{
                    realm.add(user)
                }
        
        let results = realm.objects(User.self).filter("gender = 'Male'")
        print(results.count)
        let app = App(id: "swiftapp-ebdla")
        let email = "XXXXXX@XXXX.XXX"
        let password = "123456"
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
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
