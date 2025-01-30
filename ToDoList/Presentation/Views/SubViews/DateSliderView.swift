//
//  DateSliderView.swift
//  ToDoList
//
//  Created by Apple on 29/01/25.
//

import SwiftUI

struct DateSliderView<DateViewContent: View>: View {
    @ObservedObject var viewModel: TasksHomePageViewModel
    @State private var activeTab:Int = 1
    @State private var position = CGSize.zero
    @GestureState private var dragOffset = CGSize.zero
    @State private var direction: SliderTimeDirection = .unknown
    
    let dateViewContent: (_ week: WeekModel) -> DateViewContent
    
    init(viewModel: TasksHomePageViewModel, @ViewBuilder dateViewContent: @escaping (_ week: WeekModel) -> DateViewContent) {
        self.viewModel = viewModel
        self.dateViewContent = dateViewContent
    }
    
    var body: some View {
        TabView(selection: $activeTab) {
            dateViewContent(viewModel.weeks[0])
                .frame(maxWidth: .infinity)
                .tag(0)
            
            dateViewContent(viewModel.weeks[1])
                .frame(maxWidth: .infinity)
                .tag(1)
                .onDisappear {
                    guard direction != .unknown else {return}
                    viewModel.onDateScrolled(to: direction)
                    direction = .unknown
                    activeTab = 1
                }
            
            dateViewContent(viewModel.weeks[2])
                .frame(maxWidth: .infinity)
                .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onChange(of: activeTab) { _, value in
            if value == 0{
                direction = .past
            }else if value == 2{
                direction = .future
            }
        }
    }
}

#Preview {
    let viewModel = TasksHomePageViewModel(dateUseCase: DateUseCase(dateRepository: DateRepository(dateDataProvider: DateDataProvider())), taskUseCase: TaskUseCase(taskRepository: TaskRepository(taskDataProvider: TaskDataProvider())))
    
    DateSliderView(viewModel: viewModel){week in
        DateView(viewModel: viewModel,week: week)
    }
}
