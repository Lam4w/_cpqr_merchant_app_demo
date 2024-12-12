//
//  ReversalResponse.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 05/12/2024.
//

import Foundation

struct ReversalResponse: Codable {
    let payload: ReversalResponsePayload
    let signature: String
}

struct ReversalResponsePayload: Codable {
    let card: String
    let payment: ResponsePaymentInfo
    let device: DeviceInfo
    let original: OriginalInfo
    let result: ResultInfo
}
