//
//  DateUseCase.swift
//  ToDoList
//
//  Created by Apple on 30/01/25.
//

import Foundation

protocol DateUseCaseProtocol {
    func calculatePastAndFutureWeeks(with date: Date) -> [WeekModel]
}

class DateUseCase {
    private let dateRepository: DateRepositoryProtocol
    init(dateRepository: DateRepositoryProtocol) {
        self.dateRepository = dateRepository
    }
}

extension DateUseCase: DateUseCaseProtocol {
    func calculatePastAndFutureWeeks(with date: Date) -> [WeekModel] {
        dateRepository.calculatePastAndFutureWeeks(with: date)
    }
}
