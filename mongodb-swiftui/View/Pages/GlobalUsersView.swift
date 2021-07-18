//
//  GlobalUsersView.swift
//  mongodb-swiftui
//
//  Created by Amey Sunu on 18/07/21.
//

import SwiftUI
import RealmSwift

struct GlobalUsersView: View {
    @State private var data = try! Realm().objects(Diary.self)
    @State private var userData = try! Realm().objects(UserData.self)
    
    var body: some View {
        ScrollView {
            ForEach(data) { item in
                GlobalView(name: item.name, date: item.date, title: item.title, mood: item.mood, value: item.value)
            }
            .navigationTitle("People Around You")
            .padding(.horizontal)
        }
    }
}

struct GlobalUsersView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalUsersView()
    }
}
