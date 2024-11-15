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

    class func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "vi_VN")
        dateFormatter.dateFormat = "HH:mm EEEE dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }

    class func currentMilliseconds() -> String {
        let currentTime = Date().timeIntervalSince1970
        let currentMilli = Int64(currentTime * 1000)
        
        return String(currentMilli)
    }
    
    class func reformatAmount(_ amount: String) -> String? {
        let cleanedAmount = amount.replacingOccurrences(of: ",", with: "")
        guard let amountValue = Double(cleanedAmount) else {
            return nil
        }
        
        let formattedValue = Int(amountValue * 100)
        
        return String(format: "%012d", formattedValue)
    }

    class func generateRandomTraceNo() -> String {
        return String(Int.random(in: 100000...999999))
    }
}

