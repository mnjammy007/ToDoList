//
//  Task.swift
//  ToDoList
//
//  Created by Apple on 29/01/25.
//

import Foundation

struct Task: Codable, Hashable, Identifiable{
    var id: UUID
    var title: String
    var date: Date
    var isCompleted: Bool
    
    init(id: UUID = .init(), title: String, date: Date, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.date = date
        self.isCompleted = isCompleted
    }
}
