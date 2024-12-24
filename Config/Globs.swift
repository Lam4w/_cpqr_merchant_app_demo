//
//  PAT.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 16/08/2024.
//

import SwiftUI

struct Path {
//    static let BASE_URL = "http://157.66.47.55:56660"
    static let BASE_URL = "https://a00a-118-70-73-127.ngrok-free.app"
//    static let BASE_URL = "https://8a1a0a73-5fe4-4a98-bfe7-409bd4b9db3d.mock.pstmn.io"
     
    static let PURCHASE = BASE_URL + "/api/purchase"
    static let REVERSAL = BASE_URL + "/api/reversal"
    static let GET_QR = BASE_URL + "/api/qr"
    static let GET_NOTI_PURCHASE = BASE_URL + "/api/qr/noti"
}
