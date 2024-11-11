//
//  DateFormatter.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 16/08/2024.
//

import Foundation

class DateConverter {
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
}
