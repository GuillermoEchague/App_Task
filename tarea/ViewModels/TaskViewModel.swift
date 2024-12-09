//
//  TaskViewModel.swift
//  tarea
//
//  Created by Guillermo Echague on 09-12-24.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []

    func addTask(title: String, isCompleted: Bool) {
        let newTask = Task(title: title, isCompleted: isCompleted)
        tasks.append(newTask)
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    func updateTask(id: UUID, newTitle: String, newState: Bool) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].title = newTitle
            tasks[index].isCompleted = newState
        }
    }
}
