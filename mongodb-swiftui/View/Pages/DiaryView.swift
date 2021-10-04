//
//  DiaryView.swift
//  mongodb-swiftui
//
//  Created by Amey Sunu on 17/07/21.
//

import SwiftUI
import RealmSwift

struct DiaryView: View {
    
    @State var presented: Bool = false
    @State private var data: Results<Diary> = try! Realm().objects(Diary.self).filter("userID = '\(uid!)'")
    @State var globalData: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    if data.count == 0{
                        Label {
                            Text("No Data Found")
                                .foregroundColor(.primary)
                                .font(.system(size: 30))
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Capsule())
                        }
                        icon: {
//                            RoundedRectangle(cornerRadius: 10)
//                                .fill(Color.blue)
//                                .frame(width: 64, height: 64)
                        }
                    }
                    else{
                        ForEach(data) { item in
                            ListView(date: item.date, title: item.title, mood: item.mood, value: item.value, isPublic: item.isPublic)
                        }
                    }
                    
                }
                .listStyle(PlainListStyle())
                
                .navigationTitle("My Diary")
                .toolbar{
                    Button(action: {
                        self.presented.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $presented){
                    Diaries(isPresented: $presented)
                    
                }
            }
        }
        .navigationBarHidden(true)
        .navigationTitle("")
        
    }
    
}

struct Diaries: View{
    
    @State var title: String = ""
    @State var mood: String = ""
    @State var main: String = ""
    let realm = try! Realm()
    @Binding var isPresented: Bool
    @State var noChecked: Bool = true
    @State var updateTriggered: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Enter a title for your page")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                
                TextField("Title",text: $title)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 5.0)
                                .stroke(lineWidth: 1.0))
                    .padding(.bottom, 20)
                
                Text("How are you feeling?")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                
                TextField("Mood",text: $mood)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 5.0)
                                .stroke(lineWidth: 1.0))
                    .padding(.bottom, 20)
                
                Text("Describe your feelings.")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                
                ZStack {
                    TextEditor(text: $main)
                        .overlay(RoundedRectangle(cornerRadius: 5.0)
                                    .stroke(lineWidth: 1.0))
                    Text(main).opacity(0).padding(.all, 8)
                }
                .padding(.bottom, 20)
                
                HStack {
                    Image(systemName: noChecked ? "square" : "checkmark.square.fill")
                        .foregroundColor(noChecked ? Color.secondary : Color(UIColor.systemBlue))
                        .onTapGesture {
                            self.noChecked.toggle()
                            
                        }
                        .padding(.trailing, 5)
                    
                    Text("Make the diary private")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 20)
                
                Spacer()
                
                if(updateTriggered == true){
                    Button(action: {
                        let realm = try! Realm()
                        let diaryValue = realm.objects(Diary.self).filter("title = '\(title)'")[0]
                        try! realm.write {
                            diaryValue.date = Date().localizedDescription
                            diaryValue.title = title
                            diaryValue.mood = mood
                            diaryValue.isPublic = String(noChecked)
                            diaryValue.value = main
                        }
                        
                    }){
                        Text("Update")
                            .padding(8)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 2.0)
                                        .shadow(color: .blue, radius: 10.0))
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    }
                } else {
                    Button(action: {
                        let username = try! Realm().objects(UserData.self).filter("userID= '\(uid!)'")
                        print(Date().localizedDescription)
                        let diary = Diary()
                        
                        diary.userID = uid
                        diary.title = title
                        diary.date = Date().localizedDescription
                        diary.mood = mood
                        diary.isPublic = String(noChecked)
                        diary.value = main
                        diary.name = username[0].name!
                        
                        try! realm.write{
                            realm.add(diary)
                            isPresented.toggle()
                        }
                        
                    }){
                        Text("Save")
                            .padding(8)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 2.0)
                                        .shadow(color: .blue, radius: 10.0))
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    }
                    .padding(.top, 20)
                    
                    .navigationTitle("Create a page")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .padding()
        }
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView()
    }
}


