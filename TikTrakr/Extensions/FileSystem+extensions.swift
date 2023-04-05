//
//  Constants.swift
//  vault
//
//  Created by Alexis Creuzot on 17/06/2019.
//  Copyright © 2019 alexiscreuzot. All rights reserved.
//

import Foundation

extension FileManager {
    static var documentsDirectoryURL : URL = FileManager.default.urls(for:.documentDirectory, in:.userDomainMask).first!
    static let timersURL: URL = documentsDirectoryURL.appendingPathComponent("timers.json")
}

extension URL {
    func jsonDecode<T : Decodable>() -> T? {
        do {
            let data = try Data(contentsOf: self)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("\(error.localizedDescription)")
            return nil
        }
    }
    
    func jsonSave<T : Encodable>(_ object : T){
        do {
            try object.save(at: FileManager.timersURL)
        } catch {
            print("\(error.localizedDescription)")
        }
    }
}
