//
//  NewTaskView.swift
//  ToDoList
//
//  Created by Apple on 29/01/25.
//

import Foundation
import SwiftUI

struct NewTaskView: View {
    var saveTask: (Task) -> Void
    @Environment(\.dismiss) var dismiss
    @State private var taskTitle: String = ""
    @State private var taskDate: Date = .init()

    var body: some View {
        VStack {

            Text("Add new task")
                .fontDesign(.rounded)
                .font(.title2)
                .padding(30)
                .frame(maxWidth: .infinity)
                .background {
                    Rectangle()
                        .fill(.gray.opacity(0.2))
                        .clipShape(
                            .rect(
                                bottomLeadingRadius: 30,
                                bottomTrailingRadius: 30
                            )
                        )
                }

            VStack(spacing: 30) {
                TextField("Your task title", text: $taskTitle)
                    .padding(.top)

                HStack(alignment: .center, spacing: 20) {
                    Text("Timeline")
                        .font(.title3)
                    DatePicker(
                        "",
                        selection: $taskDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)
                }
            }
            .padding(30)

            Button {
                let trimmedString = taskTitle.trimmingCharacters(
                    in: .whitespaces
                )
                if trimmedString != "" {
                    saveTask(Task(title: trimmedString, date: taskDate))
                }
                dismiss()
            } label: {
                Text("Create Task")
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .foregroundColor(.white)
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding(.horizontal, 30)
            }

            Spacer()

        }
    }
}

#Preview {
    NewTaskView { task in

    }
}
