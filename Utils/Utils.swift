//
//  Utils.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 11/11/2024.
//

import Foundation

class Utils {
    class func jsonString<T: Codable>(from object: T) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let jsonData = try? encoder.encode(object) {
            return String(data: jsonData, encoding: .utf8)
        }
        
        return nil
    }

    class func getTransmisDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMddHHmmss"
        let date = Date()
        let dateNow = dateFormatter.string(from: date)
        
        return dateNow
    }

    class func getTimeLocalTrans() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmmss"
        let date = Date()
        let dateNow = dateFormatter.string(from: date)
        
        return dateNow
    }

    class func getDateLocalTrans() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMdd"
        let date = Date()
        let dateNow = dateFormatter.string(from: date)
        
        return dateNow
    }

    class func convertToDate(from transmisDateTime: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMddHHmmss"
        
        // Set the current calendar year for context
        dateFormatter.calendar = Calendar.current
        dateFormatter.defaultDate = Calendar.current.startOfDay(for: Date())
        
        return dateFormatter.date(from: transmisDateTime)
    }
}

