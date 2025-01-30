//
//  DateRepository.swift
//  ToDoList
//
//  Created by Apple on 30/01/25.
//

import Foundation

protocol DateRepositoryProtocol{
    func calculatePastAndFutureWeeks(with date: Date) -> [WeekModel]
}

class DateRepository{
    private let dateDataProvider: DateDataProviderProtocol
    init(dateDataProvider: DateDataProviderProtocol) {
        self.dateDataProvider = dateDataProvider
    }
}

extension DateRepository: DateRepositoryProtocol{
    func calculatePastAndFutureWeeks(with date: Date) -> [WeekModel] {
        return dateDataProvider.calculatePastAndFutureWeeks(with: date)
    }
    
    
}
