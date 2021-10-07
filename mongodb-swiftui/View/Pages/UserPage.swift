//
//  UserPage.swift
//  mongodb-swiftui
//
//  Created by Amey Sunu on 19/07/21.
//

import SwiftUI
import RealmSwift

struct UserPage: View {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    
    @ObservedObject
    private var dataStore = DataStore.shared
    
    private var user: UserData? {
        dataStore.user
    }
    
    @State
    private var isOpen: Bool = false
    
    @State
    private var isToggled: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    if let name = user?.name {
                        Text(name)
                            .font(.title)
                    }
                    if let age = user?.age {
                        Text(age)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action: {
                    }) {
                        Image(systemName: "pencil.circle.fill")
                    }
                }
                if let country = user?.country {
                    Text(country)
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                Text("Total Pages written: \(dataStore.diaries?.count ?? 0)")
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
                if(isOpen == true) {
                    if let publicDiaries = dataStore.publicDiaries {
                        ScrollView{
                            ForEach(publicDiaries){ data in
                                ListView(
                                    date: data.date,
                                    title: data.title,
                                    mood: data.mood,
                                    value: data.value,
                                    functionEnabled: false
                                )
                            }
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
            .navigationTitle("Hello \(dataStore.user?.name ?? "")")
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
