//
//  AddTaskView.swift
//  tarea
//
//  Created by Guillermo Echague on 09-12-24.
//

import Foundation
import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TaskViewModel

    var taskToEdit: Task? // Tarea para editar, opcional

    @State private var title: String = ""
    @State private var isCompleted: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Detalles de la Tarea")) {
                    TextField("Título", text: $title)
                    Toggle("Completada", isOn: $isCompleted)
                }

                Button(taskToEdit == nil ? "Guardar" : "Actualizar") {
                    if let task = taskToEdit {
                        viewModel.updateTask(id: task.id, newTitle: title, newState: isCompleted)
                    } else {
                        viewModel.addTask(title: title, isCompleted: isCompleted)
                    }
                    dismiss()
                }
                .disabled(title.isEmpty)
            }
            .navigationTitle(taskToEdit == nil ? "Nueva Tarea" : "Editar Tarea")
            .onAppear {
                if let task = taskToEdit {
                    title = task.title
                    isCompleted = task.isCompleted
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
    }
}
