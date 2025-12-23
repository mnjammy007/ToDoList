//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Apple on 29/01/25.
//

import AppTrackingTransparency
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
        AppsFlyerLib.shared().appsFlyerDevKey = AppConfig.appsFlyerDevKeyProd
        AppsFlyerLib.shared().appleAppID = AppConfig.appleAppID
        AppsFlyerLib.shared().isDebug = false
        AppsFlyerLib.shared().isStopped = true
    }

    var body: some Scene {
        WindowGroup {
            TasksHomePage(viewModel: viewModel)
                .preferredColorScheme(.light)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        ATTrackingManager.requestTrackingAuthorization { _ in
                            AppsFlyerLib.shared().isStopped = false
                            AppsFlyerLib.shared().start()
                        }
                    }
                }
        }
    }
}
