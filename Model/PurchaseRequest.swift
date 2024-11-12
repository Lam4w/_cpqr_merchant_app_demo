//
//  PurchaseRequest.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 11/11/2024.
//

import Foundation

struct PurchaseRequest: Codable {
    let payload: PurchaseRequestPayload
}

struct PurchaseRequestPayload: Codable {
    let card: String
    let payment: RequestPaymentInfo
    let device: DeviceInfo
}
