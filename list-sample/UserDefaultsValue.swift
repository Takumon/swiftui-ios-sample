//
//  UserDefaultsValue.swift
//  list-sample
//
//  Created by Takuto Inoue on 9/30/19.
//  Copyright © 2019 Takuto Inoue. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefaultValue<Value: Codable> {
    
    let key: String
    let defaultValue: Value
    
    var wrappedValue: Value {
        get {
            print("Do get")
            let data = UserDefaults.standard.data(forKey: key)
            let value = data.flatMap { try? JSONDecoder().decode(Value.self, from: $0) }
            return value ?? defaultValue
        }
        set {
            print("Do set", newValue)
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
