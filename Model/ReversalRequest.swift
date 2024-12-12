//
//  ReversalRequest.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 05/12/2024.
//

import Foundation

struct ReversalRequest: Codable {
    let payload: ReversalRequestPayload
    let signature: String
}

struct ReversalRequestPayload: Codable {
    let card: String
    let payment: RequestPaymentInfo
    let device: DeviceInfo
    let original: OriginalInfo
}
