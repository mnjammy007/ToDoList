//
//  DateHeaderView.swift
//  ToDoList
//
//  Created by Apple on 29/01/25.
//

import SwiftUI

struct DateHeaderView: View {
    @ObservedObject var viewModel: TasksHomePageViewModel
    
    var body: some View {
        ZStack {
            VStack {
                nameHeaderTextView()
                DateSliderView(viewModel: viewModel) { week in
                    DateView(viewModel: viewModel, week: week)
                }
                .frame(height: 60, alignment: .top)
                Divider()
                HStack{}
            }
        }
    }
    
    @ViewBuilder
    private func nameHeaderTextView() -> some View{
        HStack{
            VStack(alignment: .listRowSeparatorLeading, spacing: 0){
                Text("Hi, Nasir")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(4)
                
                Text(viewModel.selectedDate == Calendar.current.startOfDay(for: Date()) ?  "What's up for today" : "Planing for future?")
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundColor(.black)
                    .padding(4)
            }
            Spacer()
            VStack(alignment: .trailing){
                Text(viewModel.selectedDate.monthToString())
                    .font(.system(size: 10, weight: .heavy))
                    .foregroundColor(.black)
                
                Button {
                    withAnimation(.linear(duration: 0.1)) {
                        viewModel.selectTheDay(with: Date())
                    }
                } label: {
                    Text("Today")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(4)
                        .background(.black)
                        .cornerRadius(4)
                }
                
            }
        }
    }
}

#Preview {
    DateHeaderView(viewModel: TasksHomePageViewModel(dateUseCase: DateUseCase(dateRepository: DateRepository(dateDataProvider: DateDataProvider())), taskUseCase: TaskUseCase(taskRepository: TaskRepository(taskDataProvider: TaskDataProvider()))))
}
