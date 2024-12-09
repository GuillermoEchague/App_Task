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
  
    // Estados para la confirmación de eliminación
       @State private var showAlert = false
       @State private var indexToDelete: IndexSet? = nil

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
                .onDelete { offsets in
                    indexToDelete = offsets // Guardamos el índice para eliminar
                    showAlert = true         // Mostramos la alerta
                }
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
            .alert("¿Eliminar tarea?", isPresented: $showAlert) {
                Button("Eliminar", role: .destructive) {
                    if let index = indexToDelete {
                        viewModel.deleteTask(at: index) // Eliminamos la tarea
                    }
                }
                Button("Cancelar", role: .cancel) {
                    indexToDelete = nil // Limpiamos el índice si se cancela
                }
            }
        }
    }
}
