//
//  TimerRow.swift
//  TikTrakr
//
//  Created by Alexis Creuzot on 04/04/2023.
//

import Foundation
import SwiftUI

struct TimerRow: View {
    let timer: TimerModel
    
    @Binding var selectedTimer: TimerModel?
    @State private var elapsedTime = ""

    let timerFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }()
    
    private func isPastDate() -> Bool {
        return timer.startDate < Date()
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(timer.title)
                    .font(.headline)
                Text(elapsedTime)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(isPastDate() ? .orange : .blue)

            }
            Spacer()
        }
        .buttonStyle(BorderlessButtonStyle())
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
        .onTapGesture {
            selectedTimer = timer
        }
        .onAppear {
            updateTimeElapsed()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                updateTimeElapsed()
            }
        }
    }

    private func updateTimeElapsed() {
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
