//
//  TaskListView.swift
//  tarea
//
//  Created by Guillermo Echague on 09-12-24.
//

import Foundation
import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var isPresentingAddTaskView = false
    @State private var taskToEdit: Task?

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.tasks) { task in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(task.title)
                                .font(.headline)
                            Text(task.isCompleted ? "Completa" : "Pendiente")
                                .font(.subheadline)
                                .foregroundColor(task.isCompleted ? .green : .red)
                        }
                        Spacer()
                    }
                    .onTapGesture {
                        taskToEdit = task // Selecciona la tarea para editar
                        isPresentingAddTaskView = true
                    }
                }
                .onDelete(perform: viewModel.deleteTask)
            }
            .navigationTitle("Tareas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        taskToEdit = nil // Nueva tarea
                        isPresentingAddTaskView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingAddTaskView) {
                AddTaskView(viewModel: viewModel, taskToEdit: taskToEdit)
            }
        }
    }
}
