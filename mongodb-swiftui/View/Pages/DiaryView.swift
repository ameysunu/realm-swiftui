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
    @State var data = try! Realm().objects(Diary.self).filter("userID = '\(uid!)'")
    
    
    var body: some View {
        NavigationView {
            List{
                ForEach(data) { value in
                    Section(header: Text(value.date!)){
                        VStack {
                            HStack {
                                Text(value.title!)
                                    .font(.title3)
                                Spacer()
                            }
                            HStack {
                                Text(value.mood!)
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())

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
        .navigationBarHidden(true)
        .navigationTitle("")
    }
}

struct Diaries: View{
    
    @State private var title: String = ""
    @State private var mood: String = ""
    @State private var main: String = ""
    let realm = try! Realm()
    @Binding var isPresented: Bool
    
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
                Spacer()
                
                Button(action: {
                    print(Date().localizedDescription)
                    let diary = Diary()
                    
                    diary.userID = uid
                    diary.title = title
                    diary.date = Date().localizedDescription
                    diary.mood = mood
                    diary.value = main
                    
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
            .padding()
        }
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView()
    }
}


