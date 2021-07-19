//
//  GlobalUsersView.swift
//  mongodb-swiftui
//
//  Created by Amey Sunu on 18/07/21.
//

import SwiftUI
import RealmSwift

struct GlobalUsersView: View {
    @State private var data = try! Realm().objects(Diary.self).filter("isPublic = 'true'")
    @State private var userData = try! Realm().objects(UserData.self)
    @State var isPresented: Bool = false
    @State var selectedItem: Diary?
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(data) { item in
                    GlobalView(name: item.name, date: item.date, title: item.title, mood: item.mood, value: item.value)
                        .onTapGesture {
                            self.isPresented.toggle()
                            self.selectedItem = item
                        }
                }
                .navigationTitle("People Around You")
                .padding(.horizontal)
            }
            
        }
        .sheet(item: self.$selectedItem){ item in
            GlobalValueView(name: item.name, date: item.date, title: item.title, mood: item.mood, value: item.value)
        }
        .navigationBarHidden(true)
        .navigationTitle("")
    }
}

struct GlobalValueView: View {
    
    @State var name: String?
    @State var date: String?
    @State var title: String?
    @State var mood: String?
    @State var value: String?
    
    var body: some View{
        ZStack {
            Color("#CBCCFF")
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text(date!)
                    .foregroundColor(Color("#914275"))
                    .padding(.bottom, 5)
                Text(title!)
                    .foregroundColor(.black)
                    .font(.title)
                Text(mood!)
                    .foregroundColor(.gray)
                    .font(.title2)
                    .padding(.bottom, 20)
                ScrollView {
                    Text(value!)
                        .foregroundColor(.black)
                }
                
                Spacer()
                Text("By: \(name!)")
                    .foregroundColor(Color("#914275"))
                    .font(.title2)
            }
            .padding()
        }
    }
}

struct GlobalUsersView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalUsersView()
    }
}
