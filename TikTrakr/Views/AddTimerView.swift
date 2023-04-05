//
//  AddTimerView.swift
//  TikTrakr
//
//  Created by Alexis Creuzot on 04/04/2023.
//

import SwiftUI
import Combine

class AddTimerViewState: ObservableObject {
    @Published var title: String = ""
    @Published var startDate: Date = Date()
    @ObservedObject var timerList: TimerList

    init(timerList: TimerList) {
        self.timerList = timerList
    }
}

struct AddTimerView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var state: AddTimerViewState

    init(timerList: TimerList) {
        _state = StateObject(wrappedValue: AddTimerViewState(timerList: timerList))
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
            .navigationTitle("Add Timer")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addNewTimer()
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

    private func addNewTimer() {
        let newTimer = TimerModel(title: state.title, startDate: state.startDate)
        state.timerList.timers.append(newTimer)
    }
}

