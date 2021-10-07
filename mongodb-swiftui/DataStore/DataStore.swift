//
//  DataStore.swift
//  mongodb-swiftui
//
//  Created by Niklas Oemler on 06.10.21.
//

import Foundation
import SwiftUI
import RealmSwift

class DataStore: NSObject, ObservableObject {
    static let shared = DataStore()
    
    @Published
    var user: UserData?
    
    @Published
    var diaries: Results<Diary>?
    
    @Published
    var publicDiaries: Results<Diary>?
    
    private var token: NotificationToken? = nil
    private var realm = try! Realm()
    
    // MARK: - Object Lifecycle
    override private init() {
        super.init()
        fetchData()
        addObserver()
    }
    
    deinit {
        token?.invalidate()
    }
    
    private func fetchData() {
        user = realm.objects(UserData.self).filter("userID = '\(uid!)'").first
        diaries = realm.objects(Diary.self).filter("userID = '\(uid!)'")
        publicDiaries = diaries?.filter("isPublic = 'true'")
    }
    
    private func addObserver() {
        token = realm.observe { notification, realm in
            self.fetchData()
        }
    }
}
