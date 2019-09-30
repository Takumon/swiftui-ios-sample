//
//  TaskEditView.swift
//  list-sample
//
//  Created by Takuto Inoue on 9/30/19.
//  Copyright © 2019 Takuto Inoue. All rights reserved.
//

import SwiftUI

struct TaskEditView: View {
    @EnvironmentObject var userData: UserData
    private let task: Task
    private var draftTitle: State<String>
    
    init(task: Task) {
        self.task = task
        self.draftTitle = .init(initialValue: task.title)
    }
    
    var body: some View {
        let inset = EdgeInsets(top: -8, leading: -10, bottom: -7, trailing: -10)
        
        return VStack(alignment: HorizontalAlignment.leading, spacing: 0) {
            
            TextField(LocalizedStringKey("Create a New Task..."), text: self.draftTitle.projectedValue, onEditingChanged: { _ in self.updateTask() }, onCommit: {})
            Spacer()
        }
        .navigationBarTitle(Text("Edit Task 📝"))
    }
    
    private func updateTask() {
        guard let index = self.userData.tasks.firstIndex(of: self.task) else { return }
        self.userData.tasks[index].title = self.draftTitle.wrappedValue
    }
}
