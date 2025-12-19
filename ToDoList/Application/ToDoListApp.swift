//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Apple on 29/01/25.
//

import AppsFlyerLib
import SwiftUI

@main
struct ToDoListApp: App {

    @StateObject var viewModel: TasksHomePageViewModel = TasksHomePageViewModel(
        dateUseCase: DateUseCase(
            dateRepository: DateRepository(dateDataProvider: DateDataProvider())
        ),
        taskUseCase: TaskUseCase(
            taskRepository: TaskRepository(taskDataProvider: TaskDataProvider())
        )
    )

    init() {
        AppsFlyerLib.shared().appsFlyerDevKey = "vEbzV4hdsUG5GpQYLeXsHS"
        AppsFlyerLib.shared().appleAppID = "6756777842"
        AppsFlyerLib.shared().isDebug = false
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        AppsFlyerLib.shared().start()
    }

    var body: some Scene {
        WindowGroup {
            TasksHomePage(viewModel: viewModel)
                .preferredColorScheme(.light)
        }
    }
}
