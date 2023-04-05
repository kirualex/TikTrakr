//
//  ContentView.swift
//  TikTrakr
//
//  Created by Alexis Creuzot on 04/04/2023.

import SwiftUI
import Combine

class TimerListViewState: ObservableObject {
    @Published var timerList = TimerList()
    @Published var showingAddTimerSheet = false
    @Published var selectedTimer: TimerModel?
}

struct TimerListView: View {
    
    @StateObject private var state = TimerListViewState()

    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(state.timerList.timers.sorted(using: KeyPathComparator(\.startDate))) { timer in
                        TimerRow(timer: timer, selectedTimer: $state.selectedTimer)
                            .listRowSeparator(.hidden)
                            .sheet(item: $state.selectedTimer) { timer in
                                EditTimerView(timer: timer, timerList: state.timerList)
                            }
                    }
                    .onDelete(perform: { indexSet in
                        state.timerList.timers.remove(atOffsets: indexSet)
                    })
                }
                .navigationTitle("TikTrakr")
                .listStyle(PlainListStyle())
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        state.showingAddTimerSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    Spacer()
                }
            }
            .padding(.bottom)
            .sheet(isPresented: $state.showingAddTimerSheet) {
                AddTimerView(timerList: state.timerList)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimerListView()
    }
}
