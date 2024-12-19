//
//  GenerateQrResponse.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 19/12/24.
//

import Foundation

struct GenerateQrResponse: Codable {
    let payload: GenerateQrResponsePayload
}

struct GenerateQrResponsePayload: Codable {
    let qr: String
}
