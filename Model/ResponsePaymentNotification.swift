//
//  ResponsePaymentNotification.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 19/12/24.
//

import Foundation

struct ResponsePaymentNotification: Codable {
    let amount: String
    let transmisDate: String
    let status: Bool
}
