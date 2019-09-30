//
//  TaskListView.swift
//  list-sample
//
//  Created by Takuto Inoue on 9/29/19.
//  Copyright © 2019 Takuto Inoue. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var userData: UserData
    @State var draftTitle: String = ""
    @State var isEditing: Bool = false
    
    var body: some View {
        let placeholder :LocalizedStringKey = LocalizedStringKey("Create a New Task...")
        
        return NavigationView {
            List {
                TextField(placeholder, text: $draftTitle, onCommit: self.createTask)
                ForEach(self.userData.tasks) { task in
                    TaskItemView(task: task, isEditing: self.$isEditing)
                }
            }
            .navigationBarTitle(Text("Tasks 👀"))
            .navigationBarItems(trailing: Button(action: { self.isEditing.toggle() }) {
                if !self.isEditing {
                    Text("Edit")
                } else {
                    Text("Done").bold()
                }
            })
        }
    }
    
    private func createTask() {
        let newTask = Task(title: self.draftTitle, isDone: false)
        self.userData.tasks.insert(newTask, at: 0)
        self.draftTitle = ""
    }
}
