//
//  TimerModel.swift
//  TikTrakr
//
//  Created by Alexis Creuzot on 04/04/2023.
//

import Foundation

class TimerModel: Codable, Identifiable, ObservableObject, Equatable {
    
    static func == (lhs: TimerModel, rhs: TimerModel) -> Bool {
        lhs.id == rhs.id
    }

    @Published var title: String
    @Published var startDate: Date

    let id: UUID
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case startDate
    }
    
    init(title: String, startDate: Date, id: UUID = UUID()) {
        self.title = title
        self.startDate = startDate
        self.id = id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        startDate = try container.decode(Date.self, forKey: .startDate)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(startDate, forKey: .startDate)
    }
}
