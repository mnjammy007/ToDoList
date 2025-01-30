//
//  TaskDataProvider.swift
//  ToDoList
//
//  Created by Apple on 29/01/25.
//

import Foundation

protocol TaskDataProviderProtocol{
    func getTaskList() -> [Task]
    func updateTaskList(task: Task) -> [Task]
    func toggleTaskCompletion(task: Task) -> [Task]
    func deleteTask(task: Task) -> [Task]
    func getCurrentDateSelectedTasks(of date: Date) -> [Task]
}

class TaskDataProvider {
    private var taskList: [Task] = []
    
    init() {
        self.taskList = self.getTaskListFromUserDefaults()
    }
    
    private func getTaskListFromUserDefaults() -> [Task]{
        guard let data = UserDefaults.standard.data(forKey: "notes") else { return []}
        if let decodedData = try? JSONDecoder().decode([Task].self, from: data){
            return decodedData
        }
        return []
    }
    
    private func saveUpdatedTaskList(){
        guard let data = try? JSONEncoder().encode(taskList) else { return }
        UserDefaults.standard.set(data, forKey: "notes")
    }
    
}

extension TaskDataProvider: TaskDataProviderProtocol{
    func getTaskList() -> [Task] {
        taskList
    }
    
    func updateTaskList(task: Task) -> [Task] {
        taskList.append(task)
        saveUpdatedTaskList()
        return taskList
    }
    
    func toggleTaskCompletion(task: Task) -> [Task] {
        let indexToToggle = taskList.firstIndex(of: task) ?? 0
        taskList[indexToToggle].isCompleted.toggle()
        saveUpdatedTaskList()
        return taskList
    }
    
    func deleteTask(task: Task) -> [Task] {
        let indexToRemove = taskList.firstIndex(of: task) ?? 0
        taskList.remove(at: indexToRemove)
        saveUpdatedTaskList()
        return taskList
    }
    
    func getCurrentDateSelectedTasks(of date: Date) -> [Task] {
        return taskList.filter { $0.date.toString(format: "EEE, dd.MM.yyyy") == date.toString(format: "EEE, dd.MM.yyyy")}.sorted{!$0.isCompleted && $1.isCompleted}
    }
    
}
