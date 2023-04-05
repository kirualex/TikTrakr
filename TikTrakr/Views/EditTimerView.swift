//
//  EditTimerView.swift
//  TikTrakr
//
//  Created by Alexis Creuzot on 04/04/2023.
//

import SwiftUI
import Combine

class EditTimerViewState: ObservableObject {
    @Published var title: String
    @Published var startDate: Date
    @ObservedObject var timerList: TimerList
    @ObservedObject var timer: TimerModel

    init(timer: TimerModel, timerList: TimerList) {
        self.title = timer.title
        self.startDate = timer.startDate
        self.timerList = timerList
        self.timer = timer
    }
}
struct EditTimerView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var state: EditTimerViewState

    init(timer: TimerModel, timerList: TimerList) {
        _state = StateObject(wrappedValue: EditTimerViewState(timer: timer, timerList: timerList))
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Timer Title")) {
                    TextField("Enter Timer Title", text: $state.title)
                }

                Section(header: Text("Start Date")) {
                    DatePicker("Select Start Date", selection: $state.startDate, displayedComponents: [.date, .hourAndMinute])
                }
            }
            .navigationTitle("Edit Timer")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveChanges()
                        presentationMode.wrappedValue.dismiss()
                    }.disabled(state.title.isEmpty)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

    private func saveChanges() {
        state.timerList.timers.firstIndex(where: { $0.id == state.timer.id }).map { index in
            state.timerList.timers[index].title = state.title
            state.timerList.timers[index].startDate = state.startDate
        }
    }

}
