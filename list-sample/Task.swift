//
//  Task.swift
//  list-sample
//
//  Created by Takuto Inoue on 9/30/19.
//  Copyright © 2019 Takuto Inoue. All rights reserved.
//

import SwiftUI

struct Task: Equatable, Hashable, Codable, Identifiable {
    let id: UUID
    var title: String
    var isDone: Bool
    
    init(title: String, isDone: Bool) {
        self.id = UUID()
        self.title = title
        self.isDone = isDone
    }
}
