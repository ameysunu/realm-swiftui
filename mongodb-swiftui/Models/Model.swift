//
//  Model.swift
//  mongodb-swiftui
//
//  Created by Amey Sunu on 14/07/21.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var name: String?
    @objc dynamic var gender: String?
}
