//
//  TimerList.swift
//  TikTrakr
//
//  Created by Alexis Creuzot on 04/04/2023.
//

import Foundation

class TimerList: ObservableObject {
    
    @Published var timers: [TimerModel] = FileManager.timersURL.jsonDecode() ?? [] {
        didSet {
            FileManager.timersURL.jsonSave(timers)
        }
    }

    private let saveKey = "Timers"
    
}
