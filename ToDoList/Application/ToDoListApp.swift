//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Apple on 29/01/25.
//

import SwiftUI

@main
struct ToDoListApp: App {
    
    @StateObject var viewModel: TasksHomePageViewModel = TasksHomePageViewModel(dateUseCase: DateUseCase(dateRepository: DateRepository(dateDataProvider: DateDataProvider())), taskUseCase: TaskUseCase(taskRepository: TaskRepository(taskDataProvider: TaskDataProvider())))
    
    var body: some Scene {
        WindowGroup {
            TasksHomePage(viewModel: viewModel)
        }
    }
}
