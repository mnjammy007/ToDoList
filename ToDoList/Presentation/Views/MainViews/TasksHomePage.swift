//
//  TasksHomePage.swift
//  ToDoList
//
//  Created by Apple on 29/01/25.
//

import SwiftUI

struct TasksHomePage: View {
    
    @EnvironmentObject var weekManager: DateManager
    @EnvironmentObject var taskListManager: TaskListManager
    
    @State private var createNewTask: Bool = false
    
    var body: some View {
        ZStack{
            VStack {
                DateHeaderView()
                ScrollView(.vertical, showsIndicators: false) {
                    TaskListView(date: $weekManager.selectedDate, items: $taskListManager.items)
                }
            }
            .padding()
            .overlay(alignment: .bottomTrailing) {
                Button {
                    createNewTask.toggle()
                } label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .padding(26)
                        .background(.black)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                        .padding(.trailing)
                }
                
            }
        }
        .sheet(isPresented: $createNewTask) {
            NewTaskView().presentationDetents([.fraction(0.4)])
        }
    }
}

#Preview {
    TasksHomePage()
        .environmentObject(DateManager())
        .environmentObject(TaskListManager())
}
