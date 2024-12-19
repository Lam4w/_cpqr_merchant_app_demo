//
//  PurchaseResponse.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 08/11/2024.
//

import Foundation

struct GenerateQrResponse: Codable {
    let payload: GenerateQrResponsePayload
}

struct GenerateQrResponsePayload: Codable {
    let qr: String
}
