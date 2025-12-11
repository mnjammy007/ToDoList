//
//  TasksHomePage.swift
//  ToDoList
//
//  Created by Apple on 29/01/25.
//

import SwiftUI

struct TasksHomePage: View {

    @State private var createNewTask: Bool = false
    @ObservedObject var viewModel: TasksHomePageViewModel

    var body: some View {
        ZStack {
            VStack {
                DateHeaderView(viewModel: viewModel)
                ScrollView(.vertical, showsIndicators: false) {
                    TaskListView(viewModel: viewModel)
                }
            }
            .padding()
            .overlay(alignment: .bottomTrailing) {
                Button {
                    createNewTask.toggle()
                } label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .padding(22)
                        .background(.black)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                        .padding(.trailing)
                        .padding(.bottom)
                }

            }
        }
        .sheet(isPresented: $createNewTask) {
            NewTaskView { task in
                viewModel.updateTaskList(task: task)
            }.presentationDetents([.fraction(0.55)])
        }
    }
}

#Preview {
    TasksHomePage(
        viewModel: TasksHomePageViewModel(
            dateUseCase: DateUseCase(
                dateRepository: DateRepository(
                    dateDataProvider: DateDataProvider()
                )
            ),
            taskUseCase: TaskUseCase(
                taskRepository: TaskRepository(
                    taskDataProvider: TaskDataProvider()
                )
            )
        )
    )
}
