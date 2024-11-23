//
//  Buldle-Decodable.swift
//  MyResort
//
//  Created by Mantosh Kumar on 23/11/24.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Fail to loacate \(file) in the bundle.")
        }
         
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
         
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle. Key \(key) not found in \(context.debugDescription).")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Faild to decode \(file) from bundle due to type mismatch \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Faild to decode \(file) from bundle due to missing \(type) value - \(context.debugDescription)")
        } catch {
            fatalError("Fail to decode \(file) from buldle, it look invalid json")
        }
    }
}
