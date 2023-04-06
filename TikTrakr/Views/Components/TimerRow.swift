//
//  TimerRow.swift
//  TikTrakr
//
//  Created by Alexis Creuzot on 04/04/2023.
//

import Foundation
import SwiftUI

import SwiftUI
import SwiftUI

struct TimerRow: View {
    let timer: TimerModel

    @Binding var selectedTimer: TimerModel?
    @State private var elapsedTime = ""

    private let timerFormatter = createTimerFormatter()

    var body: some View {
        HStack {
            timerStateIcon
                .foregroundColor(isPastDate ? .orange : .blue)
                .padding(.trailing, 8)

            VStack(alignment: .leading, spacing: 8) {
                timerTitleText
                elapsedTimeText
            }

            Spacer()
        }
        .padding()
        .background( RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray6))
                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                    )
        .onTapGesture { selectedTimer = timer }
        .onAppear(perform: setupElapsedTimeUpdater)
    }
}

private extension TimerRow {
    static func createTimerFormatter() -> RelativeDateTimeFormatter {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }

    var timerStateIcon: some View {
        Image(systemName: isPastDate ? "timer" : "hourglass")
            .font(.system(size: isPastDate ? 24 : 30, weight: .regular))
    }

    var timerTitleText: some View {
        Text(timer.title)
            .font(.system(size: 18, weight: .semibold))
    }

    var elapsedTimeText: some View {
        Text(elapsedTime)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(isPastDate ? .orange : .blue)
    }

    var isPastDate: Bool {
        timer.startDate < Date()
    }

    func setupElapsedTimeUpdater() {
        updateTimeElapsed()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            updateTimeElapsed()
        }
    }

    func updateTimeElapsed() {
        elapsedTime = timerFormatter.localizedString(for: timer.startDate, relativeTo: Date())
    }
}



struct TimerRow_Previews: PreviewProvider {
    static var previews: some View {
        TimerRow(timer: TimerModel(title: "Sample Timer", startDate: Date(timeIntervalSinceNow: -3600)), selectedTimer: .constant(nil))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
