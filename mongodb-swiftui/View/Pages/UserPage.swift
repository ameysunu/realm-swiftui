//
//  UserPage.swift
//  mongodb-swiftui
//
//  Created by Amey Sunu on 19/07/21.
//

import SwiftUI
import RealmSwift

struct UserPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var name: String?
    @State var age: String?
    @State var country: String?
    let userValues: Results<UserData>
    @State var isOpen: Bool = false
    @State private var publicData = try! Realm().objects(Diary.self).filter("userID = '\(uid!)'").filter("isPublic = 'true'")
    @State var isToggled: Bool = false
    
    init(){
    let realm = try! Realm()
    let results = realm.objects(UserData.self).filter("userID = '\(uid!)'")
        print(results)
        userValues = results
    }
    
    let pageCount = try! Realm().objects(Diary.self).filter("userID = '\(uid!)'").count
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                HStack {
                    Text("\(userValues[0].name!),")
                        .font(.title)
                    Text(userValues[0].age!)
                        .font(.title)
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "pencil.circle.fill")
                    }
                }
                Text(userValues[0].country!)
                    .font(.title2)
                    .foregroundColor(.gray)
                
                Text("Total Pages written: \(pageCount)")
                    .font(.title3)
                    .padding(.top, 10)
                
                HStack {
                    Text("Your Public Diaries")
                        .font(.title2)
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
                        self.isOpen.toggle()
                    }) {
                        Image(systemName: buttonValue)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top, 20)
                if(isOpen == true){
                    ScrollView{
                        ForEach(publicData){ data in
                            ListView(date: data.date, title: data.title, mood: data.mood, value: data.value, functionEnabled: false)
                        }
                    }
                }
                Spacer()
                NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true), isActive: $isToggled) {
                    Button(action: {
                        app.currentUser?.logOut { (error) in
                            if let e = error {
                                print(e.localizedDescription)
                            } else {
                                DispatchQueue.main.async {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                print("logged out")
                                self.isToggled.toggle()
                            }
                        }
                    }) {
                        Text("Logout")
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
            }
            .padding()
            .navigationTitle("Hello \(userValues[0].name!)")
        }
        .navigationBarHidden(true)
        .navigationTitle("")
    }
    var buttonValue: String {
        return isOpen ? "chevron.up.circle.fill" : "chevron.down.circle.fill"
    }
}

struct UserPage_Previews: PreviewProvider {
    static var previews: some View {
        UserPage()
    }
}
