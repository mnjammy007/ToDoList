//
//  TasksHomePageViewModel.swift
//  ToDoList
//
//  Created by Apple on 30/01/25.
//

import Foundation

struct TasksHomePageConstants{
    
}

enum SliderTimeDirection {
    case future
    case past
    case unknown
}

protocol TasksHomePageViewModelInput{
    func selectTheDay(with date: Date)
    func onDateScrolled(to direction: SliderTimeDirection)
    func updateTaskList(task: Task)
    func toggleTaskCompletion(task: Task)
    func deleteTask(task: Task)
    
}

protocol TasksHomePageViewModelOutput{
    func getSelectedDate() -> Date
    func getCurrentSelectedDateTasks() -> [Task]
}

protocol TasksHomePageViewModelProtocol: ObservableObject, TasksHomePageViewModelInput, TasksHomePageViewModelOutput{}

class TasksHomePageViewModel: TasksHomePageViewModelProtocol{
    private let dateUseCase: DateUseCaseProtocol
    private let taskUseCase: TaskUseCaseProtocol
    
    @Published var items: [Task] = []
    @Published var weeks: [WeekModel] = []
    @Published var selectedDate: Date{
        didSet{
            calculatePastAndFutureWeeks(with: selectedDate)
        }
    }
    
    init(dateUseCase: DateUseCaseProtocol, taskUseCase: TaskUseCaseProtocol, with date: Date = Date()) {
        self.dateUseCase = dateUseCase
        self.taskUseCase = taskUseCase
        self.selectedDate = Calendar.current.startOfDay(for: date)
        calculatePastAndFutureWeeks(with: selectedDate)
        self.items = taskUseCase.getTaskList()
    }
    
    private func calculatePastAndFutureWeeks(with date: Date){
        weeks = dateUseCase.calculatePastAndFutureWeeks(with: date)
    }
    
}

// MARK: Input protocol implementation
extension TasksHomePageViewModel{
    func selectTheDay(with date: Date) {
        selectedDate = Calendar.current.startOfDay(for: date)
    }
    
    func onDateScrolled(to direction: SliderTimeDirection) {
        switch direction {
        case .future:
            selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
        case .past:
            selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate)!
        case .unknown:
            selectedDate = selectedDate
        }
        
        calculatePastAndFutureWeeks(with: selectedDate)
    }
    
    func updateTaskList(task: Task) {
        items = taskUseCase.updateTaskList(task: task)
    }
    
    func toggleTaskCompletion(task: Task) {
        items = taskUseCase.toggleTaskCompletion(task: task)
    }
    
    func deleteTask(task: Task) {
        items = taskUseCase.deleteTask(task: task)
    }
}

// MARK: Output protocol implementation
extension TasksHomePageViewModel{
    func getSelectedDate() -> Date {
        selectedDate
    }
    
    func getCurrentSelectedDateTasks() -> [Task] {
        taskUseCase.getCurrentDateSelectedTasks(of: selectedDate)
    }
}
