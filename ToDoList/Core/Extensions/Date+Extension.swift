//
//  Date+Extension.swift
//  ToDoList
//
//  Created by Apple on 29/01/25.
//

import Foundation

extension Date {
    func monthToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: self)
    }

    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = format

        return dateFormatter.string(from: self)
    }

    var yesterday: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }

    var tomorrow: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
}
