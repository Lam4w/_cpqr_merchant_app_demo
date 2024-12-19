//
//  NotificationQrResponse.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 19/12/24.
//

import Foundation

struct NotificationQrResponse: Codable {
    let payload: NotificationQrResponsePayload
}

struct NotificationQrResponsePayload: Codable {
    let payment: ResponsePaymentNotification
}
