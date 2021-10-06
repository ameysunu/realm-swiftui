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
    var diaries: Results<Diary>?
    
    private var token: NotificationToken? = nil
    private var realm = try! Realm()
    
    // MARK: - Object Lifecycle
    override private init() {
        super.init()
        diaries = realm.objects(Diary.self).filter("userID = '\(uid!)'")
        addObserver()
    }
    
    deinit {
        token?.invalidate()
    }
    
    private func addObserver() {
        token = realm.observe { notification, realm in
            self.diaries = realm.objects(Diary.self).filter("userID = '\(uid!)'")
        }
    }
}
