//
//  Utils.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 11/11/2024.
//

import Foundation

func jsonString<T: Codable>(from object: T) -> String? {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    if let jsonData = try? encoder.encode(object) {
        return String(data: jsonData, encoding: .utf8)
    }
    
    return nil
}
