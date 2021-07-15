//
//  Model.swift
//  mongodb-swiftui
//
//  Created by Amey Sunu on 14/07/21.
//

import Foundation
import RealmSwift
import SwiftUI

class User: Object {
    @objc dynamic var name: String?
    @objc dynamic var gender: String?
}

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button
}
