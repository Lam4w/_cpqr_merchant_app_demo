//
//  PurchaseResponse.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 08/11/2024.
//

import Foundation

struct PurchaseResponse: Codable {
    let payload: PurchaseResponsePayload
}

struct PurchaseResponsePayload: Codable {
    let card: String
    let payment: ResponsePaymentInfo
    let device: DeviceInfo
    let result: ResultInfo
}
