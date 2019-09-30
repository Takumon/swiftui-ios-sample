//
//  UserData.swift
//  list-sample
//
//  Created by Takuto Inoue on 9/30/19.
//  Copyright © 2019 Takuto Inoue. All rights reserved.
//
import Combine
import SwiftUI


private let defaultTasks: [Task] = [
    Task(title: "Read SwiftUI Documentation 📚", isDone: false),
    Task(title: "Moving 🎉", isDone: true),
]

final class UserData: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()

    @UserDefaultValue(key: "Tasks", defaultValue: defaultTasks)
    var tasks: [Task] {
        willSet {
            self.objectWillChange.send()
        }
    }
}
