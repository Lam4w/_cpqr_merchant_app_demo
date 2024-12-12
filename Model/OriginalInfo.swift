//
//  OriginalInfo.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 05/12/2024.
//

import Foundation

struct OriginalInfo: Codable {
    let originalData: String
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case originalData = "original_data"
        case count = "count"
    }
}
