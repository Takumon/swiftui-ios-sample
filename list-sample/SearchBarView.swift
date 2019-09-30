//
//  SearchBarView.swift
//  list-sample
//
//  Created by Takuto Inoue on 9/29/19.
//  Copyright © 2019 Takuto Inoue. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
    @State var text: Binding<String>
    var placeholder: LocalizedStringKey = LocalizedStringKey("Search")
    var onEditingChanged: (Bool) -> Void = { _ in }
    var onCommit: () -> Void = { }

    var body: some View {
        TextField(placeholder, text: text, onEditingChanged: onEditingChanged, onCommit: onCommit)
            .background(Color.gray.opacity(0.3))
            .padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 0, trailing: 16.0))

        
    }
    
}
