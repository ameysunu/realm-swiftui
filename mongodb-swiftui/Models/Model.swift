//
//  Model.swift
//  mongodb-swiftui
//
//  Created by Amey Sunu on 14/07/21.
//

import Foundation
import RealmSwift
import SwiftUI

class UserData: Object {
    @objc dynamic var userID: String?
    @objc dynamic var name: String?
    @objc dynamic var gender: String?
    @objc dynamic var country: String?
    @objc dynamic var age: String?
}

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button
}

extension TimeZone {
    static let gmt = TimeZone(secondsFromGMT: 0)!
}
extension Formatter {
    static let date = DateFormatter()
}

extension Date {
    func localizedDescription(dateStyle: DateFormatter.Style = .medium,
                              timeStyle: DateFormatter.Style = .medium,
                              in timeZone : TimeZone = .current,
                              locale   : Locale = .current) -> String {
        Formatter.date.locale = locale
        Formatter.date.timeZone = timeZone
        Formatter.date.dateStyle = dateStyle
        Formatter.date.timeStyle = timeStyle
        return Formatter.date.string(from: self)
    }
    var localizedDescription: String { localizedDescription() }
}

class Diary: Object {
    @objc dynamic var userID: String?
    @objc dynamic var date: String?
    @objc dynamic var title: String?
    @objc dynamic var mood: String?
    @objc dynamic var value: String?
}
