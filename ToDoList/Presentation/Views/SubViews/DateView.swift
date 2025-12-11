//
//  DateView.swift
//  ToDoList
//
//  Created by Apple on 29/01/25.
//

import SwiftUI

struct DateView: View {
    @ObservedObject var viewModel: TasksHomePageViewModel
    var week: WeekModel

    var body: some View {
        HStack {
            ForEach(0..<7) { dayIndex in
                VStack {
                    Text(
                        week.dates[dayIndex].toString(format: "EEE")
                            .uppercased()
                    )
                    .font(
                        .system(
                            size: 10,
                            weight: week.dates[dayIndex] == week.referenceDate
                                ? .semibold : .light
                        )
                    )
                    .foregroundColor(
                        week.dates[dayIndex] == week.referenceDate
                            ? .white : .black
                    )
                    .frame(maxWidth: .infinity)

                    Spacer()
                        .frame(height: 4)

                    Text(week.dates[dayIndex].toString(format: "d"))
                        .font(
                            .system(
                                size: 16,
                                weight: week.dates[dayIndex]
                                    == week.referenceDate ? .bold : .light
                            )
                        )
                        .frame(maxWidth: .infinity)
                        .foregroundColor(
                            week.dates[dayIndex] == week.referenceDate
                                ? .white : .black
                        )
                }
                .frame(maxWidth: .infinity)
                .padding(5)
                .background(
                    week.dates[dayIndex] == week.referenceDate ? .black : .clear
                )
                .clipShape(.rect(cornerRadius: 10))
                .onTapGesture {
                    withAnimation(.linear(duration: 0.1)) {
                        viewModel.selectTheDay(with: week.dates[dayIndex])
                    }
                }
            }
        }
    }
}

#Preview {
    let viewModel = TasksHomePageViewModel(
        dateUseCase: DateUseCase(
            dateRepository: DateRepository(dateDataProvider: DateDataProvider())
        ),
        taskUseCase: TaskUseCase(
            taskRepository: TaskRepository(taskDataProvider: TaskDataProvider())
        )
    )

    DateView(
        viewModel: viewModel,
        week: .init(
            index: 1,
            dates: [
                Date().yesterday.yesterday.yesterday,
                Date().yesterday.yesterday,
                Date().yesterday,
                Date(),
                Date().tomorrow,
                Date().tomorrow.tomorrow,
                Date().tomorrow.tomorrow.tomorrow,
            ],
            referenceDate: Date()
        )
    )
}
