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
        }
    
    var body: some View {
        LoginView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
