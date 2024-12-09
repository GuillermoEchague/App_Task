//
//  Task.swift
//  tarea
//
//  Created by Guillermo Echague on 09-12-24.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}
