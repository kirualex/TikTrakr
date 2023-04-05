//
//  Codable+Extensions.swift
//  Forum-iOS
//
//  Created by Alexis Creuzot on 14/07/2022.
//

import Foundation

extension Encodable  {
    
    func toJSON() -> String? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let encodedData = try encoder.encode(self)
            return String(data: encodedData, encoding: .utf8)
        } catch {
            print(error)
            return nil
        }
    }
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    public func save(at url: URL) throws {
        if let jsonString = toJSON() {
            try jsonString.write(to: url,
                                 atomically: true,
                                 encoding: .utf8)
        } else {
            let userInfo = [NSLocalizedDescriptionKey : "Could not encode \(self.self)"]
            let error = NSError.init(domain: "foundation", code: -123, userInfo: userInfo)
            throw error
        }
    }
}
